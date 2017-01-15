//
//  Globus
//

import Globus

class PhoneFieldViewController: GLBViewController {
    
    // MARK - Outlet property
    
    @IBOutlet fileprivate weak var phoneField: GLBPhoneField!
    @IBOutlet fileprivate weak var regionLabel: UILabel!
    @IBOutlet fileprivate weak var phoneNumberLabel: UILabel!
    @IBOutlet fileprivate weak var phoneNumberWithoutPrefixLabel: UILabel!
    
    // MARK - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textStyle = GLBTextStyle.init()
        textStyle.font = UIFont.boldSystemFont(ofSize: 16)
        textStyle.color = UIColor.darkGray
        self.phoneField.textStyle = textStyle
        
        self.phoneField.prefix = "+"
        self.phoneField.setDefaultOutputPattern("############")
        self.phoneField.addOutputPattern("# (###) ###-##-##", forRegExp: "^7\\d{10}$", userInfo: "RU")
        self.phoneField.addOutputPattern("## (####) ##-##-##", forRegExp: "^44\\d{10}$", userInfo: "UK")
        
        self.changedPhone(self.phoneField)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.phoneField.becomeFirstResponder()
    }
    
    // MARK - Action
    
    @IBAction internal func pressedMenu(_ sender: Any) {
        self.glb_slideViewController?.showLeftViewController(animated: true, complete: nil)
    }
    
    @IBAction internal func changedPhone(_ sender: Any) {
        if let region = self.phoneField.userInfo as? String {
            self.regionLabel.text = region
        } else {
            self.regionLabel.text = "NONE"
        }
        self.phoneNumberLabel.text = self.phoneField.phoneNumber()
        self.phoneNumberWithoutPrefixLabel.text = self.phoneField.phoneNumberWithoutPrefix()
    }
    
    // MARK: - GLBNibExtension
    
    public override static func nibName() -> String {
        return "PhoneFieldViewController-Swift"
    }
    
}
