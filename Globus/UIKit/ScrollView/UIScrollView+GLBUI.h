/*--------------------------------------------------*/

#import "UIResponder+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@protocol GLBScrollViewExtension < NSObject >

@required
- (void)saveInputState;
- (void)showInputIntersectionRect:(CGRect)intersectionRect;
- (void)restoreInputState;

@end

/*--------------------------------------------------*/

@interface UIScrollView (GLB_UI)

@property(nonatomic) IBInspectable UIEdgeInsets glb_keyboardInset;

@property(nonatomic) CGFloat glb_contentOffsetX;
@property(nonatomic) CGFloat glb_contentOffsetY;
@property(nonatomic) CGFloat glb_contentSizeWidth;
@property(nonatomic) CGFloat glb_contentSizeHeight;
@property(nonatomic) CGFloat glb_contentInsetTop;
@property(nonatomic) CGFloat glb_contentInsetRight;
@property(nonatomic) CGFloat glb_contentInsetBottom;
@property(nonatomic) CGFloat glb_contentInsetLeft;
@property(nonatomic) CGFloat glb_scrollIndicatorInsetTop;
@property(nonatomic) CGFloat glb_scrollIndicatorInsetRight;
@property(nonatomic) CGFloat glb_scrollIndicatorInsetBottom;
@property(nonatomic) CGFloat glb_scrollIndicatorInsetLeft;
@property(nonatomic, readonly) CGRect glb_visibleBounds;

- (void)glb_setContentOffsetX:(CGFloat)glb_contentOffsetX animated:(BOOL)animated;
- (void)glb_setContentOffsetY:(CGFloat)glb_contentOffsetY animated:(BOOL)animated;

- (void)glb_registerAdjustmentResponder;
- (void)glb_unregisterAdjustmentResponder;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
