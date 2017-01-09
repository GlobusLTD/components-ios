//
//  Globus
//

import Globus

class ButtonViewController: GLBViewController {
    
    // MARK - Outlet property
    
    @IBOutlet weak var fillButton: GLBButton!
    @IBOutlet weak var strokeButton: GLBButton!
    
    // MARK - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fillButton.glb_normalTitleColor = UIColor.darkGray
        self.fillButton.normalBackgroundColor = UIColor.lightGray
        self.fillButton.normalCornerRadius = 4.0
        
        self.fillButton.glb_highlightedTitleColor = UIColor.black
        self.fillButton.highlightedBackgroundColor = UIColor.darkGray
        self.fillButton.highlightedCornerRadius = 8.0
        
        self.strokeButton.glb_normalTitleColor = UIColor.lightGray
        self.strokeButton.normalBorderWidth = 1.0
        self.strokeButton.normalBorderColor = UIColor.lightGray
        self.strokeButton.normalCornerRadius = 4.0
        
        self.strokeButton.glb_highlightedTitleColor = UIColor.darkGray
        self.strokeButton.highlightedBorderColor = UIColor.darkGray
        self.strokeButton.highlightedBorderWidth = 2.0
        self.strokeButton.highlightedCornerRadius = 8.0
    }
    
    //MARK: - GLBNibExtension
    
    public override static func nibName() -> String {
        return "ButtonViewController-Swift"
    }
    
}
