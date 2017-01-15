//
//  Globus
//

import Globus

class ChoiseCellTableViewCell: UITableViewCell, GLBNibExtension {
    
    // MARK: - Outlet property
    
    @IBOutlet fileprivate weak var displayLabel: UILabel!
    
    // MARK: - Public func

    public override class func glb_reuseIdentifier() -> String {
        return "ChoiseCellTableViewCell"
    }
    
    public func configure(viewModel: ChoiseViewModel) {
        self.displayLabel.text = viewModel.title;
        self.displayLabel.textColor = UIColor.darkGray
    }
    
    // MARK: - GLBNibExtension
    
    public static func nibName() -> String {
        return "ChoiseCellTableViewCell-Swift"
    }
    
    public static func nibBundle() -> Bundle {
        return Bundle.main
    }
    
}
