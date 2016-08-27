/*--------------------------------------------------*/

#import "UIView+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBSpinnerView;

/*--------------------------------------------------*/

@interface GLBActivityView : UIView

@property(nonatomic) CGFloat margin;
@property(nonatomic) CGFloat spacing;

@property(nonatomic, strong) UIColor* panelColor;
@property(nonatomic) CGFloat panelCornerRadius;

@property(nonatomic, strong) GLBSpinnerView* spinner;
@property(nonatomic, strong) UIColor* spinnerColor;
@property(nonatomic) CGFloat spinnerSize;

@property(nonatomic, strong) UIColor* textColor;
@property(nonatomic, strong) UIFont* textFont;
@property(nonatomic, readonly, assign) CGFloat textWidth;
@property(nonatomic, strong) NSString* text;

@property(nonatomic, readonly, assign, getter=isShowed) BOOL showed;

@property(nonatomic) NSTimeInterval showDuration;
@property(nonatomic) NSTimeInterval showDelay;
@property(nonatomic) NSTimeInterval hideDuration;
@property(nonatomic) NSTimeInterval hideDelay;

+ (instancetype)activityViewWithSpinnerView:(GLBSpinnerView*)spinnerView;
+ (instancetype)activityViewWithSpinnerView:(GLBSpinnerView*)spinnerView text:(NSString*)text;
+ (instancetype)activityViewWithSpinnerView:(GLBSpinnerView*)spinnerView text:(NSString*)text textWidth:(NSUInteger)textWidth;

- (instancetype)initWithSpinnerView:(GLBSpinnerView*)spinnerView text:(NSString*)text textWidth:(NSUInteger)textWidth;

- (void)setup NS_REQUIRES_SUPER;

- (void)show;
- (void)showComplete:(GLBSimpleBlock)complete;
- (void)showPrepare:(GLBSimpleBlock)prepare complete:(GLBSimpleBlock)complete;

- (void)hide;
- (void)hideComplete:(GLBSimpleBlock)complete;
- (void)hidePrepare:(GLBSimpleBlock)prepare complete:(GLBSimpleBlock)complete;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
