//
//  Globus
//

import Globus

class TextFieldViewController: GLBViewController {
    
    // MARK - Outlet property
    
    @IBOutlet weak var textField: GLBTextField!
    
    // MARK - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textStyle = GLBTextStyle.init()
        textStyle.font = UIFont.boldSystemFont(ofSize: 16)
        textStyle.color = UIColor.darkGray
        self.textField.textStyle = textStyle
        
        let placeholderStyle = GLBTextStyle.init()
        placeholderStyle.font = UIFont.boldSystemFont(ofSize: 16)
        placeholderStyle.color = UIColor.lightGray
        self.textField.placeholderStyle = placeholderStyle
        
        self.textField.placeholder = "Placeholder"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.textField.becomeFirstResponder()
    }
    
    // MARK - Action
    
    @IBAction internal func pressedMenu(_ sender: Any) {
        self.glb_slideViewController?.showLeftViewController(animated: true, complete: nil)
    }
    
    @IBAction internal func changedText(_ sender: Any) {
        print("ChangedText: \(self.textField.text)")
    }
    
    // MARK: - GLBNibExtension
    
    public override static func nibName() -> String {
        return "TextFieldViewController-Swift"
    }
    
}
