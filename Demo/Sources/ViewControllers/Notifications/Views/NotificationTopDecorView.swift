//
//  Globus
//

import Globus

class NotificationTopDecorView: GLBLoadedView, GLBNotificationDecorViewProtocol {
    
    // MARK: - GLBNotificationDecorViewProtocol
    
    var height: CGFloat {
        get {
            return 20.0
        }
    }
    
    // MARK: - GLBNibExtension
    
    public override static func nibName() -> String {
        return "NotificationTopDecorView-Swift"
    }
    
}
