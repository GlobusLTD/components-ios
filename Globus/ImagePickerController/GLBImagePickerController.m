/*--------------------------------------------------*/

#import "GLBImagePickerController.h"

/*--------------------------------------------------*/

#import "UIImage+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBImagePickerController () < UINavigationControllerDelegate, UIImagePickerControllerDelegate >

@property(nonatomic, readonly, strong) UIViewController* ownerViewController;
@property(nonatomic, strong) UIImagePickerController* pickerViewController;

@property(nonatomic, readonly, copy) GLBImagePickerControllerCompletionBlock completion;
@property(nonatomic, readonly, strong) UIImage* image;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBImagePickerController

#pragma mark - Not designated initializer

GLB_IMPLEMENTATION_NOT_DESIGNATED_INITIALIZER(init)

#pragma mark - Init / Free

+ (instancetype)imagePickerControllerWithViewController:(UIViewController*)viewController {
    return [[self alloc] initWithViewController:viewController];
}


- (nonnull instancetype)initWithViewController:(UIViewController*)viewController {
    self = [super init];
    if(self != nil) {
        _ownerViewController = viewController;
        _sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    return self;
}

#pragma mark - Public

- (void)presentAnimated:(BOOL)animated completion:(GLBImagePickerControllerCompletionBlock)completion {
    if(_pickerViewController == nil) {
        _ownerViewController.glb_imagePickerController = self;
        
        _pickerViewController = [UIImagePickerController new];
        _pickerViewController.sourceType = _sourceType;
        _pickerViewController.allowsEditing = _allowsEditing;
        _pickerViewController.delegate = self;
        
        _completion = [completion copy];
        
        [_ownerViewController presentViewController:_pickerViewController animated:animated completion:nil];
    }
}

- (void)dismissAnimated:(BOOL)animated {
    if(_completion != nil) {
        _completion(_image);
        _completion = nil;
    }
    __weak typeof(self) weakSelf = self;
    [_pickerViewController dismissViewControllerAnimated:animated completion:^{
        weakSelf.ownerViewController.glb_imagePickerController = nil;
        weakSelf.pickerViewController = nil;
    }];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary< NSString*, id >*)info {
    _image = info[UIImagePickerControllerEditedImage];
    if(_image == nil) {
        _image = info[UIImagePickerControllerOriginalImage];
    }
    if(_image != nil) {
        _image = [_image glb_unrotate];
    }
    if((_image != nil) && (_maximumSize.width > GLB_EPSILON) && (_maximumSize.height > GLB_EPSILON)) {
        CGSize imageSize = _image.size;
        if((imageSize.width > _maximumSize.width) || (imageSize.height > _maximumSize.height)) {
            _image = [_image glb_scaleToSize:_maximumSize];
        }
    }
    [self dismissAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController*)picker {
    [self dismissAnimated:YES];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation UIViewController (GLBImagePickerController)

- (void)setGlb_imagePickerController:(GLBImagePickerController*)imagePickerController {
    objc_setAssociatedObject(self, @selector(glb_imagePickerController), imagePickerController, OBJC_ASSOCIATION_RETAIN);
}

- (GLBImagePickerController*)glb_imagePickerController {
    GLBImagePickerController* controller = objc_getAssociatedObject(self, @selector(glb_imagePickerController));
    if(controller == nil) {
        controller = self.parentViewController.glb_imagePickerController;
    }
    return controller;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
