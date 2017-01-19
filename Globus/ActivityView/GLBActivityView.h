/*--------------------------------------------------*/

#import "GLBSpinnerView.h"
#import "GLBLabel.h"

/*--------------------------------------------------*/

#import "UIView+GLBUI.h"
#import "UILabel+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBActivityView : UIView

@property(nonatomic) UIEdgeInsets margin;
@property(nonatomic) CGFloat spacing;
@property(nonatomic, assign) CGSize panelMaximumSize;

@property(nonatomic, nullable, strong) UIView* panelView;
@property(nonatomic, nullable, strong) GLBSpinnerView* spinnerView;
@property(nonatomic, nullable, strong) GLBLabel* textLabel;

@property(nonatomic, readonly, assign, getter=isShowed) BOOL showed;

@property(nonatomic) NSTimeInterval showDuration;
@property(nonatomic) NSTimeInterval showDelay;
@property(nonatomic) NSTimeInterval hideDuration;
@property(nonatomic) NSTimeInterval hideDelay;

- (void)setup NS_REQUIRES_SUPER;

- (void)show;
- (void)showComplete:(GLBSimpleBlock _Nullable)complete;
- (void)showPrepare:(GLBSimpleBlock _Nullable)prepare complete:(GLBSimpleBlock _Nullable)complete;

- (void)hide;
- (void)hideComplete:(GLBSimpleBlock _Nullable)complete;
- (void)hidePrepare:(GLBSimpleBlock _Nullable)prepare complete:(GLBSimpleBlock _Nullable)complete;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
