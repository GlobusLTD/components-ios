/*--------------------------------------------------*/

#import "NSString+GLBNS.h"

/*--------------------------------------------------*/

#import "UIDevice+GLBUI.h"

/*--------------------------------------------------*/

#import "GLBAction.h"

/*--------------------------------------------------*/

#import <CoreLocation/CoreLocation.h>

/*--------------------------------------------------*/

@protocol GLBGeoLocationRequestDelegate;
@class GLBGeoLocationRequest;

/*--------------------------------------------------*/

typedef NS_ENUM(NSInteger, GLBGeoLocationServicesState) {
    GLBGeoLocationServicesStateAvailable,
    GLBGeoLocationServicesStateNotDetermined,
    GLBGeoLocationServicesStateDenied,
    GLBGeoLocationServicesStateRestricted,
    GLBGeoLocationServicesStateDisabled
};

/*--------------------------------------------------*/

typedef NS_ENUM(NSInteger, GLBGeoLocationStatus) {
    GLBGeoLocationStatusSuccess = 0,
    GLBGeoLocationStatusTimedOut,
    GLBGeoLocationStatusServicesNotDetermined,
    GLBGeoLocationStatusServicesDenied,
    GLBGeoLocationStatusServicesRestricted,
    GLBGeoLocationStatusServicesDisabled,
    GLBGeoLocationStatusError
};

/*--------------------------------------------------*/

@interface GLBGeoLocationManager : NSObject

#if defined(GLB_TARGET_IOS)
@property(nonatomic, assign) BOOL allowsBackgroundUpdates;
#endif
@property(nonatomic, assign) BOOL useMonitoringSignificantChanges __WATCHOS_UNAVAILABLE;
@property(nonatomic, assign) BOOL useUpdatingLocation;
@property(nonatomic, assign) NSTimeInterval timeAccuracy;
@property(nonatomic, nonnull, readonly, copy) NSArray* requests;
@property(nonatomic, readonly, assign, getter=isUpdatingLocation) BOOL updatingLocation;

+ (GLBGeoLocationServicesState)servicesState;
+ (BOOL)availableSignificantMonitoringChanges __WATCHOS_UNAVAILABLE;

+ (instancetype _Nullable)shared;

- (void)setup NS_REQUIRES_SUPER;

- (GLBGeoLocationRequest* _Nullable)requestWithDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy
                                                       success:(GLBAction* _Nullable)success
                                                       failure:(GLBAction* _Nullable)failure;

- (GLBGeoLocationRequest* _Nullable)requestWithDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy
                                               timeoutInterval:(NSTimeInterval)timeoutInterval
                                                       success:(GLBAction* _Nullable)success
                                                       failure:(GLBAction* _Nullable)failure;

- (GLBGeoLocationRequest* _Nullable)subscribeWithDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy
                                                         success:(GLBAction* _Nullable)success
                                                         failure:(GLBAction* _Nullable)failure;

- (GLBGeoLocationRequest* _Nullable)subscribeWithDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy
                                                  updateInterval:(NSTimeInterval)updateInterval
                                                         success:(GLBAction* _Nullable)success
                                                         failure:(GLBAction* _Nullable)failure;

- (void)cancelRequest:(GLBGeoLocationRequest* _Nonnull)request;
- (void)cancelAllRequests;

- (void)geocodeAddressString:(NSString* _Nonnull)address block:(CLGeocodeCompletionHandler _Nullable)block;
- (void)reverseGeocodeLocation:(CLLocation* _Nonnull)location block:(CLGeocodeCompletionHandler _Nullable)block;

@end

/*--------------------------------------------------*/

extern NSString* _Nonnull GLBGeoLocationManagerUserDenied;

/*--------------------------------------------------*/

@interface GLBGeoLocationRequest : NSObject

@property(nonatomic, nullable, strong) NSDictionary* userInfo;
@property(nonatomic, readonly, assign) CLLocationAccuracy desiredAccuracy;
@property(nonatomic, readonly, assign) NSTimeInterval timeoutInterval;
@property(nonatomic, readonly, assign) NSTimeInterval updateInterval;
@property(nonatomic, readonly, assign, getter=isSubscription) BOOL subscription;
@property(nonatomic, readonly, assign, getter=isCanceled) BOOL canceled;

- (BOOL)hasTimedOut;
- (void)cancel;

@end

/*--------------------------------------------------*/

@interface CLLocation (GLBGeoLocation) < GLBObjectDebugProtocol >
@end

/*--------------------------------------------------*/

@interface NSError (GLBGeoLocation)

- (BOOL)glb_isGeoLocation;
- (BOOL)glb_geoLocationUnknown;
- (BOOL)glb_geoLocationAccessDenied;
- (BOOL)glb_geoLocationNetwork;

@end

/*--------------------------------------------------*/
