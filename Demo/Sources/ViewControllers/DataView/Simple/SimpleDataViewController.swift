//
//  Globus
//

import Globus

class SimpleDataViewController: GLBSimpleDataViewController {
    
    // MARK: - Init / Free
    
    override func setup() {
        super.setup()
        
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0);
        self.title = "SimpleDataView"
        
        self.provider = SimpleDataProvider();
        self.spinnerView = GLBArcSpinnerView();
        self.spinnerView!.color = UIColor.blue;
    }
    
    // MARK: - GLBViewController
    
    override func prepareNavigationLeftBarButtons() -> [UIBarButtonItem] {
        return [
            UIBarButtonItem(image: UIImage(named: "MenuButton"), style: .plain, target: self, action: #selector(pressedMenu(_ :)))
        ]
    }
    
    // MARK: - GLBSimpleDataViewController
    
    override func prepareContentContainer() -> GLBDataViewContainer? {
        return SimpleDataViewControllerContentContainer()
    }
    
    // MARK: - Actions
    
    @IBAction internal func pressedMenu(_ sender: Any) {
        self.glb_slideViewController?.showLeftViewController(animated: true, complete: nil)
    }
    
}

class SimpleDataViewControllerContentContainer: GLBSimpleDataViewControllerContentContainer {
    
    // MARK: - GLBSimpleDataViewControllerContentContainer
    
    override class func mapCells() -> [String: AnyClass] {
        return [
            Const.SimpleCellIdentifier: SimpleDataViewCell.self
        ]
    }
    
    override func prepare(withModel model: Any) {
        self.appendIdentifier(Const.SimpleCellIdentifier, byData: model)
    }
    
    override func cleanup(withModel model: Any) {
        self.deleteAllItems()
    }
    
    // MARK: - Const
    
    struct Const {
        static let SimpleCellIdentifier = "Simple"
    }
    
}
