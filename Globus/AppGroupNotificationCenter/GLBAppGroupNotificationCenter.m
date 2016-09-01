/*--------------------------------------------------*/

#import "GLBAppGroupNotificationCenter.h"
#import "GLBAction.h"

/*--------------------------------------------------*/

static NSString* const GLBAppGroupNotificationCenterNotification = @"GLBAppGroupNotificationCenterNotification";

/*--------------------------------------------------*/

@interface GLBAppGroupNotificationCenter ()

@property(nonatomic, strong) NSNumber* processId;
@property(nonatomic, strong) NSFileManager* fileManager;
@property(nonatomic, strong) NSString* messagePassingPath;
@property(nonatomic, strong) NSMutableDictionary* observers;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

static NSString* GLBAppGroupNotificationCenterProcessIdKey = @"ProcessId";
static NSString* GLBAppGroupNotificationCenterCustomKey = @"Custom";

/*--------------------------------------------------*/

static void GLBAppGroupNotificationCenterNotificationCallback(CFNotificationCenterRef center, void* observer, CFStringRef name, const void* object, CFDictionaryRef userInfo) {
    [NSNotificationCenter.defaultCenter postNotificationName:GLBAppGroupNotificationCenterNotification object:(__bridge_transfer NSString*)name userInfo:nil];
}

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBAppGroupNotificationCenter

#pragma mark Synthesize

@synthesize messagePassingPath = _messagePassingPath;

#pragma mark Init / Free

- (instancetype)initWithIdentifier:(NSString*)identifier directory:(NSString*)directory {
    self = [super init];
    if(self != nil) {
        _identifier = identifier.copy;
        _directory = directory.copy;
        [self setup];
    }
    return self;
}

- (void)setup {
    _fileManager = [NSFileManager new];
    _processId = @(NSProcessInfo.processInfo.processIdentifier);
    _observers = [NSMutableDictionary dictionary];
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(_receiveNotification:) name:GLBAppGroupNotificationCenterNotification object:nil];
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
    CFNotificationCenterRemoveEveryObserver(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge const void*)self);
    
    [self _cleanupAllTempFiles];
}

#pragma mark Public static

+ (BOOL)isSupported {
    return [NSFileManager.defaultManager respondsToSelector:@selector(containerURLForSecurityApplicationGroupIdentifier:)];
}

#pragma mark Public

- (void)postNotificationName:(NSString*)name object:(id< NSCoding >)object {
    if(name.length > 0) {
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            __strong typeof(self) strongSelf = weakSelf;
            NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
            userInfo[GLBAppGroupNotificationCenterProcessIdKey] = strongSelf.processId;
            if(object != nil) {
                userInfo[GLBAppGroupNotificationCenterCustomKey] = object;
            }
            NSString* userInfoFilePath = [strongSelf _objectFilePathForName:name];
            NSData* userInfoData = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
            if([userInfoData writeToFile:userInfoFilePath atomically:YES] == YES) {
                [strongSelf _postDarwinNotificationWithName:name];
            }
        });
    }
}

- (void)addObserver:(id)observer selector:(SEL)selector name:(NSString*)name {
    if((observer != nil) && (selector != NULL) && (name.length > 0)) {
        NSMutableArray* actions = _observers[name];
        if(actions == nil) {
            actions = [NSMutableArray array];
            _observers[name] = actions;
            
            [self _addDarwinObserverWithName:name];
        }
        GLBAction* action = [GLBAction actionWithTarget:observer action:selector];
        if(action != nil) {
            [actions addObject:action];
        }
    }
}

- (void)removeObserver:(id)observer name:(NSString*)name {
    if((observer != nil) && (name.length > 0)) {
        NSMutableArray* actions = _observers[name];
        [actions glb_each:^(GLBAction* action) {
            if(action.target == observer) {
                [actions removeObject:action];
            }
        }];
    }
}

- (void)removeObserver:(id)observer {
    if(observer != nil) {
        [_observers glb_each:^(NSString* name, NSMutableArray* actions) {
            [actions glb_each:^(GLBAction* action) {
                if(action.target == observer) {
                    [actions removeObject:action];
                }
            }];
        }];
    }
}

#pragma mark - Property

- (NSString*)messagePassingPath {
    if(_messagePassingPath == nil) {
        NSURL* containerUrl = [_fileManager containerURLForSecurityApplicationGroupIdentifier:_identifier];
        NSString* containerPath = containerUrl.path;
        if(_directory != nil) {
            containerPath = [containerPath stringByAppendingPathComponent:_directory];
        }
        if([_fileManager fileExistsAtPath:containerPath] == NO) {
            if([_fileManager createDirectoryAtPath:containerPath withIntermediateDirectories:YES attributes:nil error:NULL] == YES) {
                _messagePassingPath = containerPath;
            }
        } else {
            _messagePassingPath = containerPath;
        }
    }
    return _messagePassingPath;
}

#pragma mark Private

- (NSString*)_objectFilePathForName:(NSString*)name {
    return [self.messagePassingPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.archive", name]];
}

- (void)_cleanupAllTempFiles {
    if(_directory != nil) {
        NSString* messagePassingPath = self.messagePassingPath;
        if(messagePassingPath == nil) {
            return;
        }
        NSArray* messageFiles = [_fileManager contentsOfDirectoryAtPath:messagePassingPath error:nil];
        for(NSString* path in messageFiles) {
            [_fileManager removeItemAtPath:[messagePassingPath stringByAppendingPathComponent:path] error:NULL];
        }
    }
}

- (void)_postDarwinNotificationWithName:(NSString*)name {
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge_retained CFStringRef)name, NULL, NULL, TRUE);
}

- (void)_addDarwinObserverWithName:(NSString*)name {
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge const void*)self, GLBAppGroupNotificationCenterNotificationCallback, (__bridge_retained CFStringRef)name, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
}

- (void)_removeDarwinObserverWithName:(NSString*)name {
    CFNotificationCenterRemoveObserver(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge const void*)self, (__bridge_retained CFStringRef)name, NULL);
}

- (void)_receiveNotification:(NSNotification*)notification {
    NSString* name = notification.object;
    if(name != nil) {
        NSDictionary* userInfo = nil;
        NSString* userInfoFilePath = [self _objectFilePathForName:name];
        if([_fileManager fileExistsAtPath:userInfoFilePath] == YES) {
            NSData* userInfoData = [NSData dataWithContentsOfFile:userInfoFilePath];
            if(userInfoData != nil) {
                userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:userInfoData];
            }
        }
        if(userInfo != nil) {
            NSNumber* processId = userInfo[GLBAppGroupNotificationCenterProcessIdKey];
            if([_processId isEqualToNumber:processId] == NO) {
                NSMutableArray* arguments = [NSMutableArray arrayWithObject:name];
                if(arguments != nil) {
                    id custom = userInfo[GLBAppGroupNotificationCenterCustomKey];
                    if(custom != nil) {
                        [arguments addObject:custom];
                    }
                    NSMutableArray* actions = _observers[name];
                    [actions glb_each:^(GLBAction* action) {
                        [action performWithArguments:arguments];
                    }];
                }
            }
        }
    }
}

@end

/*--------------------------------------------------*/
