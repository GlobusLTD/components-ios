/*--------------------------------------------------*/

#import "UIApplication+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
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

#pragma mark - Property

- (void)setGlb_userWindow:(BOOL)glb_userWindow {
    objc_setAssociatedObject(self, @selector(glb_userWindow), @(glb_userWindow), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)glb_userWindow {
    return [objc_getAssociatedObject(self, @selector(glb_userWindow)) boolValue];
}

@end

/*--------------------------------------------------*/

@implementation UIViewController (GLB_UIApplication)

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod(UIViewController.class, @selector(setNeedsStatusBarAppearanceUpdate)),
                                   class_getInstanceMethod(UIViewController.class, @selector(glb_setNeedsStatusBarAppearanceUpdate)));
}

- (void)glb_setNeedsStatusBarAppearanceUpdate {
#ifndef GLOBUS_APP_EXTENSION
    [UIApplication.sharedApplication.glb_visibledWindow.rootViewController glb_setNeedsStatusBarAppearanceUpdate];
#endif
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
