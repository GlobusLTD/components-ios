/*--------------------------------------------------*/

#import "GLBTouchView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBTouchView

#pragma mark - Init / Free

- (instancetype)initWithCoder:(NSCoder*)coder {
    self = [super initWithCoder:coder];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (void)setup {
}

#pragma mark - Public override

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event {
    UIView* view = nil;
    if(self.receiver != nil) {
        if([self pointInside:point withEvent:event] == YES) {
            view = self.receiver;
        }
    } else {
        view = [super hitTest:point withEvent:event];
        if(view == self) {
            view = nil;
        }
    }
    return view;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
