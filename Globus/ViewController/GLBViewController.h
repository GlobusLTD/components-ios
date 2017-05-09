/*--------------------------------------------------*/

#import "UINib+GLBUI.h"

/*--------------------------------------------------*/

#import "GLBBaseViewController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBActivityView;

/*--------------------------------------------------*/

@interface GLBViewController : GLBBaseViewController < GLBNibExtension >

@property(nonatomic) UIInterfaceOrientationMask supportedOrientationMask;

@property(nonatomic, nullable, strong) GLBActivityView* activityView;

+ (nullable instancetype)instantiate NS_SWIFT_NAME(instantiate());
+ (nullable instancetype)instantiateWithOptions:(nullable NSDictionary*)options NS_SWIFT_NAME(instantiate(options:));

- (void)setNeedUpdateNavigationItem;
- (void)updateNavigationItem;
- (nonnull NSArray< __kindof UIBarButtonItem* >*)prepareNavigationLeftBarButtons;
- (nonnull NSArray< __kindof UIBarButtonItem* >*)prepareNavigationRightBarButtons;

- (void)setNeedUpdateToolbarItems;
- (void)updateToolbarItems;
- (nonnull NSArray< __kindof UIBarButtonItem* >*)prepareToolbarItems;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
