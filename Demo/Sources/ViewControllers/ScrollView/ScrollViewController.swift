//
//  Globus
//

import Globus

class ScrollViewController: GLBViewController {
    
    // MARK - Outlet property
    
    @IBOutlet fileprivate weak var listField: GLBListField!
    @IBOutlet fileprivate weak var scrollView: GLBScrollView!
    
    // MARK - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listField.items = [
            GLBListFieldItem(title: "Stretch", value:GLBScrollViewDirection.stretch),
            GLBListFieldItem(title: "Horizontal", value:GLBScrollViewDirection.horizontal),
            GLBListFieldItem(title: "Vertical", value:GLBScrollViewDirection.vertical)
        ]
        self.scrollView.direction = .stretch
    }
    
    // MARK - Action
    
    @IBAction internal func pressedMenu(_ sender: Any) {
        self.glb_slideViewController?.showLeftViewController(animated: true, complete: nil)
    }
    
    @IBAction internal func changedSelectedItem(_ sender: Any) {
        if let direction = self.listField.selectedItem?.value as? GLBScrollViewDirection {
            self.scrollView.direction = direction
        }
    }
    
    // MARK: - GLBNibExtension
    
    public override static func nibName() -> String {
        return "ScrollViewController-Swift"
    }
    
}
