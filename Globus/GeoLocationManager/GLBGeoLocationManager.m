/*--------------------------------------------------*/

#import "GLBGeoLocationManager.h"
#import "UIDevice+GLBUI.h"

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/
typedef void(^GLBGeoLocationManagerPrefornBlock)();
/*--------------------------------------------------*/

@interface GLBGeoLocationManager () < CLLocationManagerDelegate > {
    CLLocationManager* _locationManager;
    CLLocation* _defaultLocation;
    CLLocation* _currentLocation;
    NSMutableArray* _requests;
    BOOL _updatingLocation;
    CLAuthorizationStatus _authorizationStatus;
    NSError* _lastError;
}

+ (void)_perform:(dispatch_block_t)block;

- (void)_startUpdatingIfNeeded;
- (void)_stopUpdatingIfPossible;
- (GLBGeoLocationRequest*)_addRequest:(GLBGeoLocationRequest*)request;
- (void)_removeRequest:(GLBGeoLocationRequest*)request;
- (void)_processRequests;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface GLBGeoLocationRequest () {
    __weak id< GLBGeoLocationRequestDelegate > _delegate;
    CLLocationAccuracy _desiredAccuracy;
    NSTimeInterval _timeoutInterval;
    NSTimeInterval _updateInterval;
    BOOL _subscription;
    BOOL _canceled;
    
    NSDate* _requestStartTime;
    NSTimer* _timer;
}

- (instancetype)initWithDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy
                        timeoutInterval:(NSTimeInterval)timeoutInterval
                                success:(GLBAction*)success
                                failure:(GLBAction*)failure;

- (instancetype)initWithDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy
                         updateInterval:(NSTimeInterval)updateInterval
                                success:(GLBAction*)success
                                failure:(GLBAction*)failure;

- (void)_start;
- (void)_stop;
- (void)_cancel;

- (void)_triggeredTimeoutTimer;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBGeoLocationManager

#pragma mark - Synthesize

@synthesize defaultLocation = _defaultLocation;
@synthesize currentLocation = _currentLocation;
@synthesize requests = _requests;
@synthesize updatingLocation = _updatingLocation;

#pragma mark - Init / Free

- (instancetype)init {
    self = [super init];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _locationManager = [CLLocationManager new];
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _requests = [NSMutableArray array];
    _authorizationStatus = CLLocationManager.authorizationStatus;
}

#pragma mark - Static

+ (GLBGeoLocationServicesState)servicesState {
    if(CLLocationManager.locationServicesEnabled == NO) {
        return GLBGeoLocationServicesStateDisabled;
    } else if(CLLocationManager.authorizationStatus == kCLAuthorizationStatusNotDetermined) {
        return GLBGeoLocationServicesStateNotDetermined;
    } else if (CLLocationManager.authorizationStatus == kCLAuthorizationStatusDenied) {
        return GLBGeoLocationServicesStateDenied;
    } else if (CLLocationManager.authorizationStatus == kCLAuthorizationStatusRestricted) {
        return GLBGeoLocationServicesStateRestricted;
    }
    return GLBGeoLocationServicesStateAvailable;
}

+ (instancetype)shared {
    static id shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [self new];
    });
    return shared;
}

#pragma mark - Property

#if defined(GLB_TARGET_IOS)

- (void)setAllowsBackgroundUpdates:(BOOL)allowsBackgroundUpdates {
    if(UIDevice.glb_systemVersion >= 9.0f) {
        _locationManager.allowsBackgroundLocationUpdates = allowsBackgroundUpdates;
    }
}

- (BOOL)allowsBackgroundUpdates {
    if(UIDevice.glb_systemVersion >= 9.0f) {
        return _locationManager.allowsBackgroundLocationUpdates;
    }
    return YES;
}

#endif

- (CLLocation*)currentLocation {
    if(_currentLocation == nil) {
        return _defaultLocation;
    }
    return _currentLocation;
}

#pragma mark - Public

- (GLBGeoLocationRequest*)requestWithDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy
                                             success:(GLBAction*)success
                                             failure:(GLBAction*)failure {
    return [self requestWithDesiredAccuracy:desiredAccuracy
                            timeoutInterval:0.0f
                                    success:success
                                    failure:failure];
}

- (GLBGeoLocationRequest*)requestWithDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy
                                     timeoutInterval:(NSTimeInterval)timeoutInterval
                                             success:(GLBAction*)success
                                             failure:(GLBAction*)failure {
    GLBGeoLocationRequest* request = [[GLBGeoLocationRequest alloc] initWithDesiredAccuracy:desiredAccuracy
                                                                            timeoutInterval:timeoutInterval
                                                                                    success:success
                                                                                    failure:failure];
    return [self _addRequest:request];
}

- (GLBGeoLocationRequest*)subscribeWithDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy
                                               success:(GLBAction*)success
                                               failure:(GLBAction*)failure {
    return [self subscribeWithDesiredAccuracy:desiredAccuracy
                               updateInterval:0.0f
                                     success:success
                                      failure:failure];
}

- (GLBGeoLocationRequest*)subscribeWithDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy
                                        updateInterval:(NSTimeInterval)updateInterval
                                               success:(GLBAction*)success
                                               failure:(GLBAction*)failure {
    GLBGeoLocationRequest* request = [[GLBGeoLocationRequest alloc] initWithDesiredAccuracy:desiredAccuracy
                                                                             updateInterval:updateInterval
                                                                                    success:success
                                                                                    failure:failure];
    return [self _addRequest:request];
}

- (void)cancelRequest:(GLBGeoLocationRequest*)request {
    [self.class _perform:^{
        [request _cancel];
        [self _removeRequest:request];
        if(_lastError != nil) {
            [request.actionFailure performWithArguments:@[ request, _lastError ]];
        } else {
            [request.actionFailure performWithArguments:@[ request ]];
        }
    }];
}

- (void)cancelAllRequests {
    [self.class _perform:^{
        [_requests enumerateObjectsUsingBlock:^(GLBGeoLocationRequest* request, NSUInteger index, BOOL* stop) {
            [self cancelRequest:request];
        }];
    }];
}

- (void)geocodeAddressString:(NSString*)address block:(CLGeocodeCompletionHandler)block {
    if(block != nil) {
        CLGeocoder* geocoder = [CLGeocoder new];
        [geocoder geocodeAddressString:address completionHandler:^(NSArray* placemarks, NSError* error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                block(placemarks, error);
            });
        }];
    }
}

- (void)reverseGeocodeLocation:(CLLocation*)location block:(CLGeocodeCompletionHandler)block {
    if(block != nil) {
        CLGeocoder* geocoder = [CLGeocoder new];
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray* placemarks, NSError* error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                block(placemarks, error);
            });
        }];
    }
}

#pragma mark - Private

+ (void)_perform:(dispatch_block_t)block {
    if(NSThread.isMainThread == YES) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

- (void)_startUpdatingIfNeeded {
#if defined(GLB_TARGET_IOS)
#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0)
    if(UIDevice.glb_systemVersion >= 8.0f) {
        switch(CLLocationManager.authorizationStatus) {
            case kCLAuthorizationStatusNotDetermined: {
                BOOL hasAlwaysKey = ([NSBundle.mainBundle objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"] != nil);
                BOOL hasWhenInUseKey = ([NSBundle.mainBundle objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"] != nil);
                if(hasAlwaysKey == YES) {
                    [_locationManager requestAlwaysAuthorization];
                } else if(hasWhenInUseKey == YES) {
                    [_locationManager requestWhenInUseAuthorization];
                } else {
                    NSAssert((hasAlwaysKey == YES) || (hasWhenInUseKey == YES), @"To use location services in iOS 8+, your Info.plist must provide a value for either NSLocationWhenInUseUsageDescription or NSLocationAlwaysUsageDescription.");
                }
                break;
            }
            default: break;
        }
    }
#endif
    if((_requests.count > 0) && (_updatingLocation == NO)) {
        _updatingLocation = YES;
        _locationManager.delegate = self;
        [_locationManager startUpdatingLocation];
    }
#elif defined(GLB_TARGET_WATCHOS)
    switch(CLLocationManager.authorizationStatus) {
        case kCLAuthorizationStatusNotDetermined: {
            BOOL hasAlwaysKey = ([NSBundle.mainBundle objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"] != nil);
            BOOL hasWhenInUseKey = ([NSBundle.mainBundle objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"] != nil);
            if(hasAlwaysKey == YES) {
                [_locationManager requestAlwaysAuthorization];
            } else if(hasWhenInUseKey == YES) {
                [_locationManager requestWhenInUseAuthorization];
            } else {
                NSAssert((hasAlwaysKey == YES) || (hasWhenInUseKey == YES), @"To use location services in iOS 8+, your Info.plist must provide a value for either NSLocationWhenInUseUsageDescription or NSLocationAlwaysUsageDescription.");
            }
            break;
        }
        default: break;
    }
    if((_requests.count > 0) && (_updatingLocation == NO)) {
        _updatingLocation = YES;
        [_locationManager requestLocation];
    }
#endif
}

- (void)_stopUpdatingIfPossible {
    if((_requests.count < 1) && (_updatingLocation == YES)) {
        [_locationManager stopUpdatingLocation];
        _locationManager.delegate = nil;
        _updatingLocation = NO;
    }
}

- (GLBGeoLocationRequest*)_addRequest:(GLBGeoLocationRequest*)request {
    switch(self.class.servicesState) {
        case GLBGeoLocationServicesStateDisabled:
        case GLBGeoLocationServicesStateDenied:
        case GLBGeoLocationServicesStateRestricted: {
            if(_lastError == nil) {
                _lastError = [NSError errorWithDomain:kCLErrorDomain code:kCLErrorDenied userInfo:nil];
            }
            [request.actionFailure performWithArguments:@[ request, _lastError ]];
            return nil;
        }
        default:
            break;
    }
    [_requests addObject:request];
    [self.class _perform:^{
        [self _startUpdatingIfNeeded];
    }];
    return request;
}

- (void)_removeRequest:(GLBGeoLocationRequest*)request {
    [_requests removeObject:request];
    [self _stopUpdatingIfPossible];
}

- (void)_processRequests {
    CLLocation* currentLocation = self.currentLocation;
    [_requests enumerateObjectsUsingBlock:^(GLBGeoLocationRequest* request, NSUInteger index, BOOL* stop) {
        if(request.hasTimedOut == YES) {
            [request _stop];
            [self _removeRequest:request];
            if(_lastError != nil) {
                [request.actionFailure performWithArguments:@[ request, _lastError ]];
            } else {
                [request.actionFailure performWithArguments:@[ request ]];
            }
        } else if(currentLocation != nil) {
            CLLocationAccuracy desiredAccuracy = MAX(currentLocation.horizontalAccuracy, currentLocation.verticalAccuracy);
            NSTimeInterval timeSinceUpdate = ABS(currentLocation.timestamp.timeIntervalSinceNow);
            if((desiredAccuracy > request.desiredAccuracy) || (timeSinceUpdate > request.updateInterval)) {
                if(request.isSubscription == NO) {
                    [request _stop];
                    [self _removeRequest:request];
                }
                [request.actionSuccess performWithArguments:@[ request, currentLocation ]];
            }
        }
    }];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager*)manager didUpdateLocations:(NSArray*)locations {
    [self.class _perform:^{
        _currentLocation = [locations lastObject];
        [self _processRequests];
    }];
}

- (void)locationManager:(CLLocationManager*)manager didFailWithError:(NSError*)error {
    [self.class _perform:^{
        _lastError = error;
        [self cancelAllRequests];
    }];
}

- (void)locationManager:(CLLocationManager*)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    [self.class _perform:^{
        switch(status) {
            case kCLAuthorizationStatusDenied:
            case kCLAuthorizationStatusRestricted: {
                _lastError = [NSError errorWithDomain:kCLErrorDomain code:kCLErrorDenied userInfo:nil];
                [self cancelAllRequests];
                if(_authorizationStatus == kCLAuthorizationStatusNotDetermined) {
                    [NSNotificationCenter.defaultCenter postNotificationName:GLBGeoLocationManagerUserDenied object:self];
                    _authorizationStatus = status;
                }
                break;
            }
            case kCLAuthorizationStatusAuthorizedAlways:
            case kCLAuthorizationStatusAuthorizedWhenInUse: {
                for(GLBGeoLocationRequest* request in _requests) {
                    [request _start];
                }
                break;
            }
            default:
                break;
        }
    }];
}

@end

/*--------------------------------------------------*/

NSString* GLBGeoLocationManagerUserDenied = @"GLBGeoLocationManagerUserDenied";

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBGeoLocationRequest

#pragma mark - Synthesize

@synthesize actionSuccess = _actionSuccess;
@synthesize actionFailure = _actionFailure;
@synthesize desiredAccuracy = _desiredAccuracy;
@synthesize timeoutInterval = _timeoutInterval;
@synthesize updateInterval = _updateInterval;
@synthesize subscription = _subscription;
@synthesize canceled = _canceled;

#pragma mark - Init / Free

- (instancetype)initWithDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy
                        timeoutInterval:(NSTimeInterval)timeoutInterval
                                success:(GLBAction*)success
                                failure:(GLBAction*)failure {
    self = [super init];
    if(self != nil) {
        _actionSuccess = success;
        _actionFailure = failure;
        _desiredAccuracy = desiredAccuracy;
        _timeoutInterval = timeoutInterval;
        _subscription = NO;
    }
    return self;
}

- (instancetype)initWithDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy
                         updateInterval:(NSTimeInterval)updateInterval
                                success:(GLBAction*)success
                                failure:(GLBAction*)failure {
    self = [super init];
    if(self != nil) {
        _actionSuccess = success;
        _actionFailure = failure;
        _desiredAccuracy = desiredAccuracy;
        _updateInterval = updateInterval;
        _subscription = YES;
    }
    return self;
}

- (void)dealloc {
    if(_timer != nil) {
        [_timer invalidate];
    }
}

#pragma mark - Public

- (BOOL)hasTimedOut {
    if(_timeoutInterval > FLT_EPSILON) {
        NSTimeInterval aliveInterval = FLT_EPSILON;
        if(_requestStartTime != nil) {
            aliveInterval = ABS(_requestStartTime.timeIntervalSinceNow);
        }
        if(aliveInterval >= _timeoutInterval) {
            return YES;
        }
    }
    return NO;
}
    
#pragma mark - Public
    
- (void)cancel {
    [GLBGeoLocationManager.shared cancelRequest:self];
}

#pragma mark - Private

- (void)_start {
    if(_timeoutInterval > FLT_EPSILON) {
        if(_timer == nil) {
            _requestStartTime = [NSDate date];
            _timer = [NSTimer scheduledTimerWithTimeInterval:_timeoutInterval
                                                      target:self
                                                    selector:@selector(_triggeredTimeoutTimer)
                                                    userInfo:nil
                                                     repeats:NO];
        }
    }
}

- (void)_stop {
    if(_timer != nil) {
        [_timer invalidate];
        _timer = nil;
    }
    _requestStartTime = nil;
}

- (void)_cancel {
    [self _stop];
    _canceled = YES;
}

- (void)_triggeredTimeoutTimer {
    if(_timer != nil) {
        [_timer invalidate];
        _timer = nil;
    }
    [GLBGeoLocationManager.shared _processRequests];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation NSError (GLBGeoLocation)

- (BOOL)glb_isGeoLocation {
    return ([self.domain isEqualToString:kCLErrorDomain] == YES);
}

- (BOOL)glb_geoLocationUnknown {
    return (self.glb_isGeoLocation == YES) && (self.code == kCLErrorLocationUnknown);
}

- (BOOL)glb_geoLocationAccessDenied {
    return (self.glb_isGeoLocation == YES) && (self.code == kCLErrorDenied);
}

- (BOOL)glb_geoLocationNetwork {
    return (self.glb_isGeoLocation == YES) && (self.code == kCLErrorNetwork);
}

@end

/*--------------------------------------------------*/
