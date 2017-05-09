//
//  Globus
//

import Globus

class LabelViewController: GLBViewController {
    
    // MARK - Outlet property
    
    @IBOutlet fileprivate weak var label: GLBLabel!
    
    // MARK - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textStyle = GLBTextStyle()
        textStyle.font = UIFont.systemFont(ofSize: 16)
        self.label.textStyle = textStyle
        
        self.label.textColor = UIColor.lightGray
        self.label.text = "This is normal text.\nThis is highlight text.\nThis is pressed text."
        self.label.textAlignment = .center
        self.label.lineBreakMode = .byWordWrapping
        self.label.numberOfLines = 0
        
        let normalStyle = GLBTextStyle()
        normalStyle.font = UIFont.systemFont(ofSize: 15)
        normalStyle.color = UIColor.darkGray
        
        let highlightStyle = GLBTextStyle()
        highlightStyle.font = UIFont.systemFont(ofSize: 17.0)
        highlightStyle.color = UIColor.darkGray
        
        self.label.addLink(string: "highlight", normal: normalStyle, highlight: highlightStyle) {
            NSLog("highlight")
        }
        self.label.addLink(string: "pressed", normal: normalStyle, highlight: highlightStyle) {
            NSLog("pressed")
        }
    }
    
    // MARK - Action
    
    @IBAction internal func pressedMenu(_ sender: Any) {
        self.glb_slideViewController?.showLeftViewController(animated: true, complete: nil)
    }
    
    // MARK: - GLBNibExtension
    
    public override static func nibName() -> String {
        return "LabelViewController-Swift"
    }
    
}
