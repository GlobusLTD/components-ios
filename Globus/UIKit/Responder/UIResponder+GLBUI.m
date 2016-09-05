/*--------------------------------------------------*/

#import "UIResponder+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

static UIResponder* GLB_CURRENT_FIRST_RESPONDER = nil;

/*--------------------------------------------------*/

@implementation UIResponder (GLB_UI)

#pragma mark - Public

+ (id)glb_currentFirstResponder {
    GLB_CURRENT_FIRST_RESPONDER = nil;
#ifndef GLOBUS_APP_EXTENSION
    [UIApplication.sharedApplication sendAction:@selector(glb_findFirstResponder) to:nil from:nil forEvent:nil];
#endif
    return GLB_CURRENT_FIRST_RESPONDER;
}

+ (id)glb_currentFirstResponderInView:(UIView*)view {
    id responder = self.glb_currentFirstResponder;
    if([responder isKindOfClass:UIView.class]) {
        if([view glb_isContainsSubview:responder]) {
            return responder;
        }
    }
    return nil;
}

+ (UIResponder*)glb_prevResponderFromView:(UIView*)view {
    NSArray* responders = view.window.glb_responders;
    if(responders.count > 1) {
        NSUInteger index = [responders indexOfObject:view];
        if(index != NSNotFound) {
            if(index > 0) {
                return responders[index - 1];
            }
        }
    }
    return nil;
}

+ (UIResponder*)glb_nextResponderFromView:(UIView*)view {
    NSArray* responders = view.window.glb_responders;
    if(responders.count > 1) {
        NSUInteger index = [responders indexOfObject:view];
        if(index != NSNotFound) {
            if(index < responders.count - 1) {
                return responders[index + 1];
            }
        }
    }
    return nil;
}

#pragma mark - Private

- (void)glb_findFirstResponder {
    GLB_CURRENT_FIRST_RESPONDER = self;
}


@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
