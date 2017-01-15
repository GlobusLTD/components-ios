//
//  Globus
//

import Globus

class MainViewController: GLBWebViewController {
    
    // MARK - Init / Free
    
    override func setup() {
        super.setup()
    
        self.allowsDoneBarButton = false;
        self.isToolbarHidden = true;
    }
    
    // MARK - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.url == nil {
            self.url = URL.init(string: "http://globus-ltd.ru")
        }
    }
    
    // MARK - Action
    
    @IBAction internal func pressedMenu(_ sender: Any) {
        self.glb_slideViewController?.showLeftViewController(animated: true, complete: nil)
    }
    
    // MARK: - GLBNibExtension
    
    public override static func nibName() -> String {
        return "MainViewController-Swift"
    }
    
}
