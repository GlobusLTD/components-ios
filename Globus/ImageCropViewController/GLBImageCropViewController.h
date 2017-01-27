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

@class GLBImageCropContentView;

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

@property(nonatomic, nonnull, readonly, strong) GLBImageCropContentView* contentView;
@property(nonatomic, nonnull, readonly, strong) GLBLabel* titleLabel;
@property(nonatomic, nonnull, readonly, strong) GLBButton* cancelButton;
@property(nonatomic, nonnull, readonly, strong) GLBButton* choiceButton;

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithImage:(nonnull UIImage*)image;
- (nonnull instancetype)initWithImage:(nonnull UIImage*)image cropMode:(GLBImageCropMode)cropMode;

- (nonnull GLBImageCropContentView*)defaultContentView;

@end

/*--------------------------------------------------*/

@interface GLBImageCropContentView : UIView

@property(nonatomic, nullable, weak) GLBImageCropViewController* viewController;
@property(nonatomic, assign) UIEdgeInsets edgeInsets;
@property(nonatomic, nonnull, strong) GLBLabel* titleLabel;
@property(nonatomic, nonnull, strong) GLBButton* cancelButton;
@property(nonatomic, nonnull, strong) GLBButton* choiceButton;

- (void)setup NS_REQUIRES_SUPER;

- (nonnull GLBLabel*)defaultTitleLabel;
- (nonnull GLBButton*)defaultCancelButton;
- (nonnull GLBButton*)defaultChoiceButton;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
