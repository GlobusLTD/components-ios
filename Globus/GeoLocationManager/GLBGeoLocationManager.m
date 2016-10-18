/*--------------------------------------------------*/

#import "GLBGeoLocationManager.h"

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface GLBGeoLocationManager () < CLLocationManagerDelegate > {
    CLLocationManager* _locationManager;
    NSMutableArray* _requests;
    BOOL _updatingLocation;
#if defined(GLB_TARGET_IOS)
    BOOL _startedMonitoringSignificantLocationChanges;
#endif
    BOOL _startedUpdatingLocation;
    CLAuthorizationStatus _authorizationStatus;
    NSError* _lastError;
}

+ (void)_perform:(dispatch_block_t)block;

- (void)_startUpdatingIfNeeded;
- (void)_stopUpdatingIfPossible;
- (GLBGeoLocationRequest*)_addRequest:(GLBGeoLocationRequest*)request;
- (void)_removeRequest:(GLBGeoLocationRequest*)request;
- (void)_processRequests:(CLLocation*)location;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface GLBGeoLocationRequest () {
    __weak GLBGeoLocationManager* _geoLocationManager;
    BOOL _subscription;
    BOOL _canceled;
    
    NSDate* _requestStartTime;
    NSTimer* _timer;
}

@property(nonatomic, readonly, strong) GLBAction* actionSuccess;
@property(nonatomic, readonly, strong) GLBAction* actionFailure;

- (instancetype)initWithGeoLocationManager:(GLBGeoLocationManager*)geoLocationManager
                           desiredAccuracy:(CLLocationAccuracy)desiredAccuracy
                           timeoutInterval:(NSTimeInterval)timeoutInterval
                                   success:(GLBAction*)success
                                   failure:(GLBAction*)failure;

- (instancetype)initWithGeoLocationManager:(GLBGeoLocationManager*)geoLocationManager
                           desiredAccuracy:(CLLocationAccuracy)desiredAccuracy
                            updateInterval:(NSTimeInterval)updateInterval
                                   success:(GLBAction*)success
                                   failure:(GLBAction*)failure;

- (void)_start;
- (void)_stop;
- (void)_cancel;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBGeoLocationManager

#pragma mark - Synthesize

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
    _timeAccuracy = 60.0f;
#if defined(GLB_TARGET_IOS)
    _useMonitoringSignificantChanges = YES;
#endif
    _useUpdatingLocation = YES;
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

#if defined(GLB_TARGET_IOS)

+ (BOOL)availableSignificantMonitoringChanges {
    return CLLocationManager.significantLocationChangeMonitoringAvailable;
}

#endif

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
    if([UIDevice glb_compareSystemVersion:@"9.0"] != NSOrderedAscending) {
        _locationManager.allowsBackgroundLocationUpdates = allowsBackgroundUpdates;
    }
}

- (BOOL)allowsBackgroundUpdates {
    if([UIDevice glb_compareSystemVersion:@"9.0"] != NSOrderedAscending) {
        return _locationManager.allowsBackgroundLocationUpdates;
    }
    return YES;
}

#endif

#if defined(GLB_TARGET_IOS)

- (void)setUseMonitoringSignificantChanges:(BOOL)useMonitoringSignificantChanges {
    if(_useMonitoringSignificantChanges != useMonitoringSignificantChanges) {
        if((_useMonitoringSignificantChanges == YES) && (_startedMonitoringSignificantLocationChanges == YES)) {
            _startedMonitoringSignificantLocationChanges = NO;
            [_locationManager stopMonitoringSignificantLocationChanges];
        }
        _useMonitoringSignificantChanges = useMonitoringSignificantChanges;
        if((_useMonitoringSignificantChanges == YES) && (_updatingLocation == YES)) {
            _startedMonitoringSignificantLocationChanges = YES;
            [_locationManager startMonitoringSignificantLocationChanges];
        }
    }
}

#endif

- (void)setUseUpdatingLocation:(BOOL)useUpdatingLocation {
    if(_useUpdatingLocation != useUpdatingLocation) {
        if((_useUpdatingLocation == YES) && (_startedUpdatingLocation == YES)) {
            _startedUpdatingLocation = NO;
            [_locationManager stopUpdatingLocation];
        }
        _useUpdatingLocation = useUpdatingLocation;
        if((_useUpdatingLocation == YES) && (_updatingLocation == YES)) {
            _startedUpdatingLocation = YES;
            [_locationManager startUpdatingLocation];
        }
    }
}

#pragma mark - Public

- (GLBGeoLocationRequest*)requestWithDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy
                                             success:(GLBAction*)success
                                             failure:(GLBAction*)failure {
    return [self requestWithDesiredAccuracy:desiredAccuracy
                            timeoutInterval:0.0
                                    success:success
                                    failure:failure];
}

- (GLBGeoLocationRequest*)requestWithDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy
                                     timeoutInterval:(NSTimeInterval)timeoutInterval
                                             success:(GLBAction*)success
                                             failure:(GLBAction*)failure {
    GLBGeoLocationRequest* request = [[GLBGeoLocationRequest alloc] initWithGeoLocationManager:self
                                                                               desiredAccuracy:desiredAccuracy
                                                                               timeoutInterval:timeoutInterval
                                                                                       success:success
                                                                                       failure:failure];
    return [self _addRequest:request];
}

- (GLBGeoLocationRequest*)subscribeWithDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy
                                               success:(GLBAction*)success
                                               failure:(GLBAction*)failure {
    return [self subscribeWithDesiredAccuracy:desiredAccuracy
                               updateInterval:0.0
                                     success:success
                                      failure:failure];
}

- (GLBGeoLocationRequest*)subscribeWithDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy
                                        updateInterval:(NSTimeInterval)updateInterval
                                               success:(GLBAction*)success
                                               failure:(GLBAction*)failure {
    GLBGeoLocationRequest* request = [[GLBGeoLocationRequest alloc] initWithGeoLocationManager:self
                                                                               desiredAccuracy:desiredAccuracy
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
    BOOL needRequest = ([UIDevice glb_compareSystemVersion:@"8.0"] != NSOrderedAscending);
#elif defined(GLB_TARGET_WATCHOS)
    BOOL needRequest = YES;
#endif
    BOOL requestAccess = NO;
    if(needRequest == YES) {
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
                requestAccess = YES;
                break;
            }
            default: break;
        }
    }
    if((_requests.count > 0) && (_updatingLocation == NO)) {
        if(requestAccess == NO) {
            CLLocation* location = _locationManager.location;
            if(location != nil) {
                __weak typeof(self) weakSelf = self;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf _processRequests:location];
                });
            }
        }
        if(_requests.count > 0) {
            if(requestAccess == NO) {
                _updatingLocation = YES;
            }
            _locationManager.delegate = self;
#if defined(GLB_TARGET_IOS)
            if(_useMonitoringSignificantChanges == YES) {
                _startedMonitoringSignificantLocationChanges = YES;
                [_locationManager startMonitoringSignificantLocationChanges];
            }
#endif
            if(_useUpdatingLocation == YES) {
                _startedUpdatingLocation = YES;
                [_locationManager startUpdatingLocation];
            }
        }
    }
}

- (void)_stopUpdatingIfPossible {
    if((_requests.count < 1) && (_updatingLocation == YES)) {
        _updatingLocation = NO;
        
#if defined(GLB_TARGET_IOS)
        if(_startedMonitoringSignificantLocationChanges == YES) {
            _startedMonitoringSignificantLocationChanges = NO;
            [_locationManager stopMonitoringSignificantLocationChanges];
        }
#endif
        if(_startedUpdatingLocation == YES) {
            _startedUpdatingLocation = NO;
            [_locationManager stopUpdatingLocation];
        }
        _locationManager.delegate = nil;
    }
}

- (GLBGeoLocationRequest*)_addRequest:(GLBGeoLocationRequest*)request {
    __block GLBGeoLocationRequest* result = request;
    [self.class _perform:^{
        switch(self.class.servicesState) {
            case GLBGeoLocationServicesStateDisabled:
            case GLBGeoLocationServicesStateDenied:
            case GLBGeoLocationServicesStateRestricted: {
                if(_lastError == nil) {
                    _lastError = [NSError errorWithDomain:kCLErrorDomain code:kCLErrorDenied userInfo:nil];
                }
                [result.actionFailure performWithArguments:@[ result, _lastError ]];
                result = nil;
                break;
            }
            default:
                break;
        }
        if(result != nil) {
            [_requests addObject:result];
            [self _startUpdatingIfNeeded];
            if(_updatingLocation == YES) {
                [result _start];
            }
        }
    }];
    return result;
}

- (void)_removeRequest:(GLBGeoLocationRequest*)request {
    [self.class _perform:^{
        [_requests removeObject:request];
        [self _stopUpdatingIfPossible];
    }];
}

- (void)_processRequests:(CLLocation*)location {
    if(location != nil) {
        NSTimeInterval delta = location.timestamp.timeIntervalSinceNow;
        if(ABS(delta) > _timeAccuracy) {
            location = nil;
        }
    }
    NSMutableArray* removedRequest = [NSMutableArray array];
    for(GLBGeoLocationRequest* request in _requests) {
        if(request.hasTimedOut == YES) {
            [removedRequest addObject:request];
            _lastError = [NSError errorWithDomain:kCLErrorDomain code:kCLErrorLocationUnknown userInfo:nil];
            [request.actionFailure performWithArguments:@[ request, _lastError ]];
        } else if(location != nil) {
            BOOL finish = NO;
            CLLocationAccuracy desiredAccuracy = MAX(location.horizontalAccuracy, location.verticalAccuracy);
            NSTimeInterval timeSinceUpdate = ABS(location.timestamp.timeIntervalSinceNow);
            if((request.desiredAccuracy > FLT_EPSILON) && (desiredAccuracy <= request.desiredAccuracy)) {
                finish = YES;
            }
            if((request.updateInterval > FLT_EPSILON) && (timeSinceUpdate >= request.updateInterval)) {
                finish = YES;
            }
            if(finish == YES) {
                if(request.isSubscription == NO) {
                    [removedRequest addObject:request];
                }
                [request.actionSuccess performWithArguments:@[ request, location ]];
            }
        }
    }
    for(GLBGeoLocationRequest* request in removedRequest) {
        [request _stop];
        [self _removeRequest:request];
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager*)manager didUpdateLocations:(NSArray*)locations {
    [self.class _perform:^{
        [self _processRequests:locations.lastObject];
    }];
}

- (void)locationManager:(CLLocationManager*)manager didFailWithError:(NSError*)error {
    [self.class _perform:^{
        _lastError = error;
        [self cancelAllRequests];
    }];
}

- (void)locationManager:(CLLocationManager*)locationManager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
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
                CLLocation* location = _locationManager.location;
                if(location != nil) {
                    [self _processRequests:location];
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

@synthesize desiredAccuracy = _desiredAccuracy;
@synthesize timeoutInterval = _timeoutInterval;
@synthesize updateInterval = _updateInterval;
@synthesize subscription = _subscription;
@synthesize canceled = _canceled;

#pragma mark - Init / Free

- (instancetype)initWithGeoLocationManager:(GLBGeoLocationManager*)geoLocationManager
                           desiredAccuracy:(CLLocationAccuracy)desiredAccuracy
                           timeoutInterval:(NSTimeInterval)timeoutInterval
                                   success:(GLBAction*)success
                                   failure:(GLBAction*)failure {
    self = [super init];
    if(self != nil) {
        _geoLocationManager = geoLocationManager;
        _desiredAccuracy = desiredAccuracy;
        _timeoutInterval = timeoutInterval;
        _subscription = NO;
        _actionSuccess = success;
        _actionFailure = failure;
    }
    return self;
}

- (instancetype)initWithGeoLocationManager:(GLBGeoLocationManager*)geoLocationManager
                           desiredAccuracy:(CLLocationAccuracy)desiredAccuracy
                            updateInterval:(NSTimeInterval)updateInterval
                                   success:(GLBAction*)success
                                   failure:(GLBAction*)failure {
    self = [super init];
    if(self != nil) {
        _geoLocationManager = geoLocationManager;
        _desiredAccuracy = desiredAccuracy;
        _updateInterval = updateInterval;
        _subscription = YES;
        _actionSuccess = success;
        _actionFailure = failure;
    }
    return self;
}

- (void)dealloc {
    [self _stop];
}

#pragma mark - Public

- (BOOL)hasTimedOut {
    if(_timeoutInterval > FLT_EPSILON) {
        NSTimeInterval aliveInterval = ABS(_requestStartTime.timeIntervalSinceNow);
        if(aliveInterval >= _timeoutInterval) {
            return YES;
        }
    }
    return NO;
}
    
#pragma mark - Public
    
- (void)cancel {
    [_geoLocationManager cancelRequest:self];
}

#pragma mark - Private

- (void)_start {
    if(_requestStartTime == nil) {
        _requestStartTime = [NSDate date];
    }
    if((_timeoutInterval > FLT_EPSILON) && (_timer == nil)) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_timeoutInterval
                                                  target:self
                                                selector:@selector(_timeout)
                                                userInfo:nil
                                                 repeats:NO];
    }
}

- (void)_stop {
    if(_timer != nil) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)_cancel {
    [self _stop];
    _canceled = YES;
}

#pragma mark - Timer

- (void)_timeout {
    [_geoLocationManager _processRequests:nil];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation CLLocation (GLBGeoLocation)

#pragma mark - GLBObjectDebugProtocol

- (void)glb_debugString:(NSMutableString*)string context:(NSPointerArray*)context indent:(NSUInteger)indent root:(BOOL)root {
    if(root == YES) {
        [string glb_appendString:@"\t" repeat:indent];
    }
    NSUInteger baseIndent = indent + 1;
    [string appendFormat:@"<%@\n", self.glb_className];

    [string glb_appendString:@"\t" repeat:baseIndent];
    [string appendFormat:@"Latitude : %f\n", self.coordinate.latitude];

    [string glb_appendString:@"\t" repeat:baseIndent];
    [string appendFormat:@"Longitude : %f\n", self.coordinate.longitude];
    
    [string glb_appendString:@"\t" repeat:baseIndent];
    [string appendFormat:@"Altitude : %f\n", self.altitude];
    
    [string glb_appendString:@"\t" repeat:indent];
    [string appendString:@">"];
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
