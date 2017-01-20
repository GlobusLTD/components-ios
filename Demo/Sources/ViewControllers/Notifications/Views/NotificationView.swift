//
//  Globus
//

import Globus

class NotificationView: GLBLoadedView, GLBNotificationViewProtocol {
    
    // MARK - Outlet property
    
    @IBOutlet fileprivate weak var titleLabel: GLBLabel!
    
    // MARK - Public property
    
    public var title: String {
        set(value) {
            self.titleLabel.text = value
        }
        get {
            return self.titleLabel.text!;
        }
    }
    
    // MARK: - GLBNotificationViewProtocol
    
    internal func willShow(_ notificationView: GLBNotificationView) {
        print("willShowNotificationView")
    }
    
    internal func didShow(_ notificationView: GLBNotificationView) {
        print("didShowNotificationView")
    }
    
    internal func willHide(_ notificationView: GLBNotificationView) {
        print("willHideNotificationView")
    }
    
    internal func didHide(_ notificationView: GLBNotificationView) {
        print("didHideNotificationView")
    }
    
    // MARK: - GLBNibExtension
    
    public override static func nibName() -> String {
        return "NotificationView-Swift"
    }
    
}
