//
//  Globus
//

import Globus

class DialogContentViewController: GLBViewController {
    
    // MARK - Action
    
    @IBAction internal func pressedHide(_ sender: Any) {
        self.glb_dialogViewController?.dismiss()
    }
    
    // MARK: - GLBNibExtension
    
    public override static func nibName() -> String {
        return "DialogContentViewController-Swift"
    }
    
}
