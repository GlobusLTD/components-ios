//
//  Globus
//

import Globus

class ListFieldViewController: GLBViewController {
    
    // MARK - Outlet property
    
    @IBOutlet fileprivate weak var listField: GLBListField!
    
    // MARK - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textStyle = GLBTextStyle()
        textStyle.font = UIFont.boldSystemFont(ofSize: 16)
        textStyle.color = UIColor.darkGray
        self.listField.textStyle = textStyle
        
        let placeholderStyle = GLBTextStyle()
        placeholderStyle.font = UIFont.boldSystemFont(ofSize: 16)
        placeholderStyle.color = UIColor.lightGray
        self.listField.placeholderStyle = placeholderStyle
        
        self.listField.placeholder = "Placeholder"
        self.listField.items = [
            GLBListFieldItem(title: "Item #1", value:1),
            GLBListFieldItem(title: "Item #2", value:2),
            GLBListFieldItem(title: "Item #3", value:3),
            GLBListFieldItem(title: "Item #4", value:4),
            GLBListFieldItem(title: "Item #5", value:5),
            GLBListFieldItem(title: "Item #6", value:6)
        ]
        self.listField.selectedItem = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.listField.becomeFirstResponder()
    }
    
    // MARK - Action
    
    @IBAction internal func pressedMenu(_ sender: Any) {
        self.glb_slideViewController?.showLeftViewController(animated: true, complete: nil)
    }
    
    @IBAction internal func changedSelectedItem(_ sender: Any) {
        print("ChangedSelectedItem: \(self.listField.selectedItem?.value)");
    }
    
    // MARK: - GLBNibExtension
    
    public override static func nibName() -> String {
        return "ListFieldViewController-Swift"
    }
    
}
