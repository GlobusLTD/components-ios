/*--------------------------------------------------*/

#import "UIView+GLBUI.h"
#import "UIImage+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

typedef void(^GLBBlurViewUpdateBlock)();

/*--------------------------------------------------*/

@interface GLBBlurView : UIView

@property(nonatomic, getter = isBlurEnabled) IBInspectable BOOL blurEnabled;
@property(nonatomic) IBInspectable CGFloat blurRadius;
@property(nonatomic) IBInspectable NSUInteger blurIterations;
@property(nonatomic, getter = isDynamic) IBInspectable BOOL dynamic;
@property(nonatomic) IBInspectable NSTimeInterval updateInterval;
@property(nonatomic, nullable, weak) IBOutlet UIView* underlyingView;

+ (void)setBlurEnabled:(BOOL)blurEnabled;
+ (void)setUpdatesEnabled;
+ (void)setUpdatesDisabled;

- (void)setup NS_REQUIRES_SUPER;

- (void)updateAsynchronously:(BOOL)async completion:(GLBBlurViewUpdateBlock _Nullable)completion;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
