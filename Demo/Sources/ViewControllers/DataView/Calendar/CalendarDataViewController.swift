//
//  Globus
//

import Globus

class CalendarDataViewController: GLBDataViewController {
    
    // MARK: - Property
    
    public var dataViewContainer: GLBDataViewCalendarContainer?
    
    // MARK: - Init / Free
    
    override func setup() {
        super.setup()
        
        self.edgesForExtendedLayout = UIRectEdge(rawValue: 0);
        self.title = "CalendarDataView"
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.glb_removeAllLeftBarButtonItems(animated: false)
        self.navigationItem.glb_addLeftBarButtonNormalImage(UIImage(named: "MenuButton"), target: self, action: #selector(pressedMenu(_ :)), animated: false)
    }
    
    // MARK: - GLBViewController
    
    override func update() {
        super.update()
        
        self.dataView?.batchUpdate({
            let now = NSDate()
            self.dataViewContainer?.prepareBegin(now.glb_beginningOfMonth()!, end: now.glb_endOfMonth()!)
        })
    }
    
    override func clear() {
        self.dataView?.batchUpdate({
            self.dataViewContainer?.cleanup()
        })
        
        super.clear()
    }
    
    // MARK: - GLBDataViewController
    
    override func configureDataView() {
        self.dataViewContainer = GLBDataViewCalendarContainer(calendar: Calendar.current)
        
        self.dataView?.registerIdentifier(GLBDataViewCalendarMonthIdentifier, withViewClass: CalendarMonthDataViewCell.self)
        self.dataView?.registerIdentifier(GLBDataViewCalendarWeekdayIdentifier, withViewClass: CalendarWeekdayDataViewCell.self)
        self.dataView?.registerIdentifier(GLBDataViewCalendarDayIdentifier, withViewClass: CalendarDayDataViewCell.self)
        
        self.dataView?.container = self.dataViewContainer;
    }
    
    override func cleanupDataView() {
        super.cleanupDataView();
        
        self.dataViewContainer = nil;
    }
    
    // MARK: - Actions
    
    @IBAction internal func pressedMenu(_ sender: Any) {
        self.glb_slideViewController?.showLeftViewController(animated: true, complete: nil)
    }
    
}
