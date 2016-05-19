/*--------------------------------------------------*/

#import "UIApplication+GLBUI.h"
#import "UIViewController+GLBUI.h"
#import "UIWindow+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import <objc/runtime.h>

/*--------------------------------------------------*/

@interface UIWindow (GLB_UIApplication)

@end

/*--------------------------------------------------*/

static NSMutableArray* GLBApplicationWindows;

/*--------------------------------------------------*/

@implementation UIWindow (GLB_UIApplication)

#pragma mark - NSObject

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(initWithFrame:)),
                                   class_getInstanceMethod(self, @selector(glb_initWithFrame:)));
    
    method_exchangeImplementations(class_getInstanceMethod(self, NSSelectorFromString(@"dealloc")),
                                   class_getInstanceMethod(self, @selector(glb_dealloc)));
}

#pragma mark - Init / Free

- (id)glb_initWithFrame:(CGRect)frame {
    id instance = [self glb_initWithFrame:frame];
    if(GLBApplicationWindows == nil) {
        CFArrayCallBacks callbacks;
        callbacks.version = 0;
        callbacks.retain = NULL;
        callbacks.release = NULL;
        callbacks.copyDescription = CFCopyDescription;
        callbacks.equal = CFEqual;
        
        GLBApplicationWindows = CFBridgingRelease(CFArrayCreateMutable(CFAllocatorGetDefault(), 0, &callbacks));
    }
    [GLBApplicationWindows addObject:instance];
    return instance;
}

- (void)glb_dealloc {
    [GLBApplicationWindows removeObject:self];
    [self glb_dealloc];
}

@end

/*--------------------------------------------------*/

@implementation UIApplication (GLB_UI)

#pragma mark - Property

- (NSArray*)glb_windows {
    return [GLBApplicationWindows sortedArrayWithOptions:NSSortStable usingComparator:^NSComparisonResult(UIWindow* window1, UIWindow* window2) {
        if(window1.windowLevel < window2.windowLevel) {
            return NSOrderedAscending;
        } else if(window1.windowLevel < window2.windowLevel) {
            return NSOrderedDescending;
        } else {
            return NSOrderedSame;
        }
    }];
}

- (UIWindow*)glb_statusBarWindow {
    Class UIStatusBarWindowClass = NSClassFromString(@"UIStatusBarWindow");
    for(UIWindow* window in self.glb_windows) {
        if([window isKindOfClass:UIStatusBarWindowClass] == YES) {
            return window;
        }
    }
    return nil;
}

- (UIWindow*)glb_visibledWindow {
    NSArray< UIWindow* >* windows = [self.glb_windows filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UIWindow* window, NSDictionary* bindings) {
        return (window.hidden == NO) && (window.glb_userWindow == YES);
    }]];
    return windows.lastObject;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
