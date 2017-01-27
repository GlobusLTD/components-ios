//
//  Globus
//

import Globus

class CalendarMonthDataViewCell: GLBDataViewCell {
    
    // MARK: - Outlet property
    
    @IBOutlet fileprivate weak var displayLabel: UILabel!
    
    // MARK: - Public func

    public override func setup() {
        super.setup();
        
        self.displayLabel.textColor = UIColor.darkGray
    }
    
    public override func willShow() {
        if let item = self.item as? GLBDataViewCalendarMonthItem {
            let dateFormatter = DateFormatter.glb_dateFormatter(withFormat: "MMMM")
            self.displayLabel.text = dateFormatter.string(from: item.beginDate)
        }
    }
    
    // MARK: - GLBNibExtension
    
    public override class func nibName() -> String {
        return "CalendarMonthDataViewCell-Swift"
    }
    
}
