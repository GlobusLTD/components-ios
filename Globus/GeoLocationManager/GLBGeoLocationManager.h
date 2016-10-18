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
@property(nonatomic, assign) BOOL useMonitoringSignificantChanges;
@property(nonatomic, assign) BOOL useUpdatingLocation;
@property(nonatomic, assign) NSTimeInterval timeAccuracy;
@property(nonatomic, readonly, copy) NSArray* requests;
@property(nonatomic, readonly, assign, getter=isUpdatingLocation) BOOL updatingLocation;

+ (GLBGeoLocationServicesState)servicesState;
+ (BOOL)availableSignificantMonitoringChanges;

+ (instancetype)shared;

- (void)setup NS_REQUIRES_SUPER;

- (GLBGeoLocationRequest*)requestWithDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy
                                             success:(GLBAction*)success
                                             failure:(GLBAction*)failure;

- (GLBGeoLocationRequest*)requestWithDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy
                                     timeoutInterval:(NSTimeInterval)timeoutInterval
                                             success:(GLBAction*)success
                                             failure:(GLBAction*)failure;

- (GLBGeoLocationRequest*)subscribeWithDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy
                                               success:(GLBAction*)success
                                               failure:(GLBAction*)failure;

- (GLBGeoLocationRequest*)subscribeWithDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy
                                        updateInterval:(NSTimeInterval)updateInterval
                                               success:(GLBAction*)success
                                               failure:(GLBAction*)failure;

- (void)cancelRequest:(GLBGeoLocationRequest*)request;
- (void)cancelAllRequests;

- (void)geocodeAddressString:(NSString*)address block:(CLGeocodeCompletionHandler)block;
- (void)reverseGeocodeLocation:(CLLocation*)location block:(CLGeocodeCompletionHandler)block;

@end

/*--------------------------------------------------*/

extern NSString* GLBGeoLocationManagerUserDenied;

/*--------------------------------------------------*/

@interface GLBGeoLocationRequest : NSObject

@property(nonatomic, strong) NSDictionary* userInfo;
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
