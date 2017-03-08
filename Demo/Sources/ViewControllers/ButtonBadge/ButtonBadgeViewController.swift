//
//  Globus
//

import Globus

class ButtonBadgeViewController: GLBViewController {
    
    // MARK - Outlet property
    
    @IBOutlet fileprivate weak var button: GLBButton!
    
    // MARK - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.button.glb_normalImage = UIImage.init(named: "ButtonIcon")
        self.button.normalBackgroundColor = UIColor.lightGray
        self.button.highlightedBackgroundColor = UIColor.lightGray
        self.button.normalCornerRadius = 4.0
        self.button.adjustsImageWhenHighlighted = false
        self.button.imageView?.backgroundColor = UIColor.darkGray
        self.button.titleLabel?.backgroundColor = UIColor.darkGray
        self.button.badgeView?.textLabel.text = "X"
    }
    
    // MARK - Action
    
    @IBAction internal func pressedMenu(_ sender: Any) {
        self.glb_slideViewController?.showLeftViewController(animated: true, complete: nil)
    }
    
    @IBAction internal func pressed(_ sender: Any) {
        switch(self.button.badgeAlias) {
            case .title:
                self.button.badgeAlias = .image
            break;
            case .image:
                self.button.badgeAlias = .content
            break;
            case .content:
                self.button.badgeAlias = .title
            break;
        }
    }
    
    // MARK: - GLBNibExtension
    
    public override static func nibName() -> String {
        return "ButtonBadgeViewController-Swift"
    }
    
}
