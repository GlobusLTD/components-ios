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
    
    // MARK: - GLBViewController
    
    override func prepareNavigationLeftBarButtons() -> [UIBarButtonItem] {
        return [
            UIBarButtonItem(image: UIImage(named: "MenuButton"), style: .plain, target: self, action: #selector(pressedMenu(_ :)))
        ]
    }
    
    // MARK: - GLBListDataViewController
    
    override func prepareContentContainer() -> GLBDataViewContainer? {
        return ListDataViewControllerContentContainer()
    }
    
    // MARK: - Actions
    
    @IBAction internal func pressedMenu(_ sender: Any) {
        self.glb_slideViewController?.showLeftViewController(animated: true, complete: nil)
    }
    
}

class ListDataViewControllerContentContainer: GLBListDataViewControllerContentContainer {
    
    // MARK: - GLBListDataViewControllerContentContainer
    
    override class func mapCells() -> [String: AnyClass] {
        return [
            Const.ListCellIdentifier: ListDataViewCell.self
        ]
    }
    
    override func prepareItem(withModel model: Any) -> GLBDataViewItem?{
        return GLBDataViewItem.init(identifier: Const.ListCellIdentifier, order: 0, data: model)
    }
    
    // MARK: - Const
    
    struct Const {
        static let ListCellIdentifier = "List"
    }
    
}
