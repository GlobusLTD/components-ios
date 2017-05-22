/*--------------------------------------------------*/

#import "GLBViewController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@protocol GLBBaseTableViewControllerDataSource;
@class GLBSpinnerView;

/*--------------------------------------------------*/

@interface GLBBaseTableViewController : GLBViewController< UIScrollViewDelegate >

@property(nonatomic, nullable, strong) UIView* topView;
@property(nonatomic, nullable, strong) UIView* leftView;
@property(nonatomic, nullable, strong) UIView* rightView;
@property(nonatomic, nullable, strong) UIView* bottomView;
@property(nonatomic, nullable, strong) UIView* contentView;
@property(nonatomic, nonnull, readonly, strong) UITableView* tableView;
@property(nonatomic, nullable, strong) GLBSpinnerView* spinnerView;

@property(nonatomic, nullable, strong) id< GLBBaseTableViewControllerDataSource > dataSource;

- (void)configureTableView;
- (void)cleanupTableView NS_REQUIRES_SUPER;

- (void)registerIdentifier:(nonnull NSString*)identifier withCellClass:(nonnull Class)cellClass;
- (void)registerIdentifier:(nonnull NSString*)identifier withCellNib:(nonnull UINib*)cellNib;

- (void)registerIdentifier:(nonnull NSString*)identifier withHeaderClass:(nonnull Class)cellClass;
- (void)registerIdentifier:(nonnull NSString*)identifier withHeaderNib:(nonnull UINib*)cellNib;

- (void)registerIdentifier:(nonnull NSString*)identifier withFooterClass:(nonnull Class)cellClass;
- (void)registerIdentifier:(nonnull NSString*)identifier withFooterNib:(nonnull UINib*)cellNib;

- (BOOL)isLoading;
- (void)showLoading;
- (void)hideLoading;

@end

/*--------------------------------------------------*/

@protocol GLBBaseTableViewControllerDataSource < UITableViewDataSource, UITableViewDelegate >

@property(nonatomic, nullable, weak) __kindof GLBBaseTableViewController* viewController;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
