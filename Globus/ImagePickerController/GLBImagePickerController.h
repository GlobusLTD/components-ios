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

+ (instancetype _Nonnull)imagePickerControllerWithViewController:(UIViewController* _Nonnull)viewController NS_SWIFT_UNAVAILABLE("Use init(viewController:)");

- (instancetype _Nonnull)init NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithViewController:(UIViewController* _Nonnull)viewController NS_DESIGNATED_INITIALIZER;

- (void)presentAnimated:(BOOL)animated completion:(GLBImagePickerControllerCompletionBlock _Nonnull)completion;
- (void)dismissAnimated:(BOOL)animated;

@end

/*--------------------------------------------------*/

@interface UIViewController (GLBImagePickerController)

@property(nonatomic, nullable, strong) GLBImagePickerController* glb_imagePickerController;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
