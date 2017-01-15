//
//  Globus
//

import Globus

class TextViewViewController: GLBViewController {
    
    // MARK - Outlet property
    
    @IBOutlet weak var textView: GLBTextView!
    
    // MARK - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textView.glb_borderColor = UIColor.darkGray;
        self.textView.glb_borderWidth = 1;
        self.textView.glb_cornerRadius = 4;
        
        self.textView.minimumHeight = 48;
        self.textView.maximumHeight = 96;

        let placeholderStyle = GLBTextStyle.init()
        placeholderStyle.font = UIFont.boldSystemFont(ofSize: 16)
        placeholderStyle.color = UIColor.lightGray
        self.textView.placeholderStyle = placeholderStyle
        self.textView.placeholder = "Placeholder"
        self.textView.actionValueChanged = GLBAction.init(target: self, action: #selector(changedText(_:)))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.textView.becomeFirstResponder()
    }
    
    // MARK - Action
    
    @IBAction internal func pressedMenu(_ sender: Any) {
        self.glb_slideViewController?.showLeftViewController(animated: true, complete: nil)
    }
    
    @IBAction internal func changedText(_ sender: Any) {
        print("ChangedText: \(self.textView.text)")
    }
    
    // MARK: - GLBNibExtension
    
    public override static func nibName() -> String {
        return "TextViewViewController-Swift"
    }
    
}
