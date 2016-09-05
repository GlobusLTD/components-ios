/*--------------------------------------------------*/

#import "GLBStyle.h"

/*--------------------------------------------------*/

@interface GLBStyle ()

@property(nonatomic, readonly, copy) GLBStyleBlock block;

+ (NSMutableDictionary*)_registeredStyles;

- (void)_applyWithTarget:(id)target;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBStyle

#pragma mark - Synthesize

@synthesize name = _name;
@synthesize parent = _parent;
@synthesize block = _block;

#pragma mark - Init / Free

+ (instancetype)styleWithName:(NSString*)name {
    return [self.class _registeredStyles][name];
}

+ (instancetype)styleWithName:(NSString*)name block:(GLBStyleBlock)block {
    return [[self alloc] initWithName:name block:block];
}

+ (instancetype)styleWithName:(NSString*)name parent:(GLBStyle*)parent block:(GLBStyleBlock)block {
    return [[self alloc] initWithName:name parent:parent block:block];
}

- (instancetype)initWithName:(NSString*)name block:(GLBStyleBlock)block {
    return [self initWithName:name parent:nil block:block];
}

- (instancetype)initWithName:(NSString*)name parent:(GLBStyle*)parent block:(GLBStyleBlock)block {
    self = [super init];
    if(self != nil) {
        _name = name;
        _parent = parent;
        _block = block;
        [self setup];
    }
    return self;
}

- (void)setup {
    if(_name.length > 0) {
        [self.class _registeredStyles][_name] = self;
    }
}

#pragma mark - Public

+ (void)unregisterStyleWithName:(NSString*)name {
    [[self.class _registeredStyles] removeObjectForKey:name];
}

#pragma mark - Private

+ (NSMutableDictionary*)_registeredStyles {
    static NSMutableDictionary* styles = nil;
    if(styles == nil) {
        styles = [NSMutableDictionary dictionary];
    }
    return styles;
}

- (void)_applyWithTarget:(id)target {
    if(_parent != nil) {
        [_parent _applyWithTarget:target];
    }
    if(_block != nil) {
        _block(target);
    }
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation UIResponder (GLBStyle)

- (void)setGlb_style:(GLBStyle*)style {
    if(self.glb_style != style) {
        objc_setAssociatedObject(self, @selector(glb_style), style, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        if(style != nil) {
            [style _applyWithTarget:self];
        }
    }
}

- (GLBStyle*)glb_style {
    return objc_getAssociatedObject(self, @selector(glb_style));
}

- (void)setGlb_styleName:(NSString*)styleName {
    self.glb_style = [GLBStyle styleWithName:styleName];
}

- (NSString*)glb_styleName {
    return self.glb_style.name;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
