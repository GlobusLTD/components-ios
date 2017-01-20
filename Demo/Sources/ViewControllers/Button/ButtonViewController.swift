//
//  Globus
//

import Globus

class ButtonViewController: GLBViewController {
    
    // MARK - Outlet property
    
    @IBOutlet fileprivate weak var fillButton: GLBButton!
    @IBOutlet fileprivate weak var strokeButton: GLBButton!
    @IBOutlet fileprivate weak var tintFillButton: GLBButton!
    @IBOutlet fileprivate weak var tintStrokeButton: GLBButton!
    
    fileprivate lazy var fillNormalStyle: GLBTextStyle = {
        let style = GLBTextStyle()
        style.font = UIFont.boldSystemFont(ofSize: 16)
        style.color = UIColor.darkGray
        return style
    }()
    fileprivate lazy var fillHighlightedStyle: GLBTextStyle = {
        let style = GLBTextStyle()
        style.font = UIFont.boldSystemFont(ofSize: 16)
        style.color = UIColor.black
        return style
    }()
    fileprivate lazy var strokeNormalStyle: GLBTextStyle = {
        let style = GLBTextStyle()
        style.font = UIFont.italicSystemFont(ofSize: 16)
        style.color = UIColor.lightGray
        return style
    }()
    fileprivate lazy var strokeHighlightedStyle: GLBTextStyle = {
        let style = GLBTextStyle()
        style.font = UIFont.italicSystemFont(ofSize: 16)
        style.color = UIColor.darkGray
        return style
    }()
    
    // MARK - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fillButton.contentEdgeInsets = UIEdgeInsets.init(top: 4, left: 4, bottom: 4, right: 4)
        self.fillButton.normalTitleStyle = self.fillNormalStyle
        self.fillButton.normalBackgroundColor = UIColor.lightGray
        self.fillButton.normalCornerRadius = 4.0
        self.fillButton.highlightedTitleStyle = self.fillHighlightedStyle
        self.fillButton.highlightedBackgroundColor = UIColor.darkGray
        self.fillButton.highlightedCornerRadius = 8.0
        
        self.strokeButton.contentEdgeInsets = UIEdgeInsets.init(top: 4, left: 4, bottom: 4, right: 4)
        self.strokeButton.normalTitleStyle = self.strokeNormalStyle
        self.strokeButton.normalBorderWidth = 1.0
        self.strokeButton.normalBorderColor = UIColor.lightGray
        self.strokeButton.normalCornerRadius = 4.0
        self.strokeButton.highlightedTitleStyle = self.strokeHighlightedStyle
        self.strokeButton.highlightedBorderColor = UIColor.darkGray
        self.strokeButton.highlightedBorderWidth = 2.0
        self.strokeButton.highlightedCornerRadius = 8.0
        
        self.tintFillButton.contentEdgeInsets = UIEdgeInsets.init(top: 4, left: 4, bottom: 4, right: 4)
        self.tintFillButton.glb_normalImage = UIImage.glb_imageNamed("ButtonIcon", renderingMode: .alwaysTemplate)
        self.tintFillButton.normalTitleStyle = self.fillNormalStyle
        self.tintFillButton.normalBackgroundColor = UIColor.lightGray
        self.tintFillButton.normalCornerRadius = 4.0
        self.tintFillButton.normalTintColor = UIColor.darkGray
        self.tintFillButton.highlightedTitleStyle = self.fillHighlightedStyle
        self.tintFillButton.highlightedBackgroundColor = UIColor.darkGray
        self.tintFillButton.highlightedCornerRadius = 8.0
        self.tintFillButton.highlightedTintColor = UIColor.black
        
        self.tintStrokeButton.contentEdgeInsets = UIEdgeInsets.init(top: 4, left: 4, bottom: 4, right: 4)
        self.tintStrokeButton.glb_normalImage = UIImage.glb_imageNamed("ButtonIcon", renderingMode: .alwaysTemplate)
        self.tintStrokeButton.normalTitleStyle = self.strokeNormalStyle
        self.tintStrokeButton.normalBorderWidth = 1.0
        self.tintStrokeButton.normalBorderColor = UIColor.lightGray
        self.tintStrokeButton.normalCornerRadius = 4.0
        self.tintStrokeButton.normalTintColor = UIColor.lightGray
        self.tintStrokeButton.highlightedTitleStyle = self.strokeHighlightedStyle;
        self.tintStrokeButton.highlightedBorderColor = UIColor.darkGray
        self.tintStrokeButton.highlightedBorderWidth = 2.0
        self.tintStrokeButton.highlightedCornerRadius = 8.0
        self.tintStrokeButton.highlightedTintColor = UIColor.darkGray
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
