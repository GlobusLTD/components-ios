/*--------------------------------------------------*/

#include "GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

typedef void(^GLBImagePickerControllerCompletionBlock)(UIImage* _Nullable image);

/*--------------------------------------------------*/

@interface GLBImagePickerController : NSObject

@property(nonatomic, readonly) UIImagePickerControllerSourceType sourceType;
@property(nonatomic) BOOL allowsEditing;
@property(nonatomic) CGSize maximumSize;

+ (nonnull instancetype)imagePickerControllerWithViewController:(nonnull UIViewController*)viewController NS_SWIFT_UNAVAILABLE("Use init(viewController:)");

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithViewController:(nonnull UIViewController*)viewController NS_DESIGNATED_INITIALIZER;

- (void)presentAnimated:(BOOL)animated completion:(nonnull GLBImagePickerControllerCompletionBlock)completion;
- (void)dismissAnimated:(BOOL)animated;

@end

/*--------------------------------------------------*/

@interface UIViewController (GLBImagePickerController)

@property(nonatomic, nullable, strong) GLBImagePickerController* glb_imagePickerController;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
