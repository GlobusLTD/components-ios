//
//  Globus
//

import Globus

class ButtonViewController: GLBViewController {
    
    // MARK - Outlet property
    
    @IBOutlet fileprivate weak var fillButton: GLBButton!
    @IBOutlet fileprivate weak var strokeButton: GLBButton!
    
    // MARK - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fillNormalTitleStyle = GLBTextStyle.init()
        fillNormalTitleStyle.font = UIFont.boldSystemFont(ofSize: 16)
        fillNormalTitleStyle.color = UIColor.darkGray
        
        let fillHighlightedTitleStyle = GLBTextStyle.init()
        fillHighlightedTitleStyle.font = UIFont.boldSystemFont(ofSize: 16)
        fillHighlightedTitleStyle.color = UIColor.black
        
        self.fillButton.normalTitleStyle = fillNormalTitleStyle
        self.fillButton.normalBackgroundColor = UIColor.lightGray
        self.fillButton.normalCornerRadius = 4.0
        
        self.fillButton.highlightedTitleStyle = fillHighlightedTitleStyle
        self.fillButton.highlightedBackgroundColor = UIColor.darkGray
        self.fillButton.highlightedCornerRadius = 8.0
        
        let strokeNormalTitleStyle = GLBTextStyle.init()
        strokeNormalTitleStyle.font = UIFont.italicSystemFont(ofSize: 16)
        strokeNormalTitleStyle.color = UIColor.lightGray
        
        let strokeHighlightedTitleStyle = GLBTextStyle.init()
        strokeHighlightedTitleStyle.font = UIFont.italicSystemFont(ofSize: 16)
        strokeHighlightedTitleStyle.color = UIColor.darkGray
        
        self.strokeButton.normalTitleStyle = strokeNormalTitleStyle
        self.strokeButton.normalBorderWidth = 1.0
        self.strokeButton.normalBorderColor = UIColor.lightGray
        self.strokeButton.normalCornerRadius = 4.0
        
        self.strokeButton.highlightedTitleStyle = strokeHighlightedTitleStyle
        self.strokeButton.highlightedBorderColor = UIColor.darkGray
        self.strokeButton.highlightedBorderWidth = 2.0
        self.strokeButton.highlightedCornerRadius = 8.0
    }
    
    // MARK - Action
    
    @IBAction internal func pressedMenu(_ sender: Any) {
        self.glb_slideViewController?.showLeftViewController(animated: true, complete: nil)
    }
    
    // MARK: - GLBNibExtension
    
    public override static func nibName() -> String {
        return "ButtonViewController-Swift"
    }
    
}
