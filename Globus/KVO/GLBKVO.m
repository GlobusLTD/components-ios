/*--------------------------------------------------*/

#import "GLBKVO.h"

/*--------------------------------------------------*/

static void* GLBKVOContext = &GLBKVOContext;

/*--------------------------------------------------*/

@interface GLBKVO () {
    __weak id _subject;
    NSString* _keyPath;
}

@end

/*--------------------------------------------------*/

@implementation GLBKVO

#pragma mark - Init / Free

- (instancetype)initWithSubject:(id)subject keyPath:(NSString*)keyPath block:(GLBKVOBlock)block {
	self = [super init];
	if(self != nil) {
        _subject = subject;
        _keyPath = keyPath;
        _block = block;
        
		[subject addObserver:self forKeyPath:keyPath options:(NSKeyValueObservingOptions)(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:GLBKVOContext];
        
        [self setup];
	}
    return self;
}

- (void)setup {
}

- (void)dealloc {
	[self stopObservation];
}

#pragma mark - Public

- (void)stopObservation {
	[_subject removeObserver:self forKeyPath:_keyPath context:GLBKVOContext];
    _subject = nil;
}

#pragma mark - Private

- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context {
	if(context == GLBKVOContext) {
		if(_block != nil) {
			id oldValue = change[NSKeyValueChangeOldKey];
			if(oldValue == [NSNull null]) {
				oldValue = nil;
            }
			id newValue = change[NSKeyValueChangeNewKey];
			if(newValue == [NSNull null]) {
				newValue = nil;
            }
			_block(self, oldValue, newValue);
		}
	}
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation NSObject (GLBKVO)

- (GLBKVO*)glb_observeKeyPath:(NSString*)keyPath withBlock:(GLBKVOBlock)block {
	return [[GLBKVO alloc] initWithSubject:self keyPath:keyPath block:block];
}

- (GLBKVO*)glb_observeSelector:(SEL)selector withBlock:(GLBKVOBlock)block {
	return [[GLBKVO alloc] initWithSubject:self keyPath:NSStringFromSelector(selector) block:block];
}

@end

/*--------------------------------------------------*/
