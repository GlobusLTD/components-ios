//
//  Globus
//

import Globus

class TransitionRootViewController: TransitionViewController {
    
    // MARK - Action
    
    @IBAction internal func pressedPresent(_ sender: Any) {
        let vc = TransitionChildViewController.instantiate()!
        let nvc = GLBNavigationViewController(rootViewController: vc)
        nvc.transitionNavigation = self.transition
        nvc.transitionModal = self.transition
        self.present(nvc, animated: true, completion: nil)
    }
    
    // MARK: - GLBNibExtension
    
    public override static func nibName() -> String {
        return "TransitionRootViewController-Swift"
    }
    
}
