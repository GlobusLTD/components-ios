//
//  Globus
//

import Globus

class ImagePickerCropViewController: GLBViewController {
    
    // MARK - Outlet property
    
    @IBOutlet fileprivate weak var pickedImageView: UIImageView!
    @IBOutlet fileprivate weak var croppedImageView: UIImageView!
    
    // MARK - Action
    
    @IBAction internal func pressedMenu(_ sender: Any) {
        self.glb_slideViewController?.showLeftViewController(animated: true, complete: nil)
    }
    
    @IBAction internal func pressedChoice(_ sender: Any) {
        let imagePicker = GLBImagePickerController.init(viewController: self)
        imagePicker.present(animated: true) { [unowned self] (image: UIImage?) in
            if (image != nil) {
                self.pickedImageView.image = image
                self.croppedImageView.image = nil
                
                GLBTimeout.execute({ [unowned self] in ()
                    let cropViewController = GLBImageCropViewController.init(image: image!, cropMode: .circle)
                    cropViewController.choiceBlock = { [unowned self] (cropViewController: GLBImageCropViewController, croppedImage: UIImage?) in ()
                        self.croppedImageView.image = croppedImage
                        cropViewController.dismiss(animated: true, completion: nil)
                    }
                    cropViewController.cancelBlock = { (cropViewController: GLBImageCropViewController) in ()
                        cropViewController.dismiss(animated: true, completion: nil)
                    }
                    self.present(cropViewController, animated: true, completion: nil)
                }, afterDelay: 0.5)
            } else {
                self.pickedImageView.image = nil
                self.croppedImageView.image = nil
            }
        }
    }
    
    // MARK: - GLBNibExtension
    
    public override static func nibName() -> String {
        return "ImagePickerCropViewController-Swift"
    }
    
}
