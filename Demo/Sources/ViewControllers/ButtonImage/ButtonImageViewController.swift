//
//  Globus
//

import Globus

class ButtonImageViewController: GLBViewController {
    
    // MARK - Outlet property
    
    @IBOutlet weak var button: GLBButton!
    
    // MARK - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.button.adjustsImageWhenHighlighted = false
        self.button.imageEdgeInsets = UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
        self.button.titleEdgeInsets = UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
        self.button.glb_normalImage = UIImage.init(named: "ButtonIcon")
        self.button.glb_normalTitleColor = UIColor.darkGray
        self.button.normalBackgroundColor = UIColor.lightGray
        self.button.normalCornerRadius = 4.0
        self.button.glb_highlightedTitleColor = UIColor.black
        self.button.highlightedBackgroundColor = UIColor.darkGray
        self.button.highlightedCornerRadius = 8.0
    }
    
    // MARK - Action
    
    @IBAction internal func pressed(_ sender: Any) {
        switch(self.button.imageAlignment) {
        case .left:
            self.button.imageAlignment = .right
            break;
        case .right:
            self.button.imageAlignment = .top
            break;
        case .top:
            self.button.imageAlignment = .bottom
            break;
        case .bottom:
            self.button.imageAlignment = .left
            break;
        }
    }
    
    //MARK: - GLBNibExtension
    
    public override static func nibName() -> String {
        return "ButtonImageViewController-Swift"
    }
    
}
