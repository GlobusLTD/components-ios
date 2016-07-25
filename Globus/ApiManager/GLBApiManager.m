/*--------------------------------------------------*/

#import "GLBApiManager.h"
#import "GLBApiProvider.h"

/*--------------------------------------------------*/

#import "NSArray+GLBNS.h"

/*--------------------------------------------------*/

@interface GLBApiManager () {
@protected
    NSMutableArray* _providers;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

static GLBApiManager* GLBApiManagerInstance = nil;

/*--------------------------------------------------*/

@implementation GLBApiManager

#pragma mark - Singleton

+ (instancetype)shared {
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        GLBApiManagerInstance = [self new];
    });
    return GLBApiManagerInstance;
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
    _providers = [NSMutableArray array];
}

#pragma mark - Property

- (NSArray*)providers {
    return _providers.copy;
}

#pragma mark - Public

- (void)registerProvider:(GLBApiProvider*)provider {
    @synchronized(self) {
        if([_providers containsObject:provider] == NO) {
            [_providers addObject:provider];
            provider.manager = self;
        }
    }
}

- (void)unregisterProvider:(GLBApiProvider*)provider {
    @synchronized(self) {
        if([_providers containsObject:provider] == YES) {
            [_providers removeObject:provider];
            provider.manager = nil;
        }
    }
}

- (void)cancelRequest:(GLBApiRequest*)request {
    @synchronized(self) {
        [_providers glb_each:^(GLBApiProvider* provider) {
            [provider cancelRequest:request];
        }];
    }
}

- (void)cancelAllRequestsByTarget:(id)target {
    @synchronized(self) {
        [_providers glb_each:^(GLBApiProvider* provider) {
            [provider cancelAllRequestsByTarget:target];
        }];
    }
}

- (void)cancelAllRequests {
    @synchronized(self) {
        [_providers glb_each:^(GLBApiProvider* provider) {
            [provider cancelAllRequests];
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

@end

/*--------------------------------------------------*/
