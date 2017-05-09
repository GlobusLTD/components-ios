//
//  Globus
//

import Globus
import GlobusSwifty
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Property
    
    public lazy var primaryWindow: GLBWindow = self.initPrimaryWindow()
    
    // MARK: - Init property
    
    private func initPrimaryWindow() -> GLBWindow {
        let result = GLBWindow()
        self.window = result;
        return result
    }
    
    // MARK: - UIApplicationDelegate

    public var window: UIWindow? = nil

    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Fabric.with([Crashlytics.self])
        
        let navbarTextStyle = GLBTextStyle()
        navbarTextStyle.color = UIColor.darkGray
        
        let navbarAppearance = UINavigationBar.appearance()
        navbarAppearance.tintColor = UIColor.lightGray
        navbarAppearance.titleTextAttributes = navbarTextStyle.attributes
        
        let svc = GLBSlideViewController();
        svc.leftViewController = GLBNavigationViewController(rootViewController: ChoiseViewController.instantiate()!)
        svc.centerViewController = GLBNavigationViewController(rootViewController: MainViewController.instantiate()!)
        self.primaryWindow.rootViewController = svc
        self.primaryWindow.makeKeyAndVisible()
        return true
    }

    public func applicationWillResignActive(_ application: UIApplication) {
    }

    public func applicationDidEnterBackground(_ application: UIApplication) {
    }

    public func applicationWillEnterForeground(_ application: UIApplication) {
    }

    public func applicationDidBecomeActive(_ application: UIApplication) {
    }

    public func applicationWillTerminate(_ application: UIApplication) {
    }

}

