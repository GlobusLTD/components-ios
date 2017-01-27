//
//  Globus
//

import Globus

class ListDataViewController: GLBDataViewController {
    
    // MARK: - Property
    
    public var dataViewContainer: GLBDataViewItemsListContainer?
    
    // MARK: - Init / Free
    
    override func setup() {
        super.setup()
        
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0);
        self.title = "ListDataView"
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.glb_removeAllLeftBarButtonItems(animated: false)
        self.navigationItem.glb_addLeftBarButtonNormalImage(UIImage.init(named: "MenuButton"), target: self, action: #selector(pressedMenu(_ :)), animated: false)
    }
    
    // MARK: - GLBViewController
    
    override func update() {
        super.update()
        
        self.dataView?.batchUpdate({
            for index in 0...1000 {
                self.dataViewContainer?.appendIdentifier(Const.ListCellIdentifier, byData: ListDataViewModel.init(title: "Item #\(index)"))
            }
        })
    }
    
    override func clear() {
        self.dataView?.batchUpdate({
            self.dataViewContainer?.deleteAllItems()
        })
        
        super.clear()
    }
    
    // MARK: - GLBDataViewController
    
    override func prepareDataView() {
        self.dataViewContainer = GLBDataViewItemsListContainer.init(orientation: .vertical)
        
        self.dataView?.registerIdentifier(Const.ListCellIdentifier, withViewClass: ListDataViewCell.self)
        
        self.dataView?.container = self.dataViewContainer;
    }
    
    override func cleanupDataView() {
        self.dataView?.container = nil;
        self.dataView?.unregisterAllIdentifiers()
        self.dataView?.unregisterAllActions()
        self.dataViewContainer = nil;
    }
    
    // MARK: - Actions
    
    @IBAction internal func pressedMenu(_ sender: Any) {
        self.glb_slideViewController?.showLeftViewController(animated: true, complete: nil)
    }
    
    // MARK: - Const
    
    struct Const {
        static let ListCellIdentifier = "List"
    }
    
}
