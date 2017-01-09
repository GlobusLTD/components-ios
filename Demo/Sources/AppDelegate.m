//
//  Globus
//

#import "AppDelegate.h"
#import "ChoiseViewController.h"

@implementation AppDelegate

#pragma mark - Property

@synthesize window = _window;
@synthesize primaryWindow = _primaryWindow;

#pragma mark - Property

- (GLBWindow*)primaryWindow {
    if(_primaryWindow == nil) {
        _primaryWindow = [GLBWindow new];
        self.window = _primaryWindow;
    }
    return _primaryWindow;
}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
    GLBTextStyle* navbarTextStyle = [GLBTextStyle new];
    navbarTextStyle.color = UIColor.darkGrayColor;
    
    UINavigationBar* navbarAppearance = UINavigationBar.appearance;
    navbarAppearance.tintColor = UIColor.lightGrayColor;
    navbarAppearance.titleTextAttributes = navbarTextStyle.attributes;
    
    ChoiseViewController* vc = [ChoiseViewController instantiate];
    GLBNavigationViewController* nvc = [GLBNavigationViewController viewControllerWithRootViewController:vc];
    self.primaryWindow.rootViewController = nvc;
    [self.primaryWindow makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication*)application {
}

- (void)applicationDidEnterBackground:(UIApplication*)application {
}

- (void)applicationWillEnterForeground:(UIApplication*)application {
}

- (void)applicationDidBecomeActive:(UIApplication*)application {
}

- (void)applicationWillTerminate:(UIApplication*)application {
}

@end
