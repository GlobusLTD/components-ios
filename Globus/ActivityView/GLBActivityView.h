/*--------------------------------------------------*/

#import "UIView+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

typedef NS_ENUM(NSUInteger, GLBActivityViewStyle) {
    GLBActivityViewStyleNone,
    GLBActivityViewStylePlane,
    GLBActivityViewStyleCircleFlip,
    GLBActivityViewStyleBounce,
    GLBActivityViewStyleWave,
    GLBActivityViewStyleWanderingCubes,
    GLBActivityViewStylePulse,
    GLBActivityViewStyleChasingDots,
    GLBActivityViewStyleThreeBounce,
    GLBActivityViewStyleCircle,
    GLBActivityViewStyle9CubeGrid,
    GLBActivityViewStyleWordPress,
    GLBActivityViewStyleFadingCircle,
    GLBActivityViewStyleFadingCircleAlt,
    GLBActivityViewStyleArc,
    GLBActivityViewStyleArcAlt
};

/*--------------------------------------------------*/

@interface GLBActivityView : UIView

@property(nonatomic, readonly, assign) GLBActivityViewStyle style;
@property(nonatomic) CGFloat margin;
@property(nonatomic) CGFloat spacing;
@property(nonatomic, strong) UIColor* panelColor;
@property(nonatomic) CGFloat panelCornerRadius;
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

+ (instancetype)activityViewWithStyle:(GLBActivityViewStyle)style;
+ (instancetype)activityViewWithStyle:(GLBActivityViewStyle)style text:(NSString*)text;
+ (instancetype)activityViewWithStyle:(GLBActivityViewStyle)style text:(NSString*)text textWidth:(NSUInteger)textWidth;

- (instancetype)initWithStyle:(GLBActivityViewStyle)style text:(NSString*)text textWidth:(NSUInteger)textWidth;

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
