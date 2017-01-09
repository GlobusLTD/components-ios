/*--------------------------------------------------*/

#import "NSDictionary+GLBNS.h"
#import "NSArray+GLBNS.h"
#import "NSFileManager+GLBNS.h"

/*--------------------------------------------------*/

#import "UIDevice+GLBUI.h"
#import "WKInterfaceDevice+GLBWK.h"

/*--------------------------------------------------*/

#import "GLBObserver.h"

/*--------------------------------------------------*/

#import <WatchConnectivity/WatchConnectivity.h>

/*--------------------------------------------------*/

@protocol GLBWatchManagerObserver;

/*--------------------------------------------------*/

@class GLBWatchProvider;

/*--------------------------------------------------*/

typedef void(^GLBWatchReachableSendBlock)(NSDictionary< NSString*, id >* _Nullable replyInfo, NSError* _Nullable error);
typedef void(^GLBWatchReachableReplyBlock)(NSDictionary< NSString*, id >* _Nullable replyInfo);

/*--------------------------------------------------*/

@interface GLBWatchManager : NSObject

@property(nonatomic, nullable, readonly, strong) WCSession* session;
@property(nonatomic, readonly, getter=isSupported) BOOL supported;
@property(nonatomic, readonly, getter=isActivate) BOOL activate;
@property(nonatomic, readonly, getter=isPerformedActivate) BOOL performedActivate;
@property(nonatomic, readonly, getter=isReachable) BOOL reachable;
@property(nonatomic, readonly, getter=isPaired) BOOL paired GLB_UNAVAILABLE_WATCHOS;
@property(nonatomic, readonly, getter=isWatchAppInstalled) BOOL watchAppInstalled GLB_UNAVAILABLE_WATCHOS;
@property(nonatomic, readonly, getter=isComplicationEnabled) BOOL complicationEnabled GLB_UNAVAILABLE_WATCHOS;

+ (instancetype _Nullable)shared;

+ (BOOL)isSupported;

- (void)setup NS_REQUIRES_SUPER;

- (void)activate;

- (void)addObserver:(id< GLBWatchManagerObserver > _Nonnull)observer;
- (void)removeObserver:(id< GLBWatchManagerObserver > _Nonnull)observer;

- (void)addProvider:(GLBWatchProvider* _Nonnull)provider;
- (void)removeProvider:(GLBWatchProvider* _Nonnull)provider;

@end

/*--------------------------------------------------*/

@protocol GLBWatchProviderDelegate;

/*--------------------------------------------------*/

@interface GLBWatchProvider : NSObject

@property(nonatomic, nonnull, readonly, strong) NSString* identifier;
@property(nonatomic, nullable, weak) id< GLBWatchProviderDelegate > delegate;

+ (instancetype _Nonnull)watchProviderWithIdentifier:(NSString* _Nonnull)identifier delegate:(id< GLBWatchProviderDelegate > _Nullable)delegate NS_SWIFT_NAME(watchProvider(identifier:delegate:));

- (instancetype _Nonnull)init NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithIdentifier:(NSString* _Nonnull)identifier delegate:(id< GLBWatchProviderDelegate > _Nullable)delegate NS_DESIGNATED_INITIALIZER;

- (void)setup NS_REQUIRES_SUPER;

- (BOOL)sendReachableInfo:(NSDictionary< NSString*, id >* _Nonnull)reachableInfo;
- (BOOL)sendReachableInfo:(NSDictionary< NSString*, id >* _Nonnull)reachableInfo block:(GLBWatchReachableSendBlock _Nullable)block;

- (BOOL)sendInfo:(NSDictionary< NSString*, id >* _Nonnull)info;
- (BOOL)sendInfo:(NSDictionary< NSString*, id >* _Nonnull)info complication:(BOOL)complication GLB_UNAVAILABLE_WATCHOS;
- (BOOL)sendInfo:(NSDictionary< NSString*, id >* _Nonnull)info data:(NSData* _Nullable)data;
- (BOOL)sendInfo:(NSDictionary< NSString*, id >* _Nonnull)info data:(NSData* _Nullable)data complication:(BOOL)complication GLB_UNAVAILABLE_WATCHOS;

@end

/*--------------------------------------------------*/

@protocol GLBWatchManagerObserver < GLBObserverProtocol >

@optional
- (void)watchManager:(GLBWatchManager* _Nonnull)watchManager activate:(BOOL)activate error:(NSError* _Nullable)error;

@optional
- (void)watchManager:(GLBWatchManager* _Nonnull)watchManager reachability:(BOOL)reachability;

@end

/*--------------------------------------------------*/

@protocol GLBWatchProviderDelegate < NSObject >

@optional
- (void)watchProvider:(GLBWatchProvider* _Nonnull)watchProvider receiveReachableInfo:(NSDictionary< NSString*, id >* _Nullable)reachableInfo reply:(GLBWatchReachableReplyBlock _Nullable)reply;

@optional
- (void)watchProvider:(GLBWatchProvider* _Nonnull)watchProvider sendInfo:(NSDictionary< NSString*, id >* _Nullable)info data:(NSData* _Nullable)data error:(NSError* _Nullable)error;
- (void)watchProvider:(GLBWatchProvider* _Nonnull)watchProvider receiveInfo:(NSDictionary< NSString*, id >* _Nullable)info data:(NSData* _Nullable)data;

@end

/*--------------------------------------------------*/
