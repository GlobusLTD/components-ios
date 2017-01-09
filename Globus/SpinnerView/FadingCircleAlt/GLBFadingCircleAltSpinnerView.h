/*--------------------------------------------------*/

#import "GLBSpinnerView.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBFadingCircleAltSpinnerView : GLBSpinnerView

@property(nonatomic) IBInspectable NSUInteger numberOfCircle;
@property(nonatomic) IBInspectable CGFloat factorCircle;
@property(nonatomic) IBInspectable CGFloat factorRadius;
@property(nonatomic) IBInspectable CGFloat minScale;
@property(nonatomic) IBInspectable CGFloat minOpacity;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
