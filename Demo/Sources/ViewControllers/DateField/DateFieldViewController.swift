//
//  Globus
//

import Globus

class DateFieldViewController: GLBViewController, GLBSlideViewControllerDelegate {
    
    // MARK - Outlet property
    
    @IBOutlet fileprivate weak var dateField: GLBDateField!
    
    // MARK - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textStyle = GLBTextStyle()
        textStyle.font = UIFont.boldSystemFont(ofSize: 16)
        textStyle.color = UIColor.darkGray
        self.dateField.textStyle = textStyle
        
        let placeholderStyle = GLBTextStyle()
        placeholderStyle.font = UIFont.boldSystemFont(ofSize: 16)
        placeholderStyle.color = UIColor.lightGray
        self.dateField.placeholderStyle = placeholderStyle
        
        self.dateField.placeholder = "Placeholder"
        self.dateField.datePickerMode = .date
        self.dateField.dateFormatter = DateFormatter.glb_dateFormatter(withFormat: "DD-MM-yyyy")
        self.dateField.date = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.dateField.becomeFirstResponder()
    }
    
    // MARK - Action
    
    @IBAction internal func pressedMenu(_ sender: Any) {
        self.glb_slideViewController?.showLeftViewController(animated: true, complete: nil)
    }
    
    @IBAction internal func changedDate(_ sender: Any) {
        print("ChangedDate: \(self.dateField.date)")
    }
    
    // MARK: - GLBNibExtension
    
    public override static func nibName() -> String {
        return "DateFieldViewController-Swift"
    }
    
}
