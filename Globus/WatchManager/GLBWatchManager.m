/*--------------------------------------------------*/

#import "GLBWatchManager.h"

/*--------------------------------------------------*/

@interface GLBWatchManager () < WCSessionDelegate > {
    GLBObserver* _observer;
    NSMutableArray< GLBWatchProvider* >* _providers;
    NSLock* _providersLock;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface GLBWatchProvider ()

- (void)_didReceiveMessage:(NSDictionary< NSString*, id >* _Nonnull)message replyHandler:(void(^ _Nullable)(NSDictionary< NSString*, id >* _Nonnull replyMessage))replyHandler;
- (void)_didFinishUserInfoTransfer:(WCSessionUserInfoTransfer* _Nonnull)userInfoTransfer error:(NSError* _Nullable)error;
- (void)_didReceiveUserInfo:(NSDictionary< NSString*, id >* _Nonnull)userInfo;
- (void)_didFinishFileTransfer:(WCSessionFileTransfer* _Nonnull)fileTransfer error:(NSError* _Nullable)error;
- (void)_didReceiveFile:(WCSessionFile* _Nonnull)file;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface GLBWatchProviderCommand : NSObject

@property(nonatomic, nullable, readonly, strong) NSDictionary< NSString*, id >* info;
@property(nonatomic, nullable, readonly, strong) NSData* data;
@property(nonatomic, readonly, getter=isComplication) BOOL complication;

@property(nonatomic, nullable, readonly, weak) GLBWatchProvider* profider;
@property(nonatomic, nullable, readonly, strong) NSString* fileName;
@property(nonatomic, nullable, readonly, strong) NSURL* fileURL;
@property(nonatomic, nullable, readonly, strong) NSDictionary* metadata;

+ (NSDictionary* _Nullable)metadataWithProfider:(GLBWatchProvider* _Nonnull)profider reachableInfo:(NSDictionary< NSString*, id >* _Nonnull)reachableInfo;

- (instancetype _Nullable)initWithProfider:(GLBWatchProvider* _Nonnull)profider reachableInfo:(NSDictionary< NSString*, id >* _Nonnull)reachableInfo;
- (instancetype _Nullable)initWithProfider:(GLBWatchProvider* _Nonnull)profider info:(NSDictionary< NSString*, id >* _Nonnull)info data:(NSData* _Nullable)data complication:(BOOL)complication;

- (instancetype _Nullable)initWithReachableMessage:(NSDictionary< NSString*, id >*)reachableMessage;
- (instancetype _Nullable)initWithUserInfoTransfer:(WCSessionUserInfoTransfer* _Nonnull)userInfoTransfer;
- (instancetype _Nullable)initWithUserInfo:(NSDictionary< NSString*, id >* _Nonnull)userInfo;
- (instancetype _Nullable)initWithFileTransfer:(WCSessionFileTransfer* _Nonnull)fileTransfer;
- (instancetype _Nullable)initWithFile:(WCSessionFile* _Nonnull)file;

- (void)saveToTemp;
- (void)cleanupTemp;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

static NSString* GLBWatchProviderIdentifier = @"pid";
static NSString* GLBWatchProviderInfo = @"inf";
static NSString* GLBWatchProviderComplication = @"cmp";
static NSString* GLBWatchProviderFileName = @"file";

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBWatchManager

#pragma mark - Singleton

+ (instancetype)shared {
    static id shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [self new];
    });
    return shared;
}

#pragma mark - Init / Free

- (instancetype)init {
    self = [super init];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _observer = [[GLBObserver alloc] initWithProtocol:@protocol(GLBWatchManagerObserver)];
    _providers = [NSMutableArray array];
    _providersLock = [NSLock new];
#if defined(GLB_TARGET_IOS)
    if([UIDevice glb_compareSystemVersion:@"9.0"] != NSOrderedAscending) {
        if(WCSession.isSupported == YES) {
            _session = WCSession.defaultSession;
            _session.delegate = self;
        }
    }
#elif defined(GLB_TARGET_WATCHOS)
    if(WCSession.isSupported == YES) {
        _session = WCSession.defaultSession;
        _session.delegate = self;
    }
#endif
}

#pragma mark - Property

- (BOOL)isReachable {
#ifdef GLB_TARGET_IOS
    if([UIDevice glb_compareSystemVersion:@"9.0"] != NSOrderedAscending) {
        return _session.isReachable;
    }
    return NO;
#else
    return _session.isReachable;
#endif
}

#ifdef GLB_TARGET_IOS

- (BOOL)isPaired {
    if([UIDevice glb_compareSystemVersion:@"9.0"] != NSOrderedAscending) {
        return _session.isPaired;
    }
    return NO;
}

- (BOOL)isWatchAppInstalled {
    if([UIDevice glb_compareSystemVersion:@"9.0"] != NSOrderedAscending) {
        return _session.isWatchAppInstalled;
    }
    return NO;
}

- (BOOL)isComplicationEnabled {
    if([UIDevice glb_compareSystemVersion:@"9.0"] != NSOrderedAscending) {
        return _session.isComplicationEnabled;
    }
    return NO;
}

#endif

#pragma mark - Public

+ (BOOL)isSupported {
#ifdef GLB_TARGET_IOS
    if([UIDevice glb_compareSystemVersion:@"9.0"] != NSOrderedAscending) {
        return WCSession.isSupported;
    }
#else
    if([WKInterfaceDevice glb_compareSystemVersion:@"2.0"] != NSOrderedAscending) {
        return WCSession.isSupported;
    }
#endif
    return NO;
}

- (void)activate {
    if((_session != nil) && (_activate == NO) && (_performedActivate == NO)) {
        _performedActivate = YES;
        [_session activateSession];
#if defined(GLB_TARGET_IOS)
        if([UIDevice glb_compareSystemVersion:@"9.3"] == NSOrderedAscending) {
            _activate = YES;
            _performedActivate = NO;
            [self _observeActivate:_activate error:nil];
        }
#elif defined(GLB_TARGET_WATCHOS)
        if([WKInterfaceDevice glb_compareSystemVersion:@"2.2"] == NSOrderedAscending) {
            _activate = YES;
            _performedActivate = NO;
            [self _observeActivate:_activate error:nil];
        }
#endif
    }
}

- (void)addObserver:(id< GLBWatchManagerObserver >)observer {
    [_observer addObserver:observer];
}

- (void)removeObserver:(id< GLBWatchManagerObserver >)observer {
    [_observer removeObserver:observer];
}

- (void)addProvider:(GLBWatchProvider*)provider {
    [_providersLock lock];
    [_providers addObject:provider];
    [_providersLock unlock];
}

- (void)removeProvider:(GLBWatchProvider*)provider {
    [_providersLock lock];
    [_providers removeObject:provider];
    [_providersLock unlock];
}

#pragma mark - Private

- (GLBWatchProvider*)_providerWithIdentifier:(NSString*)identifier {
    [_providersLock lock];
    GLBWatchProvider* provider = [_providers glb_find:^BOOL(GLBWatchProvider* existProvider) {
        return [existProvider.identifier isEqualToString:identifier];
    }];
    [_providersLock unlock];
    return provider;
}

#pragma mark - Observer

- (void)_observeActivate:(BOOL)activate error:(NSError*)error {
    [_observer performSelector:@selector(watchManager:activate:error:) block:^(id< GLBWatchManagerObserver > observer) {
        [observer watchManager:self activate:activate error:error];
    }];
}

- (void)_observeReachability:(BOOL)reachability {
    [_observer performSelector:@selector(watchManager:reachability:) block:^(id< GLBWatchManagerObserver > observer) {
        [observer watchManager:self reachability:reachability];
    }];
}

#pragma mark - WCSessionDelegate

- (void)sessionDidBecomeInactive:(WCSession*)session {
    if(_activate == YES) {
        _activate = NO;
        _performedActivate = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self _observeActivate:_activate error:nil];
        });
    }
}

- (void)sessionDidDeactivate:(WCSession*)session {
    [_session activateSession];
}

- (void)session:(WCSession*)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(NSError*)error {
    BOOL activate;
    switch(activationState) {
        case WCSessionActivationStateNotActivated: activate = NO; break;
        case WCSessionActivationStateInactive: activate = NO; break;
        case WCSessionActivationStateActivated: activate = YES; break;
    }
    if(_activate != activate) {
        _activate = activate;
        _performedActivate = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self _observeActivate:_activate error:error];
        });
    }
}

- (void)sessionReachabilityDidChange:(WCSession*)session {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self _observeReachability:session.isReachable];
    });
}

- (void)session:(WCSession*)session didReceiveMessage:(NSDictionary< NSString*, id >*)message {
    NSString* identifier = [message glb_stringForKey:GLBWatchProviderIdentifier orDefault:nil];
    if(identifier != nil) {
        GLBWatchProvider* provider = [self _providerWithIdentifier:identifier];
        if(provider != nil) {
            [provider _didReceiveMessage:message replyHandler:nil];
        }
    }
}

- (void)session:(WCSession*)session didReceiveMessage:(NSDictionary< NSString*, id >*)message replyHandler:(void(^)(NSDictionary< NSString*, id >* replyMessage))replyHandler {
    NSString* identifier = [message glb_stringForKey:GLBWatchProviderIdentifier orDefault:nil];
    if(identifier != nil) {
        GLBWatchProvider* provider = [self _providerWithIdentifier:identifier];
        if(provider != nil) {
            [provider _didReceiveMessage:message replyHandler:replyHandler];
        }
    }
}

- (void)session:(WCSession*)session didFinishUserInfoTransfer:(WCSessionUserInfoTransfer*)userInfoTransfer error:(NSError*)error {
    NSDictionary* request = userInfoTransfer.userInfo;
    NSString* identifier = [request glb_stringForKey:GLBWatchProviderIdentifier orDefault:nil];
    if(identifier != nil) {
        GLBWatchProvider* provider = [self _providerWithIdentifier:identifier];
        if(provider != nil) {
            [provider _didFinishUserInfoTransfer:userInfoTransfer error:error];
        }
    }
}

- (void)session:(WCSession*)session didReceiveUserInfo:(NSDictionary< NSString*, id >*)userInfo {
    NSString* identifier = [userInfo glb_stringForKey:GLBWatchProviderIdentifier orDefault:nil];
    if(identifier != nil) {
        GLBWatchProvider* provider = [self _providerWithIdentifier:identifier];
        if(provider != nil) {
            [provider _didReceiveUserInfo:userInfo];
        }
    }
}

- (void)session:(WCSession*)session didFinishFileTransfer:(WCSessionFileTransfer*)fileTransfer error:(NSError*)error {
    NSDictionary* request = fileTransfer.file.metadata;
    NSString* identifier = [request glb_stringForKey:GLBWatchProviderIdentifier orDefault:nil];
    if(identifier != nil) {
        GLBWatchProvider* provider = [self _providerWithIdentifier:identifier];
        if(provider != nil) {
            [provider _didFinishFileTransfer:fileTransfer error:error];
        }
    }
}

- (void)session:(WCSession*)session didReceiveFile:(WCSessionFile*)file {
    NSDictionary* request = file.metadata;
    NSString* identifier = [request glb_stringForKey:GLBWatchProviderIdentifier orDefault:nil];
    if(identifier != nil) {
        GLBWatchProvider* provider = [self _providerWithIdentifier:identifier];
        if(provider != nil) {
            [provider _didReceiveFile:file];
        }
    }
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBWatchProvider

#pragma mark - Not designated initializer

GLB_IMPLEMENTATION_NOT_DESIGNATED_INITIALIZER(init)

#pragma mark - Init / Free

+ (instancetype)watchProviderWithIdentifier:(NSString*)identifier delegate:(id< GLBWatchProviderDelegate >)delegate {
    return [[self alloc] initWithIdentifier:identifier delegate:delegate];
}

- (instancetype)initWithIdentifier:(NSString*)identifier delegate:(id< GLBWatchProviderDelegate >)delegate {
    self = [super init];
    if(self != nil) {
        _identifier = identifier;
        _delegate = delegate;
        [self setup];
    }
    return self;
}

- (void)setup {
}

#pragma mark - Public

- (BOOL)sendReachableInfo:(NSDictionary< NSString*, id >*)reachableInfo {
    return [self sendReachableInfo:reachableInfo block:nil];
}

- (BOOL)sendReachableInfo:(NSDictionary< NSString*, id >*)reachableInfo block:(GLBWatchReachableSendBlock)block {
    GLBWatchManager* manager = GLBWatchManager.shared;
    if(manager.isReachable == NO) {
        return NO;
    }
    GLBWatchProviderCommand* command = [[GLBWatchProviderCommand alloc] initWithProfider:self reachableInfo:reachableInfo];
    if(command != nil) {
        if(block != nil) {
            [manager.session sendMessage:command.metadata replyHandler:^(NSDictionary< NSString*, id >* replyMessage) {
                if(block != nil) {
                    GLBWatchProviderCommand* reply = [[GLBWatchProviderCommand alloc] initWithReachableMessage:replyMessage];
                    block(reply.info, nil);
                }
            } errorHandler:^(NSError* error) {
                NSLog(@"sendReachable:(%@) %@", _identifier, error);
                if(block != nil) {
                    block(nil, error);
                }
            }];
        } else {
            [manager.session sendMessage:command.metadata replyHandler:nil errorHandler:^(NSError* error) {
                NSLog(@"sendReachable:(%@) %@", _identifier, error);
            }];
        }
    }
    return (command != nil);
}

- (BOOL)sendInfo:(NSDictionary< NSString*, id >*)info {
    return [self sendInfo:info data:nil];
}

#if defined(GLB_TARGET_IOS)

- (BOOL)sendInfo:(NSDictionary< NSString*, id >*)info complication:(BOOL)complication {
    return [self sendInfo:info data:nil complication:complication];
}

#endif

- (BOOL)sendInfo:(NSDictionary< NSString*, id >*)info data:(NSData*)data {
    GLBWatchManager* manager = GLBWatchManager.shared;
    if(manager.isActivate == NO) {
        return NO;
    }
    GLBWatchProviderCommand* command = [[GLBWatchProviderCommand alloc] initWithProfider:self info:info data:data complication:NO];
    if(command != nil) {
        if(command.fileURL != nil) {
            [manager.session transferFile:command.fileURL metadata:command.metadata];
        } else {
            [manager.session transferUserInfo:command.metadata];
        }
    }
    return (command != nil);
}

#if defined(GLB_TARGET_IOS)

- (BOOL)sendInfo:(NSDictionary< NSString*, id >*)info data:(NSData*)data complication:(BOOL)complication {
    GLBWatchManager* manager = GLBWatchManager.shared;
    if(manager.isActivate == NO) {
        return NO;
    }
    GLBWatchProviderCommand* command = [[GLBWatchProviderCommand alloc] initWithProfider:self info:info data:data complication:complication];
    if(command != nil) {
        if(command.fileURL != nil) {
            [manager.session transferFile:command.fileURL metadata:command.metadata];
        } else if(complication == YES) {
            [manager.session transferCurrentComplicationUserInfo:command.metadata];
        } else {
            [manager.session transferUserInfo:command.metadata];
        }
    }
    return (command != nil);
}

#endif

#pragma mark - Private

- (void)_didReceiveMessage:(NSDictionary< NSString*, id >*)message replyHandler:(void(^)(NSDictionary< NSString*, id >* replyMessage))replyHandler {
    GLBWatchProviderCommand* command = [[GLBWatchProviderCommand alloc] initWithReachableMessage:message];
    if(command != nil) {
        NSDictionary* info = command.info;
        if(replyHandler != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [_delegate watchProvider:self receiveReachableInfo:info reply:^(NSDictionary< NSString*, id >* reachableInfo) {
                    NSDictionary* metadata = [GLBWatchProviderCommand metadataWithProfider:self reachableInfo:reachableInfo];
                    replyHandler(metadata);
                }];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [_delegate watchProvider:self receiveReachableInfo:info reply:nil];
            });
        }
    }
}

- (void)_didFinishUserInfoTransfer:(WCSessionUserInfoTransfer*)userInfoTransfer error:(NSError*)error {
    GLBWatchProviderCommand* command = [[GLBWatchProviderCommand alloc] initWithUserInfoTransfer:userInfoTransfer];
    if(command != nil) {
        NSDictionary* info = command.info;
        NSData* data = command.data;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_delegate watchProvider:self sendInfo:info data:data error:error];
        });
    }
}

- (void)_didReceiveUserInfo:(NSDictionary< NSString*, id >*)userInfo {
    GLBWatchProviderCommand* command = [[GLBWatchProviderCommand alloc] initWithUserInfo:userInfo];
    if(command != nil) {
        NSDictionary* info = command.info;
        NSData* data = command.data;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_delegate watchProvider:self receiveInfo:info data:data];
        });
        [command cleanupTemp];
    }
}

- (void)_didFinishFileTransfer:(WCSessionFileTransfer*)fileTransfer error:(NSError*)error {
    GLBWatchProviderCommand* command = [[GLBWatchProviderCommand alloc] initWithFileTransfer:fileTransfer];
    if(command != nil) {
#if defined(GLB_TARGET_IOS)
        if(command.isComplication == YES) {
            [GLBWatchManager.shared.session transferCurrentComplicationUserInfo:fileTransfer.file.metadata];
        }
#elif defined(GLB_TARGET_WATCHOS)
        NSDictionary* info = command.info;
        NSData* data = command.data;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_delegate watchProvider:self sendInfo:info data:data error:error];
        });
#endif
        [command cleanupTemp];
    }
}

- (void)_didReceiveFile:(WCSessionFile*)file {
    GLBWatchProviderCommand* command = [[GLBWatchProviderCommand alloc] initWithFile:file];
    if(command != nil) {
#if defined(GLB_TARGET_IOS)
        NSDictionary* info = command.info;
        NSData* data = command.data;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_delegate watchProvider:self receiveInfo:info data:data];
        });
#elif defined(GLB_TARGET_WATCHOS)
        if(command.isComplication == NO) {
            NSDictionary* info = command.info;
            NSData* data = command.data;
            dispatch_async(dispatch_get_main_queue(), ^{
                [_delegate watchProvider:self receiveInfo:info data:data];
            });
        } else {
            [command saveToTemp];
        }
#endif
    }
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBWatchProviderCommand

#pragma mark - Synthesize

@synthesize fileURL = _fileURL;

#pragma mark - Static

+ (NSDictionary*)metadataWithProfider:(GLBWatchProvider*)profider reachableInfo:(NSDictionary< NSString*, id >*)reachableInfo {
    NSMutableDictionary* metadata = [NSMutableDictionary dictionary];
    metadata[GLBWatchProviderIdentifier] = profider.identifier;
    metadata[GLBWatchProviderInfo] = reachableInfo;
    return metadata;
}

#pragma mark - Init / Free

- (instancetype)initWithProfider:(GLBWatchProvider*)profider reachableInfo:(NSDictionary< NSString*, id >*)reachableInfo {
    self = [super init];
    if(self != nil) {
        NSMutableDictionary* metadata = [NSMutableDictionary dictionary];
        metadata[GLBWatchProviderIdentifier] = profider.identifier;
        metadata[GLBWatchProviderInfo] = reachableInfo;
        _metadata = metadata;
    }
    return self;
}

- (instancetype)initWithProfider:(GLBWatchProvider*)profider info:(NSDictionary< NSString*, id >*)info data:(NSData*)data complication:(BOOL)complication  {
    self = [super init];
    if(self != nil) {
        NSMutableDictionary* metadata = [NSMutableDictionary dictionary];
        metadata[GLBWatchProviderIdentifier] = profider.identifier;
        metadata[GLBWatchProviderInfo] = info;
        if(complication == YES) {
            metadata[GLBWatchProviderComplication] = @(complication);
        }
        if(data != nil) {
            NSString* uuid = NSUUID.UUID.UUIDString;
            NSURL* url = [NSURL fileURLWithPath:[NSFileManager.glb_cachesDirectory stringByAppendingPathComponent:uuid]];
            if([data writeToURL:url atomically:YES] == YES) {
                metadata[GLBWatchProviderFileName] = uuid;
                _fileURL = url;
            }
        }
        _metadata = metadata;
    }
    return self;
}

- (instancetype)initWithReachableMessage:(NSDictionary< NSString*, id >*)reachableMessage {
    self = [super init];
    if(self != nil) {
        _metadata = reachableMessage;
    }
    return self;
}

- (instancetype)initWithUserInfoTransfer:(WCSessionUserInfoTransfer*)userInfoTransfer {
    self = [super init];
    if(self != nil) {
        _metadata = userInfoTransfer.userInfo;
        
        NSString* fileName = [_metadata glb_stringForKey:GLBWatchProviderFileName orDefault:nil];
        if(fileName != nil) {
            NSString* filePath = [NSFileManager.glb_cachesDirectory stringByAppendingPathComponent:fileName];
            if([NSFileManager.defaultManager fileExistsAtPath:filePath] == YES) {
                _fileURL = [NSURL fileURLWithPath:filePath];
            }
        }
    }
    return self;
}

- (instancetype)initWithUserInfo:(NSDictionary< NSString*, id >*)userInfo {
    self = [super init];
    if(self != nil) {
        _metadata = userInfo;
        
        NSString* fileName = [_metadata glb_stringForKey:GLBWatchProviderFileName orDefault:nil];
        if(fileName != nil) {
            NSString* filePath = [NSFileManager.glb_cachesDirectory stringByAppendingPathComponent:fileName];
            if([NSFileManager.defaultManager fileExistsAtPath:filePath] == YES) {
                _fileURL = [NSURL fileURLWithPath:filePath];
            }
        }
    }
    return self;
}

- (instancetype)initWithFileTransfer:(WCSessionFileTransfer*)fileTransfer {
    self = [super init];
    if(self != nil) {
        _metadata = fileTransfer.file.metadata;
        _fileURL = fileTransfer.file.fileURL;
    }
    return self;
}

- (instancetype)initWithFile:(WCSessionFile*)file {
    self = [super init];
    if(self != nil) {
        _metadata = file.metadata;
        _fileURL = file.fileURL;
    }
    return self;
}

#pragma mark - Property

- (NSDictionary*)info {
    return [_metadata glb_dictionaryForKey:GLBWatchProviderInfo orDefault:nil];
}

- (NSData*)data {
    if(_fileURL != nil) {
        return [NSData dataWithContentsOfURL:_fileURL];
    }
    return nil;
}

- (BOOL)isComplication {
    return [_metadata glb_boolForKey:GLBWatchProviderComplication orDefault:NO];
}

- (NSString*)fileName {
    return [_metadata glb_stringForKey:GLBWatchProviderFileName orDefault:nil];
}

#pragma mark - Public

- (void)saveToTemp {
    NSString* fileName = [_metadata glb_stringForKey:GLBWatchProviderFileName orDefault:nil];
    NSString* filePath = [NSFileManager.glb_cachesDirectory stringByAppendingPathComponent:fileName];
    NSURL* fileURL = [NSURL fileURLWithPath:filePath];
    if(fileURL == nil) {
        return;
    }
    NSData* data = [NSData dataWithContentsOfURL:_fileURL];
    if(data == nil) {
        return;
    }
    NSError* error = nil;
    if([data writeToURL:fileURL options:NSDataWritingAtomic error:&error] == NO) {
        NSLog(@"%s - %@", __PRETTY_FUNCTION__, error);
    }
}

- (void)cleanupTemp {
    if(_fileURL != nil) {
        NSError* error = nil;
        if([NSFileManager.defaultManager removeItemAtURL:_fileURL error:&error] == NO) {
            NSLog(@"%s - %@", __PRETTY_FUNCTION__, error);
        }
    }
}

@end

/*--------------------------------------------------*/
