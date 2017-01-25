//
//  Globus
//

import Globus

class TransitionViewController: GLBViewController {
    
    // MARK - Outlet property
    
    @IBOutlet fileprivate weak var listField: GLBListField!
    
    // MARK - Internal property
    
    internal var transition: GLBTransitionController? {
        didSet {
            if let materialTransition = self.transition as? GLBMaterialTransitionController {
                materialTransition.backgroundColor = UIColor.red
            }
        }
    }
    
    // MARK - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listField.items = [
            GLBListFieldItem.init(title: "Default", value:nil),
            GLBListFieldItem.init(title: GLBCrossFadeTransitionController.glb_className(), value:GLBCrossFadeTransitionController.self),
            GLBListFieldItem.init(title: GLBMaterialTransitionController.glb_className(), value:GLBMaterialTransitionController.self),
            GLBListFieldItem.init(title: GLBSlideTransitionController.glb_className(), value:GLBSlideTransitionController.self),
            GLBListFieldItem.init(title: GLBCardsTransitionController.glb_className(), value:GLBCardsTransitionController.self),
        ]
    }
    
    // MARK - Action
    
    @IBAction internal func pressedMenu(_ sender: Any) {
        self.glb_slideViewController?.showLeftViewController(animated: true, complete: nil)
    }
    
    @IBAction internal func changedSelectedItem(_ sender: Any) {
        if let selected = self.listField.selectedItem {
            if let transitionControllerClass = selected.value as? GLBTransitionController.Type {
                self.transition = transitionControllerClass.init();
            } else {
                self.transition = nil
            }
        } else {
            self.transition = nil
        }
    }
    
}
