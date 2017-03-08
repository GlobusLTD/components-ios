/*--------------------------------------------------*/

#import "GLBSpinnerView.h"
#import "GLBLabel.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBActivityView : UIView

@property(nonatomic) UIEdgeInsets margin;
@property(nonatomic) CGFloat spacing;
@property(nonatomic) CGSize panelMaximumSize;

@property(nonatomic, nullable, strong) UIView* panelView;
@property(nonatomic, nullable, strong) GLBSpinnerView* spinnerView;
@property(nonatomic, nullable, strong) GLBLabel* textLabel;

@property(nonatomic, readonly, getter=isShowed) BOOL showed;

@property(nonatomic) NSTimeInterval showDuration;
@property(nonatomic) NSTimeInterval showDelay;
@property(nonatomic) NSTimeInterval hideDuration;
@property(nonatomic) NSTimeInterval hideDelay;

- (void)setup NS_REQUIRES_SUPER;

- (nullable UIView*)preparePanelView;
- (nullable GLBSpinnerView*)prepareSpinnerView;
- (nullable GLBLabel*)prepareTextLabel;

- (void)show;
- (void)showComplete:(nullable GLBSimpleBlock)complete;
- (void)showPrepare:(nullable GLBSimpleBlock)prepare complete:(nullable GLBSimpleBlock)complete;

- (void)hide;
- (void)hideComplete:(nullable GLBSimpleBlock)complete;
- (void)hidePrepare:(nullable GLBSimpleBlock)prepare complete:(nullable GLBSimpleBlock)complete;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
