//
//  Globus
//

import Globus

class NotificationBottomDecorView: GLBLoadedView, GLBNotificationDecorViewProtocol {
    
    // MARK: - GLBNotificationDecorViewProtocol
    
    var height: CGFloat {
        get {
            return 10.0
        }
    }
    
    // MARK: - GLBNibExtension
    
    public override static func nibName() -> String {
        return "NotificationBottomDecorView-Swift"
    }
    
}
