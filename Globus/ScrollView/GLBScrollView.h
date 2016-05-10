/*--------------------------------------------------*/

#import "UIScrollView+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

typedef NS_ENUM(NSInteger, GLBScrollViewDirection) {
    GLBScrollViewDirectionStretch,
    GLBScrollViewDirectionHorizontal,
    GLBScrollViewDirectionVertical
};

/*--------------------------------------------------*/

@interface GLBScrollView : UIScrollView

@property(nonatomic) IBInspectable GLBScrollViewDirection direction;
@property(nonatomic, strong) IBOutlet UIView* rootView;

- (void)setup NS_REQUIRES_SUPER;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
