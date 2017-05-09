//
//  Globus
//

import Globus

class SpinnerViewController: GLBViewController {
    
    // MARK - Outlet property
    
    @IBOutlet fileprivate weak var listField: GLBListField!
    @IBOutlet fileprivate weak var wrapSpinnerView: UIView!
    private var spinnerView: GLBSpinnerView? {
        willSet {
            if let spinnerView = self.spinnerView {
                spinnerView.stopAnimating()
                spinnerView.removeFromSuperview()
            }
        }
        didSet {
            if let spinnerView = self.spinnerView {
                spinnerView.translatesAutoresizingMaskIntoConstraints = false
                spinnerView.startAnimating()
                self.wrapSpinnerView.addSubview(spinnerView)
                spinnerView.glb_addConstraintCenter();
            }
        }
    }
    
    // MARK - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textStyle = GLBTextStyle()
        textStyle.font = UIFont.boldSystemFont(ofSize: 16)
        textStyle.color = UIColor.darkGray
        self.listField.textStyle = textStyle
        
        let placeholderStyle = GLBTextStyle()
        placeholderStyle.font = UIFont.boldSystemFont(ofSize: 16)
        placeholderStyle.color = UIColor.lightGray
        self.listField.placeholderStyle = placeholderStyle
        
        self.listField.placeholder = "Please select spinner style"
        self.listField.items = [
            GLBListFieldItem(title: "None", value:nil),
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
        self.listField.selectedItem = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.listField.becomeFirstResponder()
    }
    
    // MARK - Action
    
    @IBAction internal func pressedMenu(_ sender: Any) {
        self.glb_slideViewController?.showLeftViewController(animated: true, complete: nil)
    }
    
    @IBAction internal func changedSelectedItem(_ sender: Any) {
        if let selected = self.listField.selectedItem {
            if let spinnerViewClass = selected.value as? GLBSpinnerView.Type {
                self.spinnerView = spinnerViewClass.init();
            } else {
                self.spinnerView = nil
            }
        } else {
            self.spinnerView = nil
        }
    }
    
    // MARK: - GLBNibExtension
    
    public override static func nibName() -> String {
        return "SpinnerViewController-Swift"
    }
    
}
