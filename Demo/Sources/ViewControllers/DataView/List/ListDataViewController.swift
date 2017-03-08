//
//  Globus
//

import Globus

class ListDataViewController: GLBListDataViewController {
    
    // MARK: - Init / Free
    
    override func setup() {
        super.setup()
        
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0);
        self.title = "ListDataView"
        
        self.provider = ListDataProvider();
        self.spinnerView = GLBArcSpinnerView();
        self.spinnerView!.color = UIColor.blue;
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.glb_removeAllLeftBarButtonItems(animated: false)
        self.navigationItem.glb_addLeftBarButtonNormalImage(UIImage.init(named: "MenuButton"), target: self, action: #selector(pressedMenu(_ :)), animated: false)
    }
    
    // MARK: - GLBDataViewController
    
    override func configureDataView() {
        super.configureDataView()
        
        self.registerIdentifier(Const.ListCellIdentifier, withViewClass: ListDataViewCell.self)
    }
    
    // MARK: - GLBListDataViewController
    
    override func prepareRootContainer() -> GLBDataViewSectionsContainer? {
        return GLBDataViewSectionsListContainer.init(orientation: .vertical)
    }
    
    override func prepareContentContainer() -> GLBDataViewSectionsContainer? {
        return GLBDataViewSectionsListContainer.init(orientation: .vertical)
    }
    
    override func preparePreloadContainer() -> GLBDataViewContainer? {
        return nil
    }
    
    override func prepareEmptyContainer() -> GLBDataViewContainer? {
        return nil
    }
    
    override func prepareErrorContainerWithError(_ error: Any?) -> GLBDataViewContainer? {
        return nil
    }
    
    override func prepareSectionContainer(with model: GLBListDataProviderModel) -> GLBDataViewContainer? {
        return GLBDataViewItemsListContainer.init(orientation: .vertical)
    }
    
    override func prepareItem(withModel model: Any) -> GLBDataViewItem? {
        return GLBDataViewItem.init(identifier: Const.ListCellIdentifier, order: 0, data: model)
    }
    
    override func sectionContainer(_ sectionContainer: GLBDataViewContainer, append item: GLBDataViewItem) {
        if let itemsListContainer = sectionContainer as? GLBDataViewItemsListContainer {
            itemsListContainer.appendItem(item)
        }
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
