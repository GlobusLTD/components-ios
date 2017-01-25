//
//  Globus
//

import Globus

class DialogRootViewController: GLBViewController {
    
    // MARK - Outlet property
    
    @IBOutlet fileprivate weak var listField: GLBListField!
    
    // MARK - Internal property
    
    internal lazy var contentViewController: DialogContentViewController = {
        return DialogContentViewController.instantiate()!
    }()
    internal lazy var dialogViewController: GLBDialogViewController = {
        let vc = GLBDialogViewController.init(contentViewController: self.contentViewController)
        vc.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        vc.isBackgroundBlurred = false
        vc.contentVerticalAlignment = .center
        vc.contentHorizontalAlignment = .center
        vc.contentWidthBehaviour = .fill
        vc.contentHeightBehaviour = .fit
        vc.contentInset = UIEdgeInsets.init(top: 16, left: 16, bottom: 16, right: 16)
        return vc
    }()
    
    // MARK - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listField.items = [
            GLBListFieldItem.init(title: "Default", value:nil),
            GLBListFieldItem.init(title: GLBDialogPushAnimationController.glb_className(), value:GLBDialogPushAnimationController.self),
        ]
    }
    
    // MARK - Action
    
    @IBAction internal func pressedMenu(_ sender: Any) {
        self.glb_slideViewController?.showLeftViewController(animated: true, complete: nil)
    }
    
    @IBAction internal func changedSelectedItem(_ sender: Any) {
        if let selected = self.listField.selectedItem {
            if let animationControllerClass = selected.value as? GLBDialogAnimationController.Type {
                self.dialogViewController.animationController = animationControllerClass.init();
            } else {
                self.dialogViewController.animationController = nil
            }
        } else {
            self.dialogViewController.animationController = nil
        }
    }
    
    @IBAction internal func pressedShow(_ sender: Any) {
        self.dialogViewController.present(completion: nil)
    }
    
    // MARK: - GLBNibExtension
    
    public override static func nibName() -> String {
        return "DialogRootViewController-Swift"
    }
    
}
