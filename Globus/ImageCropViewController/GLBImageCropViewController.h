/*--------------------------------------------------*/

#import "GLBViewController.h"
#import "GLBButton.h"
#import "GLBLabel.h"

/*--------------------------------------------------*/

#import "GLBAction.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBImageCropViewController;

/*--------------------------------------------------*/

typedef void(^GLBImageCropViewControllerChoiceBlock)(GLBImageCropViewController* _Nonnull viewController, UIImage* _Nullable image);
typedef void(^GLBImageCropViewControllerBlock)(GLBImageCropViewController* _Nonnull viewController);

/*--------------------------------------------------*/

typedef NS_ENUM(NSUInteger, GLBImageCropMode) {
    GLBImageCropModeCircle,
    GLBImageCropModeSquare
};

/*--------------------------------------------------*/

@interface GLBImageCropViewController : GLBViewController

@property(nonatomic, nonnull, readwrite, strong) UIImage* image;
@property(nonatomic, nullable, readwrite, strong) UIColor* maskColor;
@property(nonatomic, nullable, readonly, strong) UIBezierPath* maskPath;
@property(nonatomic, readonly) CGRect maskRect;

@property(nonatomic, readonly) GLBImageCropMode cropMode;
@property(nonatomic, readonly) CGRect cropRect;
@property(nonatomic, readonly) CGFloat scale;

@property(nonatomic, readwrite) BOOL avoidEmptySpaceAroundImage;

@property(nonatomic, nullable, readwrite, copy) GLBImageCropViewControllerChoiceBlock choiceBlock;
@property(nonatomic, nullable, readwrite, copy) GLBImageCropViewControllerBlock cancelBlock;

@property(nonatomic, nonnull, readonly, strong) GLBLabel* titleLabel;
@property(nonatomic, nonnull, readonly, strong) GLBButton* choiceButton;
@property(nonatomic, nonnull, readonly, strong) GLBButton* cancelButton;

- (instancetype _Nonnull)init NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithImage:(UIImage* _Nonnull)image;
- (instancetype _Nonnull)initWithImage:(UIImage* _Nonnull)image cropMode:(GLBImageCropMode)cropMode;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
