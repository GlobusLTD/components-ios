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

+ (nullable instancetype)shared;

- (void)setup NS_REQUIRES_SUPER;

- (nullable GLBGeoLocationRequest*)requestWithDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy
                                                       success:(nullable GLBAction*)success
                                                       failure:(nullable GLBAction*)failure;

- (nullable GLBGeoLocationRequest*)requestWithDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy
                                               timeoutInterval:(NSTimeInterval)timeoutInterval
                                                       success:(nullable GLBAction*)success
                                                       failure:(nullable GLBAction*)failure;

- (nullable GLBGeoLocationRequest*)subscribeWithDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy
                                                         success:(nullable GLBAction*)success
                                                         failure:(nullable GLBAction*)failure;

- (nullable GLBGeoLocationRequest*)subscribeWithDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy
                                                  updateInterval:(NSTimeInterval)updateInterval
                                                         success:(nullable GLBAction*)success
                                                         failure:(nullable GLBAction*)failure;

- (void)cancelRequest:(nonnull GLBGeoLocationRequest*)request;
- (void)cancelAllRequests;

- (void)geocodeAddressString:(nonnull NSString*)address block:(nullable CLGeocodeCompletionHandler)block;
- (void)reverseGeocodeLocation:(nonnull CLLocation*)location block:(nullable CLGeocodeCompletionHandler)block;

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
