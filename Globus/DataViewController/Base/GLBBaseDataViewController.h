/*--------------------------------------------------*/

#import "GLBViewController.h"

/*--------------------------------------------------*/

#import "GLBDataView.h"
#import "GLBDataRefreshView.h"
#import "GLBDataViewContainer.h"
#import "GLBDataViewItem.h"

#import "GLBSearchBar.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBSpinnerView;

/*--------------------------------------------------*/

@interface GLBBaseDataViewController : GLBViewController< UIScrollViewDelegate >

@property(nonatomic, nullable, strong) UIView* topView;
@property(nonatomic, nullable, strong) UIView* leftView;
@property(nonatomic, nullable, strong) UIView* rightView;
@property(nonatomic, nullable, strong) UIView* bottomView;
@property(nonatomic, nullable, strong) UIView* contentView;
@property(nonatomic, nonnull, readonly, strong) GLBDataView* dataView;
@property(nonatomic, nullable, strong) GLBSpinnerView* spinnerView;

- (void)configureDataView;
- (void)cleanupDataView NS_REQUIRES_SUPER;

- (void)registerIdentifier:(nonnull NSString*)identifier withViewClass:(nonnull Class)viewClass;
- (void)unregisterIdentifier:(nonnull NSString*)identifier;
- (void)unregisterAllIdentifiers;

- (void)registerAction:(nonnull SEL)action forKey:(nonnull id)key;
- (void)registerAction:(nonnull SEL)action forIdentifier:(nonnull id)identifier forKey:(nonnull id)key;
- (void)unregisterActionForKey:(nonnull id)key;
- (void)unregisterActionForIdentifier:(nonnull id)identifier forKey:(nonnull id)key;
- (void)unregisterAllActions;

- (BOOL)containsActionForKey:(nonnull id)key;
- (BOOL)containsActionForIdentifier:(nonnull id)identifier forKey:(nonnull id)key;

- (void)performActionForKey:(nonnull id)key withArguments:(nullable NSArray*)arguments;
- (void)performActionForIdentifier:(nonnull id)identifier forKey:(nonnull id)key withArguments:(nullable NSArray*)arguments;

- (BOOL)isLoading;
- (void)showLoading;
- (void)hideLoading;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
