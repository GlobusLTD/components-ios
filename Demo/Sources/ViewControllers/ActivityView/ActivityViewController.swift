//
//  Globus
//

import Globus

class ActivityViewController: GLBViewController {
    
    // MARK - Outlet property
    
    @IBOutlet fileprivate weak var listField: GLBListField!
    @IBOutlet fileprivate weak var showButton: GLBButton!
    
    private var timer: GLBTimer?
    
    // MARK - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.timer = GLBTimer(interval: 5.0);
        self.timer!.actionFinished = GLBAction(target: self, action: #selector(timerFinished));

        self.listField.items = [
            GLBListFieldItem(title: GLBArcSpinnerView.glb_className(), value:GLBArcSpinnerView.self),
            GLBListFieldItem(title: GLBArcAltSpinnerView.glb_className(), value:GLBArcAltSpinnerView.self),
            GLBListFieldItem(title: GLBBounceSpinnerView.glb_className(), value:GLBBounceSpinnerView.self),
            GLBListFieldItem(title: GLBChasingDotsSpinnerView.glb_className(), value:GLBChasingDotsSpinnerView.self),
            GLBListFieldItem(title: GLBCircleSpinnerView.glb_className(), value:GLBCircleSpinnerView.self),
            GLBListFieldItem(title: GLBCircleFlipSpinnerView.glb_className(), value:GLBCircleFlipSpinnerView.self),
            GLBListFieldItem(title: GLBFadingCircleSpinnerView.glb_className(), value:GLBFadingCircleSpinnerView.self),
            GLBListFieldItem(title: GLBFadingCircleAltSpinnerView.glb_className(), value:GLBFadingCircleAltSpinnerView.self),
            GLBListFieldItem(title: GLBNineCubeGridSpinnerView.glb_className(), value:GLBNineCubeGridSpinnerView.self),
            GLBListFieldItem(title: GLBPlaneSpinnerView.glb_className(), value:GLBPlaneSpinnerView.self),
            GLBListFieldItem(title: GLBPulseSpinnerView.glb_className(), value:GLBPulseSpinnerView.self),
            GLBListFieldItem(title: GLBThreeBounceSpinnerView.glb_className(), value:GLBThreeBounceSpinnerView.self),
            GLBListFieldItem(title: GLBWanderingCubesSpinnerView.glb_className(), value:GLBWanderingCubesSpinnerView.self),
            GLBListFieldItem(title: GLBWaveSpinnerView.glb_className(), value:GLBWaveSpinnerView.self),
            GLBListFieldItem(title: GLBWordPressSpinnerView.glb_className(), value:GLBWordPressSpinnerView.self),
        ]
        
        self.activityView = GLBActivityView();
        self.activityView!.spinnerView = GLBArcSpinnerView()
        self.activityView!.textLabel!.text = "This is activity message"
    }
    
    // MARK - Action
    
    @IBAction internal func pressedMenu(_ sender: Any) {
        self.glb_slideViewController?.showLeftViewController(animated: true, complete: nil)
    }
    
    @IBAction internal func pressedShow(_ sender: Any) {
        if let activityView = self.activityView {
            self.listField.resignFirstResponder()
            activityView.show()
            self.timer!.start()
        }
    }
    
    @IBAction internal func changedSelectedItem(_ sender: Any) {
        if let selected = self.listField.selectedItem {
            if let spinnerViewClass = selected.value as? GLBSpinnerView.Type {
                self.activityView!.spinnerView = spinnerViewClass.init()
            } else {
                self.activityView!.spinnerView = nil
            }
        } else {
            self.activityView!.spinnerView = nil
        }
    }
    
    // MARK: - Timer
    
    @objc private func timerFinished() {
        self.activityView!.hideComplete {
            self.listField.becomeFirstResponder()
        }
    }
    
    // MARK: - GLBNibExtension
    
    public override static func nibName() -> String {
        return "ActivityViewController-Swift"
    }
    
}
