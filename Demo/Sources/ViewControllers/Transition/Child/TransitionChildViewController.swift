//
//  Globus
//

import Globus

class TransitionChildViewController: TransitionViewController {
    
    // MARK - Action
    
    @IBAction internal func pressedClose(_ sender: Any) {
        self.navigationController!.dismiss(animated: true, completion: nil)
    }
    
    @IBAction internal func pressedModal(_ sender: Any) {
        let vc = TransitionChildViewController.instantiate()!
        let nvc = GLBNavigationViewController.init(rootViewController: vc)
        nvc.transitionNavigation = self.transition
        nvc.transitionModal = self.transition
        self.present(nvc, animated: true, completion: nil)
    }
    
    @IBAction internal func pressedPush(_ sender: Any) {
        let vc = TransitionChildViewController.instantiate()!
        vc.transitionModal = self.transition
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    @IBAction internal func pressedPop(_ sender: Any) {
        _ = self.navigationController!.popViewController(animated: true)
    }
    
    // MARK: - GLBNibExtension
    
    public override static func nibName() -> String {
        return "TransitionChildViewController-Swift"
    }
    
}
