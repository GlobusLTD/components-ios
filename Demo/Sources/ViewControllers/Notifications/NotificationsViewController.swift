//
//  Globus
//

import Globus

class NotificationsViewController: GLBViewController {
    
    // MARK - Outlet property
    
    @IBOutlet fileprivate weak var segmentedControl: UISegmentedControl!
    @IBOutlet fileprivate weak var useTopDecorView: UISwitch!
    @IBOutlet fileprivate weak var useBottomDecorView: UISwitch!
    @IBOutlet fileprivate weak var textField: GLBTextField!
    
    // MARK - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GLBNotificationManager.setStatusBarStyle(.lightContent)
        
        self.segmentedControl.removeAllSegments()
        self.segmentedControl.insertSegment(withTitle: "List", at: self.segmentedControl.numberOfSegments, animated: false)
        self.segmentedControl.insertSegment(withTitle: "Stack", at: self.segmentedControl.numberOfSegments, animated: false)
        switch GLBNotificationManager.displayType() {
        case .list:
            self.segmentedControl.selectedSegmentIndex = 0
            break
        case .stack:
            self.segmentedControl.selectedSegmentIndex = 1
            break
        }
        
        self.useTopDecorView.isOn = (GLBNotificationManager.topDecorView() != nil)
        self.useBottomDecorView.isOn = (GLBNotificationManager.bottomDecorView() != nil)
        
        self.textField.text = "Сообщение";
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.textField.becomeFirstResponder()
    }
    
    // MARK - Action
    
    @IBAction internal func pressedMenu(_ sender: Any) {
        self.glb_slideViewController?.showLeftViewController(animated: true, complete: nil)
    }
    
    @IBAction internal func changeDisplayType(_ sender: Any) {
        switch self.segmentedControl.selectedSegmentIndex {
        case 0:
            GLBNotificationManager.setDisplayType(.list)
            break
        case 1:
            GLBNotificationManager.setDisplayType(.stack)
            break
        default:
            break
        }
    }
    
    @IBAction internal func changeTopDecorView(_ sender: Any) {
        if self.useTopDecorView.isOn {
            GLBNotificationManager.setTopDecorView(NotificationTopDecorView())
        } else {
            GLBNotificationManager.setTopDecorView(nil)
        }
    }
    
    @IBAction internal func changeBottomDecorView(_ sender: Any) {
        if self.useBottomDecorView.isOn {
            GLBNotificationManager.setBottomDecorView(NotificationBottomDecorView())
        } else {
            GLBNotificationManager.setBottomDecorView(nil)
        }
    }
    
    @IBAction internal func pressedShow(_ sender: Any) {
        let view = NotificationView()
        view.title = self.textField.text!
        GLBNotificationManager.show(view)
    }
    
    // MARK: - GLBNibExtension
    
    public override static func nibName() -> String {
        return "NotificationsViewController-Swift"
    }
    
}
