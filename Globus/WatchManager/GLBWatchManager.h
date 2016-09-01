/*--------------------------------------------------*/

#import "NSDictionary+GLBNS.h"
#import "NSArray+GLBNS.h"
#import "NSFileManager+GLBNS.h"

/*--------------------------------------------------*/

#import "UIDevice+GLBUI.h"

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

@property(nonatomic, readonly, nullable, strong) WCSession* session;
@property(nonatomic, readonly, getter=isSupported) BOOL supported;
@property(nonatomic, readonly, getter=isActivate) BOOL activate;
@property(nonatomic, readonly, getter=isPaired) BOOL paired __WATCHOS_UNAVAILABLE;
@property(nonatomic, readonly, getter=isWatchAppInstalled) BOOL watchAppInstalled __WATCHOS_UNAVAILABLE;
@property(nonatomic, readonly, getter=isComplicationEnabled) BOOL complicationEnabled __WATCHOS_UNAVAILABLE;
@property(nonatomic, readonly, getter=isReachable) BOOL reachable __WATCHOS_UNAVAILABLE;

+ (_Nullable instancetype)shared;

- (void)setup NS_REQUIRES_SUPER;

- (void)activate;

- (void)addObserver:(_Nonnull id< GLBWatchManagerObserver >)observer;
- (void)removeObserver:(_Nonnull id< GLBWatchManagerObserver >)observer;

- (void)addProvider:(GLBWatchProvider* _Nonnull)provider;
- (void)removeProvider:(GLBWatchProvider* _Nonnull)provider;

@end

/*--------------------------------------------------*/

@protocol GLBWatchProviderDelegate;

/*--------------------------------------------------*/

@interface GLBWatchProvider : NSObject

@property(nonatomic, readonly, nonnull, strong) NSString* identifier;
@property(nonatomic, nullable, weak) id< GLBWatchProviderDelegate > delegate;

- (_Nullable instancetype)initWithIdentifier:(NSString* _Nonnull)identifier;

- (void)setup NS_REQUIRES_SUPER;

- (void)sendReachableInfo:(NSDictionary< NSString*, id >* _Nullable)reachableInfo;
- (void)sendReachableInfo:(NSDictionary< NSString*, id >* _Nullable)reachableInfo block:(_Nullable GLBWatchReachableSendBlock)block;

- (void)sendInfo:(NSDictionary< NSString*, id >* _Nullable)info data:(NSData* _Nullable)data;
- (void)sendInfo:(NSDictionary< NSString*, id >* _Nullable)info data:(NSData* _Nullable)data complication:(BOOL)complication __WATCHOS_UNAVAILABLE;

@end

/*--------------------------------------------------*/

@protocol GLBWatchManagerObserver < NSObject >

@optional
- (void)watchManager:(GLBWatchManager* _Nonnull)watchManager activate:(BOOL)activate;

@optional
- (void)watchManager:(GLBWatchManager* _Nonnull)watchManager reachability:(BOOL)reachability;

@end

/*--------------------------------------------------*/

@protocol GLBWatchProviderDelegate < NSObject >

@optional
- (void)watchProvider:(GLBWatchProvider* _Nonnull)watchProvider receiveReachableInfo:(NSDictionary< NSString*, id >* _Nullable)reachableInfo reply:(_Nullable GLBWatchReachableReplyBlock)reply;

@optional
- (void)watchProvider:(GLBWatchProvider* _Nonnull)watchProvider sendInfo:(NSDictionary< NSString*, id >* _Nullable)info data:(NSData* _Nullable)data error:(NSError* _Nullable)error;
- (void)watchProvider:(GLBWatchProvider* _Nonnull)watchProvider receiveInfo:(NSDictionary< NSString*, id >* _Nullable)info data:(NSData* _Nullable)data;

@end

/*--------------------------------------------------*/
