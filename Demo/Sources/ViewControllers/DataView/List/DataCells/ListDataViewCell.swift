//
//  Globus
//

import Globus

class ListDataViewCell: GLBDataViewCell {
    
    // MARK: - Outlet property
    
    @IBOutlet fileprivate weak var displayLabel: UILabel!
    
    // MARK: - Public func

    public override func setup() {
        super.setup();
        
        self.displayLabel.textColor = UIColor.darkGray
    }
    
    public override func size(forAvailableSize size: CGSize) -> CGSize {
        return CGSize.init(width: size.width, height: 88.0)
    }
    
    public override func willShow() {
        if let viewModel = self.item!.data as? ListDataViewModel {
            self.displayLabel.text = viewModel.title;
        }
    }
    
    // MARK: - GLBNibExtension
    
    public override class func nibName() -> String {
        return "ListDataViewCell-Swift"
    }
    
}
