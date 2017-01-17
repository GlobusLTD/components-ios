//
//  Globus
//

import Globus

class ActivityViewController: GLBViewController {
    
    // MARK - Outlet property
    
    @IBOutlet fileprivate weak var listField: GLBListField!
    @IBOutlet fileprivate weak var showButton: GLBButton!
    
    private var spinnerView: GLBSpinnerView? {
        willSet {
            self.activityView = nil;
        }
        didSet {
            if let spinnerView = self.spinnerView {
                self.activityView = GLBActivityView.init(spinnerView: spinnerView, text: "Activity message")
            }
        }
    }
    private var timer: GLBTimer?
    
    // MARK - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.timer = GLBTimer.init(interval: 5.0);
        self.timer!.actionFinished = GLBAction.init(target: self, action: #selector(timerFinished));

        self.listField.items = [
            GLBListFieldItem.init(title: GLBArcSpinnerView.glb_className(), value:GLBArcSpinnerView.self),
            GLBListFieldItem.init(title: GLBArcAltSpinnerView.glb_className(), value:GLBArcAltSpinnerView.self),
            GLBListFieldItem.init(title: GLBBounceSpinnerView.glb_className(), value:GLBBounceSpinnerView.self),
            GLBListFieldItem.init(title: GLBChasingDotsSpinnerView.glb_className(), value:GLBChasingDotsSpinnerView.self),
            GLBListFieldItem.init(title: GLBCircleSpinnerView.glb_className(), value:GLBCircleSpinnerView.self),
            GLBListFieldItem.init(title: GLBCircleFlipSpinnerView.glb_className(), value:GLBCircleFlipSpinnerView.self),
            GLBListFieldItem.init(title: GLBFadingCircleSpinnerView.glb_className(), value:GLBFadingCircleSpinnerView.self),
            GLBListFieldItem.init(title: GLBFadingCircleAltSpinnerView.glb_className(), value:GLBFadingCircleAltSpinnerView.self),
            GLBListFieldItem.init(title: GLBNineCubeGridSpinnerView.glb_className(), value:GLBNineCubeGridSpinnerView.self),
            GLBListFieldItem.init(title: GLBPlaneSpinnerView.glb_className(), value:GLBPlaneSpinnerView.self),
            GLBListFieldItem.init(title: GLBPulseSpinnerView.glb_className(), value:GLBPulseSpinnerView.self),
            GLBListFieldItem.init(title: GLBThreeBounceSpinnerView.glb_className(), value:GLBThreeBounceSpinnerView.self),
            GLBListFieldItem.init(title: GLBWanderingCubesSpinnerView.glb_className(), value:GLBWanderingCubesSpinnerView.self),
            GLBListFieldItem.init(title: GLBWaveSpinnerView.glb_className(), value:GLBWaveSpinnerView.self),
            GLBListFieldItem.init(title: GLBWordPressSpinnerView.glb_className(), value:GLBWordPressSpinnerView.self),
        ]
        self.spinnerView = GLBArcSpinnerView.init()
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
                self.spinnerView = spinnerViewClass.init()
            } else {
                self.spinnerView = nil
            }
        } else {
            self.spinnerView = nil
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
