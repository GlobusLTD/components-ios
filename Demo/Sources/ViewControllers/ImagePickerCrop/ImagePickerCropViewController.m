//
//  Globus
//

#import "ImagePickerCropViewController.h"

@interface ImagePickerCropViewController ()

@property(nonatomic, weak) IBOutlet UIImageView* pickedImageView;
@property(nonatomic, weak) IBOutlet UIImageView* croppedImageView;

@end

@implementation ImagePickerCropViewController

#pragma mark - Actions

- (IBAction)pressedMenu:(id)sender {
    [self.glb_slideViewController showLeftViewControllerAnimated:YES complete:nil];
}

- (IBAction)pressedChoice:(id)sender {
    __weak typeof(self) weakSelf = self;
    GLBImagePickerController* imagePicker = [GLBImagePickerController imagePickerControllerWithViewController:self];
    [imagePicker presentAnimated:YES completion:^(UIImage* image) {
        if(image != nil) {
            weakSelf.pickedImageView.image = image;
            weakSelf.croppedImageView.image = nil;
            
            [GLBTimeout executeBlock:^{
                GLBImageCropViewController* cropViewController = [[GLBImageCropViewController alloc] initWithImage:image];
                cropViewController.choiceBlock = ^(GLBImageCropViewController* cropViewController, UIImage* croppedImage) {
                    weakSelf.croppedImageView.image = croppedImage;
                    [cropViewController dismissViewControllerAnimated:YES completion:nil];
                };
                cropViewController.cancelBlock = ^(GLBImageCropViewController* cropViewController) {
                    [cropViewController dismissViewControllerAnimated:YES completion:nil];
                };
                [self presentViewController:cropViewController animated:YES completion:nil];
            } afterDelay:0.5f];
        } else {
            weakSelf.pickedImageView.image = nil;
            weakSelf.croppedImageView.image = nil;
        }
    }];
}

@end
