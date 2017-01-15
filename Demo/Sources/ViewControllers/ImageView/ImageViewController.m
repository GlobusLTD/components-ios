//
//  Globus
//

#import "ImageViewController.h"

@interface ImageViewController () < UITextViewDelegate >

@property(nonatomic, weak) IBOutlet GLBImageView* imageView;
@property(nonatomic, weak) IBOutlet GLBTextView* urlField;

@end

@implementation ImageViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageView.imageUrl = [NSURL URLWithString:DefaultImageUrl];
    _urlField.text = DefaultImageUrl;
}

#pragma mark - Actions

- (IBAction)pressedMenu:(id)sender {
    [self.glb_slideViewController showLeftViewControllerAnimated:YES complete:nil];
}

#pragma mark - UITextViewDelegate

- (void)textViewDidEndEditing:(UITextView*)textView {
    _imageView.imageUrl = [NSURL URLWithString:textView.text];
}

@end

NSString* DefaultImageUrl = @"http://globus-ltd.ru/images/testing.jpg";
