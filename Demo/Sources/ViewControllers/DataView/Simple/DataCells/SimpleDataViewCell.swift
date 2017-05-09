//
//  Globus
//

import Globus

class SimpleDataViewCell: GLBDataViewCell {
    
    // MARK: - Outlet property
    
    @IBOutlet fileprivate weak var avatarView: GLBImageView!
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    
    // MARK: - Public func

    public override func setup() {
        super.setup();
        
        self.nameLabel.textColor = UIColor.darkGray
    }
    
    public override func willShow() {
        if let viewModel = self.item!.data as? SimpleDataProviderModel {
            if let url = viewModel.url {
                self.avatarView.imageUrl = url
            }
            self.nameLabel.text = "\(viewModel.firstName) \(viewModel.lastName)"
        }
    }
    
    // MARK: - GLBNibExtension
    
    public override class func nibName() -> String {
        return "SimpleDataViewCell-Swift"
    }
    
}
