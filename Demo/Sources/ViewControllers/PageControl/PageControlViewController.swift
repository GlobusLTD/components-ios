//
//  Globus
//

import Globus

class PageControlViewController: GLBViewController {
    
    // MARK - Outlet property
    
    @IBOutlet fileprivate weak var pageControl: GLBPageControl!
    
    // MARK - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageControl.tapBehavior = .jump
        self.pageControl.numberOfPages = 10
    }
    
    // MARK - Action
    
    @IBAction internal func pressedMenu(_ sender: Any) {
        self.glb_slideViewController?.showLeftViewController(animated: true, complete: nil)
    }
    
    // MARK: - GLBNibExtension
    
    public override static func nibName() -> String {
        return "PageControlViewController-Swift"
    }
    
}
