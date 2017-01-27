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

+ (nullable instancetype)shared;

+ (BOOL)isSupported;

- (void)setup NS_REQUIRES_SUPER;

- (void)activate;

- (void)addObserver:(nonnull id< GLBWatchManagerObserver >)observer;
- (void)removeObserver:(nonnull id< GLBWatchManagerObserver >)observer;

- (void)addProvider:(nonnull GLBWatchProvider*)provider;
- (void)removeProvider:(nonnull GLBWatchProvider*)provider;

@end

/*--------------------------------------------------*/

@protocol GLBWatchProviderDelegate;

/*--------------------------------------------------*/

@interface GLBWatchProvider : NSObject

@property(nonatomic, nonnull, readonly, strong) NSString* identifier;
@property(nonatomic, nullable, weak) id< GLBWatchProviderDelegate > delegate;

+ (nonnull instancetype)watchProviderWithIdentifier:(nonnull NSString*)identifier delegate:(nullable id< GLBWatchProviderDelegate >)delegate NS_SWIFT_NAME(watchProvider(identifier:delegate:));

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithIdentifier:(nonnull NSString*)identifier delegate:(nullable id< GLBWatchProviderDelegate >)delegate NS_DESIGNATED_INITIALIZER;

- (void)setup NS_REQUIRES_SUPER;

- (BOOL)sendReachableInfo:(nonnull NSDictionary< NSString*, id >*)reachableInfo;
- (BOOL)sendReachableInfo:(nonnull NSDictionary< NSString*, id >*)reachableInfo block:(nullable GLBWatchReachableSendBlock)block;

- (BOOL)sendInfo:(nonnull NSDictionary< NSString*, id >*)info;
- (BOOL)sendInfo:(nonnull NSDictionary< NSString*, id >*)info complication:(BOOL)complication GLB_UNAVAILABLE_WATCHOS;
- (BOOL)sendInfo:(nonnull NSDictionary< NSString*, id >*)info data:(nullable NSData*)data;
- (BOOL)sendInfo:(nonnull NSDictionary< NSString*, id >*)info data:(nullable NSData*)data complication:(BOOL)complication GLB_UNAVAILABLE_WATCHOS;

@end

/*--------------------------------------------------*/

@protocol GLBWatchManagerObserver < GLBObserverProtocol >

@optional
- (void)watchManager:(nonnull GLBWatchManager*)watchManager activate:(BOOL)activate error:(nullable NSError*)error;

@optional
- (void)watchManager:(nonnull GLBWatchManager*)watchManager reachability:(BOOL)reachability;

@end

/*--------------------------------------------------*/

@protocol GLBWatchProviderDelegate < NSObject >

@optional
- (void)watchProvider:(nonnull GLBWatchProvider*)watchProvider receiveReachableInfo:(nullable NSDictionary< NSString*, id >*)reachableInfo reply:(nullable GLBWatchReachableReplyBlock)reply;

@optional
- (void)watchProvider:(nonnull GLBWatchProvider*)watchProvider sendInfo:(nullable NSDictionary< NSString*, id >*)info data:(nullable NSData*)data error:(nullable NSError*)error;
- (void)watchProvider:(nonnull GLBWatchProvider*)watchProvider receiveInfo:(nullable NSDictionary< NSString*, id >*)info data:(nullable NSData*)data;

@end

/*--------------------------------------------------*/
