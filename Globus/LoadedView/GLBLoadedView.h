/*--------------------------------------------------*/

#import "UIView+GLBUI.h"
#import "UINib+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBLoadedView : UIView < GLBNibExtension >

@property(nonatomic, nullable, strong) IBOutlet UIView* rootView;
@property(nonatomic) UIEdgeInsets rootEdgeInsets;
@property(nonatomic) CGFloat rootEdgeInsetsTop;
@property(nonatomic) CGFloat rootEdgeInsetsBottom;
@property(nonatomic) CGFloat rootEdgeInsetsLeft;
@property(nonatomic) CGFloat rootEdgeInsetsRight;

+ (instancetype _Nullable)instantiate NS_SWIFT_NAME(instantiate());
+ (instancetype _Nullable)instantiateWithOptions:(NSDictionary* _Nullable)options NS_SWIFT_NAME(instantiate(options:));

- (void)setup NS_REQUIRES_SUPER;

- (void)load NS_REQUIRES_SUPER;
- (void)unload NS_REQUIRES_SUPER;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
