//
//  Globus
//

import Globus

class ImageViewController: GLBViewController {
    
    // MARK - Constant
    
    struct Const {
        
        static let DefaultImageUrl = "http://globus-ltd.ru/images/testing.jpg"
        
    }
    
    // MARK - Outlet property
    
    @IBOutlet weak var imageView: GLBImageView!
    @IBOutlet weak var urlField: GLBTextView!
    
    // MARK - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.imageUrl = URL.init(string: Const.DefaultImageUrl)
        self.urlField.text = Const.DefaultImageUrl;
    }
    
    //MARK: - GLBNibExtension
    
    public override static func nibName() -> String {
        return "ImageViewController-Swift"
    }
    
}

//MARK: - UITextViewDelegate

extension ImageViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.imageView.imageUrl = URL.init(string: textView.text)
    }

}
