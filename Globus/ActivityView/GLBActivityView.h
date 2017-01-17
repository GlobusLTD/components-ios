/*--------------------------------------------------*/

#import "GLBSpinnerView.h"

/*--------------------------------------------------*/

#import "UIView+GLBUI.h"
#import "UILabel+GLBUI.h"

/*--------------------------------------------------*/

#include "GLBRect.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBSpinnerView;

/*--------------------------------------------------*/

@interface GLBActivityView : UIView

@property(nonatomic) CGFloat margin;
@property(nonatomic) CGFloat spacing;

@property(nonatomic, nullable, strong) UIColor* panelColor;
@property(nonatomic) CGFloat panelCornerRadius;

@property(nonatomic, nullable, readonly, strong) GLBSpinnerView* spinnerView;
@property(nonatomic, nullable, strong) UIColor* spinnerColor;
@property(nonatomic) CGFloat spinnerSize;

@property(nonatomic, nullable, strong) UIColor* textColor;
@property(nonatomic, nullable, strong) UIFont* textFont;
@property(nonatomic, readonly, assign) CGFloat textWidth;
@property(nonatomic, nullable, strong) NSString* text;

@property(nonatomic, readonly, assign, getter=isShowed) BOOL showed;

@property(nonatomic) NSTimeInterval showDuration;
@property(nonatomic) NSTimeInterval showDelay;
@property(nonatomic) NSTimeInterval hideDuration;
@property(nonatomic) NSTimeInterval hideDelay;

+ (instancetype _Nonnull)activityViewWithSpinnerView:(GLBSpinnerView* _Nonnull)spinnerView NS_SWIFT_UNAVAILABLE("Use init(spinnerView:)");
+ (instancetype _Nonnull)activityViewWithSpinnerView:(GLBSpinnerView* _Nonnull)spinnerView text:(NSString* _Nullable)text NS_SWIFT_UNAVAILABLE("Use init(spinnerView:text:)");
+ (instancetype _Nonnull)activityViewWithSpinnerView:(GLBSpinnerView* _Nonnull)spinnerView text:(NSString* _Nullable)text textWidth:(NSUInteger)textWidth NS_SWIFT_UNAVAILABLE("Use init(spinnerView:text:textWidth:)");

- (instancetype _Nonnull)initWithSpinnerView:(GLBSpinnerView* _Nonnull)spinnerView;
- (instancetype _Nonnull)initWithSpinnerView:(GLBSpinnerView* _Nonnull)spinnerView text:(NSString* _Nullable)text;
- (instancetype _Nonnull)initWithSpinnerView:(GLBSpinnerView* _Nonnull)spinnerView text:(NSString* _Nullable)text textWidth:(NSUInteger)textWidth NS_DESIGNATED_INITIALIZER;
- (instancetype _Nonnull)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
- (instancetype _Nullable)initWithCoder:(NSCoder* _Nullable)coder NS_DESIGNATED_INITIALIZER;

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
