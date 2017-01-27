//
//  Globus
//

import Globus

class CalendarDayDataViewCell: GLBDataViewCell {
    
    // MARK: - Outlet property
    
    @IBOutlet fileprivate weak var displayLabel: UILabel!
    
    // MARK: - Public func

    public override func setup() {
        super.setup();
        
        self.displayLabel.textColor = UIColor.darkGray
    }
    
    public override func willShow() {
        if let item = self.item as? GLBDataViewCalendarDayItem {
            let dateFormatter = DateFormatter.glb_dateFormatter(withFormat: "dd")
            self.displayLabel.text = dateFormatter.string(from: item.date)
        }
    }
    
    // MARK: - GLBNibExtension
    
    public override class func nibName() -> String {
        return "CalendarDayDataViewCell-Swift"
    }
    
}
