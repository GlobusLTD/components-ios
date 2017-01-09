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
        
        self.button.glb_normalImage = UIImage.init(named: "ButtonIcon")
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
