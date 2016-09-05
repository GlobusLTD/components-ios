/*--------------------------------------------------*/

#import "GLBWatchManager.h"

/*--------------------------------------------------*/

@interface GLBWatchManager () < WCSessionDelegate > {
    NSMutableArray< NSValue* >* _observers;
    NSMutableArray< GLBWatchProvider* >* _providers;
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

@property(nonatomic, readonly, nullable, strong) NSDictionary< NSString*, id >* info;
@property(nonatomic, readonly, nullable, strong) NSData* data;
@property(nonatomic, readonly, getter=isComplication) BOOL complication __WATCHOS_UNAVAILABLE;

@property(nonatomic, readonly, nullable, weak) GLBWatchProvider* profider;
@property(nonatomic, readonly, nullable, strong) NSString* fileName;
@property(nonatomic, readonly, nullable, strong) NSURL* fileURL;
@property(nonatomic, readonly, nullable, strong) NSDictionary* metadata;

- (_Nullable instancetype)initWithProfider:(GLBWatchProvider* _Nonnull)profider reachableInfo:(NSDictionary< NSString*, id >* _Nonnull)reachableInfo;
- (_Nullable instancetype)initWithProfider:(GLBWatchProvider* _Nonnull)profider info:(NSDictionary< NSString*, id >* _Nonnull)info data:(NSData* _Nonnull)data complication:(BOOL)complication;

- (_Nullable instancetype)initWithReachableMessage:(NSDictionary< NSString*, id >*)reachableMessage;
- (_Nullable instancetype)initWithUserInfoTransfer:(WCSessionUserInfoTransfer* _Nonnull)userInfoTransfer;
- (_Nullable instancetype)initWithUserInfo:(NSDictionary< NSString*, id >* _Nonnull)userInfo;
- (_Nullable instancetype)initWithFileTransfer:(WCSessionFileTransfer* _Nonnull)fileTransfer;
- (_Nullable instancetype)initWithFile:(WCSessionFile* _Nonnull)file;

- (void)cleanup;

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
    _observers = [NSMutableArray array];
    _providers = [NSMutableArray array];
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

- (BOOL)isSupported {
#ifdef GLB_TARGET_IOS
    if([UIDevice glb_compareSystemVersion:@"9.0"] != NSOrderedAscending) {
        return WCSession.isSupported;
    }
    return NO;
#else
    return WCSession.isSupported;
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

- (BOOL)isReachable {
    if([UIDevice glb_compareSystemVersion:@"9.0"] != NSOrderedAscending) {
        return _session.isReachable;
    }
    return NO;
}

#endif

#pragma mark - Public

- (void)activate {
    if(_session != nil) {
        [_session activateSession];
#if defined(GLB_TARGET_IOS)
        if([UIDevice glb_compareSystemVersion:@"9.3"] == NSOrderedAscending) {
            if(_activate == NO) {
                _activate = YES;
                [self _observeActivate:_activate];
            }
        }
#elif defined(GLB_TARGET_WATCHOS)
        if(_activate == NO) {
            _activate = YES;
            [self _observeActivate:_activate];
        }
#endif
    }
}

- (void)addObserver:(id< GLBWatchManagerObserver >)observer {
    [_observers addObject:[NSValue valueWithNonretainedObject:observer]];
}

- (void)removeObserver:(id< GLBWatchManagerObserver >)observer {
    [_observers glb_each:^(NSValue* value) {
        if(value.nonretainedObjectValue == observer) {
            [_observers removeObject:value];
        }
    }];
}

- (void)addProvider:(GLBWatchProvider*)provider {
    [_providers addObject:provider];
}

- (void)removeProvider:(GLBWatchProvider*)provider {
    [_providers removeObject:provider];
}

#pragma mark - Private

- (GLBWatchProvider*)_providerWithIdentifier:(NSString*)identifier {
    return [_providers glb_find:^BOOL(GLBWatchProvider* provider) {
        return [provider.identifier isEqualToString:identifier];
    }];
}

#pragma mark - Observer

- (void)_observeActivate:(BOOL)activate {
    for(NSValue* value in _observers) {
        id< GLBWatchManagerObserver > observer = value.nonretainedObjectValue;
        if([observer respondsToSelector:@selector(watchManager:activate:)] == YES) {
            [observer watchManager:self activate:activate];
        }
    }
}

- (void)_observeReachability:(BOOL)reachability {
    for(NSValue* value in _observers) {
        id< GLBWatchManagerObserver > observer = value.nonretainedObjectValue;
        if([observer respondsToSelector:@selector(watchManager:reachability:)] == YES) {
            [observer watchManager:self reachability:reachability];
        }
    }
}

#pragma mark - WCSessionDelegate

- (void)sessionDidBecomeInactive:(WCSession*)session {
    dispatch_async(dispatch_get_main_queue(), ^{
        _activate = YES;
        [self _observeActivate:_activate];
    });
}

- (void)sessionDidDeactivate:(WCSession*)session {
    dispatch_async(dispatch_get_main_queue(), ^{
        _activate = NO;
        [self _observeActivate:_activate];
    });
}

- (void)sessionReachabilityDidChange:(WCSession*)session {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self _observeReachability:session.isReachable];
    });
}

- (void)session:(WCSession*)session didReceiveMessage:(NSDictionary< NSString*, id >*)message {
    NSString* identifier = [message glb_stringForKey:GLBWatchProviderIdentifier orDefault:nil];
    if(identifier != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            GLBWatchProvider* provider = [self _providerWithIdentifier:identifier];
            if(provider != nil) {
                [provider _didReceiveMessage:message replyHandler:nil];
            }
        });
    }
}

- (void)session:(WCSession*)session didReceiveMessage:(NSDictionary< NSString*, id >*)message replyHandler:(void(^)(NSDictionary< NSString*, id >* replyMessage))replyHandler {
    NSString* identifier = [message glb_stringForKey:GLBWatchProviderIdentifier orDefault:nil];
    if(identifier != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            GLBWatchProvider* provider = [self _providerWithIdentifier:identifier];
            if(provider != nil) {
                [provider _didReceiveMessage:message replyHandler:replyHandler];
            }
        });
    }
}

- (void)session:(WCSession*)session didFinishUserInfoTransfer:(WCSessionUserInfoTransfer*)userInfoTransfer error:(NSError*)error {
    NSDictionary* request = userInfoTransfer.userInfo;
    NSString* identifier = [request glb_stringForKey:GLBWatchProviderIdentifier orDefault:nil];
    if(identifier != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            GLBWatchProvider* provider = [self _providerWithIdentifier:identifier];
            if(provider != nil) {
                [provider _didFinishUserInfoTransfer:userInfoTransfer error:error];
            }
        });
    }
}

- (void)session:(WCSession*)session didReceiveUserInfo:(NSDictionary< NSString*, id >*)userInfo {
    NSString* identifier = [userInfo glb_stringForKey:GLBWatchProviderIdentifier orDefault:nil];
    if(identifier != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            GLBWatchProvider* provider = [self _providerWithIdentifier:identifier];
            if(provider != nil) {
                [provider _didReceiveUserInfo:userInfo];
            }
        });
    }
}

- (void)session:(WCSession*)session didFinishFileTransfer:(WCSessionFileTransfer*)fileTransfer error:(NSError*)error {
    NSDictionary* request = fileTransfer.file.metadata;
    NSString* identifier = [request glb_stringForKey:GLBWatchProviderIdentifier orDefault:nil];
    if(identifier != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            GLBWatchProvider* provider = [self _providerWithIdentifier:identifier];
            if(provider != nil) {
                [provider _didFinishFileTransfer:fileTransfer error:error];
            }
        });
    }
}

- (void)session:(WCSession*)session didReceiveFile:(WCSessionFile*)file {
    NSDictionary* request = file.metadata;
    NSString* identifier = [request glb_stringForKey:GLBWatchProviderIdentifier orDefault:nil];
    if(identifier != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            GLBWatchProvider* provider = [self _providerWithIdentifier:identifier];
            if(provider != nil) {
                [provider _didReceiveFile:file];
            }
        });
    }
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBWatchProvider

#pragma mark - Init / Free

- (instancetype)initWithIdentifier:(NSString*)identifier {
    self = [super init];
    if(self != nil) {
        _identifier = identifier;
        [self setup];
    }
    return self;
}

- (void)setup {
}

#pragma mark - Public

- (void)sendReachableInfo:(NSDictionary< NSString*, id >*)reachableInfo {
    [self sendReachableInfo:reachableInfo block:nil];
}

- (void)sendReachableInfo:(NSDictionary< NSString*, id >*)reachableInfo block:(GLBWatchReachableSendBlock)block {
    GLBWatchProviderCommand* command = [[GLBWatchProviderCommand alloc] initWithProfider:self reachableInfo:reachableInfo];
    if(command != nil) {
        if(block != nil) {
            [GLBWatchManager.shared.session sendMessage:command.metadata replyHandler:^(NSDictionary< NSString*, id >* replyMessage) {
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
            [GLBWatchManager.shared.session sendMessage:command.metadata replyHandler:nil errorHandler:^(NSError* error) {
                NSLog(@"sendReachable:(%@) %@", _identifier, error);
            }];
        }
    }
}

- (void)sendInfo:(NSDictionary< NSString*, id >*)info data:(NSData*)data {
    GLBWatchProviderCommand* command = [[GLBWatchProviderCommand alloc] initWithProfider:self info:info data:data complication:NO];
    if(command != nil) {
        [GLBWatchManager.shared.session transferFile:command.fileURL metadata:command.metadata];
    }
}

#if defined(GLB_TARGET_IOS)

- (void)sendInfo:(NSDictionary< NSString*, id >*)info data:(NSData*)data complication:(BOOL)complication {
    GLBWatchProviderCommand* command = [[GLBWatchProviderCommand alloc] initWithProfider:self info:info data:data complication:complication];
    if(command != nil) {
        [GLBWatchManager.shared.session transferFile:command.fileURL metadata:command.metadata];
    }
}

#endif

#pragma mark - Private

- (void)_didReceiveMessage:(NSDictionary< NSString*, id >*)message replyHandler:(void(^)(NSDictionary< NSString*, id >* replyMessage))replyHandler {
    GLBWatchProviderCommand* command = [[GLBWatchProviderCommand alloc] initWithReachableMessage:message];
    if(command != nil) {
        if(replyHandler != nil) {
            [_delegate watchProvider:self receiveReachableInfo:command.info reply:^(NSDictionary< NSString*, id >* reachableInfo) {
                GLBWatchProviderCommand* reply = [[GLBWatchProviderCommand alloc] initWithProfider:self reachableInfo:reachableInfo];
                replyHandler(reply.metadata);
            }];
        } else {
            [_delegate watchProvider:self receiveReachableInfo:command.info reply:nil];
        }
    }
}

- (void)_didFinishUserInfoTransfer:(WCSessionUserInfoTransfer*)userInfoTransfer error:(NSError*)error {
    GLBWatchProviderCommand* command = [[GLBWatchProviderCommand alloc] initWithUserInfoTransfer:userInfoTransfer];
    if(command != nil) {
        [_delegate watchProvider:self sendInfo:command.info data:command.data error:error];
        [command cleanup];
    }
}

- (void)_didReceiveUserInfo:(NSDictionary< NSString*, id >*)userInfo {
    GLBWatchProviderCommand* command = [[GLBWatchProviderCommand alloc] initWithUserInfo:userInfo];
    if(command != nil) {
        [_delegate watchProvider:self receiveInfo:command.info data:command.data];
        [command cleanup];
    }
}

- (void)_didFinishFileTransfer:(WCSessionFileTransfer*)fileTransfer error:(NSError*)error {
    GLBWatchProviderCommand* command = [[GLBWatchProviderCommand alloc] initWithFileTransfer:fileTransfer];
    if(command != nil) {
#if defined(GLB_TARGET_IOS)
        if(command.isComplication == YES) {
            [GLBWatchManager.shared.session transferCurrentComplicationUserInfo:fileTransfer.file.metadata];
        } else {
            [_delegate watchProvider:self sendInfo:command.info data:command.data error:error];
            [command cleanup];
        }
#elif defined(GLB_TARGET_WATCHOS)
        [_delegate watchProvider:self sendInfo:command.info data:command.data error:error];
        [command cleanup];
#endif
    }
}

- (void)_didReceiveFile:(WCSessionFile*)file {
    GLBWatchProviderCommand* command = [[GLBWatchProviderCommand alloc] initWithFile:file];
    if(command != nil) {
#if defined(GLB_TARGET_IOS)
        if(command.isComplication == NO) {
            [_delegate watchProvider:self receiveInfo:command.info data:command.data];
            [command cleanup];
        }
#elif defined(GLB_TARGET_WATCHOS)
        [_delegate watchProvider:self receiveInfo:command.info data:command.data];
        [command cleanup];
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

#pragma mark - Init / Free

- (instancetype)initWithProfider:(GLBWatchProvider*)profider reachableInfo:(NSDictionary< NSString*, id >*)reachableInfo {
    self = [super init];
    if(self != nil) {
        NSMutableDictionary* metadata = [NSMutableDictionary dictionary];
        metadata[GLBWatchProviderIdentifier] = profider.identifier;
        metadata[GLBWatchProviderInfo] = reachableInfo;
        _metadata = metadata.copy;
    }
    return self;
}

- (instancetype)initWithProfider:(GLBWatchProvider*)profider info:(NSDictionary< NSString*, id >*)info data:(NSData*)data complication:(BOOL)complication  {
    self = [super init];
    if(self != nil) {
        NSString* uuid = NSUUID.UUID.UUIDString;
        NSURL* url = [NSURL fileURLWithPath:[NSFileManager.glb_cachesDirectory stringByAppendingPathComponent:uuid]];
        if([data writeToURL:url atomically:YES] == YES) {
            NSMutableDictionary* metadata = [NSMutableDictionary dictionary];
            metadata[GLBWatchProviderIdentifier] = profider.identifier;
            metadata[GLBWatchProviderInfo] = info;
            if(complication == YES) {
                metadata[GLBWatchProviderComplication] = @(complication);
            }
            metadata[GLBWatchProviderFileName] = uuid;
            _metadata = metadata.copy;
            _fileURL = url;
        } else {
            self = nil;
        }
    }
    return self;
}

- (instancetype)initWithReachableMessage:(NSDictionary< NSString*, id >*)reachableMessage {
    self = [super init];
    if(self != nil) {
        _metadata = [NSDictionary dictionaryWithDictionary:reachableMessage];
    }
    return self;
}

- (instancetype)initWithUserInfoTransfer:(WCSessionUserInfoTransfer*)userInfoTransfer {
    self = [super init];
    if(self != nil) {
        _metadata = [NSDictionary dictionaryWithDictionary:userInfoTransfer.userInfo];
        _fileURL = [NSURL fileURLWithPath:[NSFileManager.glb_cachesDirectory stringByAppendingPathComponent:self.fileName]];
    }
    return self;
}

- (instancetype)initWithUserInfo:(NSDictionary< NSString*, id >*)userInfo {
    self = [super init];
    if(self != nil) {
        _metadata = [NSDictionary dictionaryWithDictionary:userInfo];
    }
    return self;
}

- (instancetype)initWithFileTransfer:(WCSessionFileTransfer*)fileTransfer {
    self = [super init];
    if(self != nil) {
        _metadata = [NSDictionary dictionaryWithDictionary:fileTransfer.file.metadata];
        _fileURL = fileTransfer.file.fileURL;
    }
    return self;
}

- (instancetype)initWithFile:(WCSessionFile*)file {
    self = [super init];
    if(self != nil) {
        _metadata = [NSDictionary dictionaryWithDictionary:file.metadata];
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

#if defined(GLB_TARGET_IOS)

- (BOOL)isComplication {
    return [_metadata glb_boolForKey:GLBWatchProviderComplication orDefault:NO];
}

#endif

- (NSString*)fileName {
    return [_metadata glb_stringForKey:GLBWatchProviderFileName orDefault:nil];
}

#pragma mark - Public

- (void)cleanup {
    if(_fileURL != nil) {
        NSError* error = nil;
        if([NSFileManager.defaultManager removeItemAtURL:_fileURL error:&error] == NO) {
            NSLog(@"Failure cleanup command:(%@)", _metadata);
        }
    }
}

@end

/*--------------------------------------------------*/
