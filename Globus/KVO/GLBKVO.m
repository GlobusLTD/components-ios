/*--------------------------------------------------*/

#import "GLBKVO.h"

/*--------------------------------------------------*/

#import "NSObject+GLBNS.h"

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
        
		[_subject addObserver:self forKeyPath:keyPath options:(NSKeyValueObservingOptions)(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:GLBKVOContext];
	}
    return self;
}

- (void)dealloc {
    [_subject removeObserver:self forKeyPath:_keyPath context:GLBKVOContext];
    _subject = nil;
}

#pragma mark - Private

- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context {
	if(context == GLBKVOContext) {
		if(_block != nil) {
			id oldValue = change[NSKeyValueChangeOldKey];
			if([oldValue glb_isNull] == YES) {
				oldValue = nil;
            }
            id newValue = change[NSKeyValueChangeNewKey];
            if([newValue glb_isNull] == YES) {
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
