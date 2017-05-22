/*--------------------------------------------------*/

#import "GLBBaseTableViewController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

typedef NS_ENUM(NSUInteger, GLBTableViewControllerState) {
    GLBTableViewControllerStateNone,
    GLBTableViewControllerStateContent,
    GLBTableViewControllerStatePreload,
    GLBTableViewControllerStateEmpty,
    GLBTableViewControllerStateError
};

/*--------------------------------------------------*/

@protocol GLBTableViewControllerRootContainerProtocol;
@protocol GLBTableViewControllerContentContainerProtocol;
@protocol GLBTableViewControllerPreloadContainerProtocol;
@protocol GLBTableViewControllerEmptyContainerProtocol;
@protocol GLBTableViewControllerErrorContainerProtocol;

/*--------------------------------------------------*/

@interface GLBTableViewController : GLBBaseTableViewController

@property(nonatomic, readonly) GLBTableViewControllerState state;
@property(nonatomic, readonly, nullable, strong) __kindof GLBTableViewContainer< GLBTableViewControllerRootContainerProtocol >* rootContainer;
@property(nonatomic, readonly, nullable, strong) __kindof GLBTableViewContainer< GLBTableViewControllerContentContainerProtocol >* contentContainer;
@property(nonatomic, readonly, nullable, strong) __kindof GLBTableViewContainer< GLBTableViewControllerPreloadContainerProtocol >* preloadContainer;
@property(nonatomic, readonly, nullable, strong) __kindof GLBTableViewContainer< GLBTableViewControllerEmptyContainerProtocol >* emptyContainer;
@property(nonatomic, readonly, nullable, strong) __kindof GLBTableViewContainer< GLBTableViewControllerErrorContainerProtocol >* errorContainer;

+ (nonnull NSBundle*)defaultNibBundle;

- (nullable __kindof GLBTableViewContainer< GLBTableViewControllerRootContainerProtocol >*)prepareRootContainer;
- (nullable __kindof GLBTableViewContainer< GLBTableViewControllerContentContainerProtocol >*)prepareContentContainer;
- (nullable __kindof GLBTableViewContainer< GLBTableViewControllerPreloadContainerProtocol >*)preparePreloadContainer;
- (nullable __kindof GLBTableViewContainer< GLBTableViewControllerEmptyContainerProtocol >*)prepareEmptyContainer;
- (nullable __kindof GLBTableViewContainer< GLBTableViewControllerErrorContainerProtocol >*)prepareErrorContainerWithError:(nullable id)error;

- (void)showPreloadContainer;
- (void)showContentContainer:(nonnull GLBSimpleBlock)update;
- (void)showEmptyContainer;
- (void)showErrorContainer:(nonnull id)error;

@end

/*--------------------------------------------------*/

@protocol GLBTableViewControllerContainerProtocol < NSObject >

@property(nonatomic, nullable, weak) GLBTableViewController* viewController;

@end

/*--------------------------------------------------*/

@protocol GLBTableViewControllerRootContainerProtocol < GLBTableViewControllerContainerProtocol >

@property(nonatomic, readonly, nullable, strong) GLBTableViewContainer< GLBTableViewControllerContainerProtocol >* currentContainer;

- (void)showContentContainer:(nullable GLBTableViewContainer< GLBTableViewControllerContentContainerProtocol >*)container;
- (void)showPreloadContainer:(nullable GLBTableViewContainer< GLBTableViewControllerPreloadContainerProtocol >*)container;
- (void)showEmptyContainer:(nullable GLBTableViewContainer< GLBTableViewControllerEmptyContainerProtocol >*)container;
- (void)showErrorContainer:(nullable GLBTableViewContainer< GLBTableViewControllerErrorContainerProtocol >*)container;
- (void)hideCurrentContainer;

@end

/*--------------------------------------------------*/

@protocol GLBTableViewControllerContentContainerProtocol < GLBTableViewControllerContainerProtocol >
@end

/*--------------------------------------------------*/

@protocol GLBTableViewControllerPreloadContainerProtocol < GLBTableViewControllerContainerProtocol >
@end

/*--------------------------------------------------*/

@protocol GLBTableViewControllerEmptyContainerProtocol < GLBTableViewControllerContainerProtocol >
@end

/*--------------------------------------------------*/

@protocol GLBTableViewControllerErrorContainerProtocol < GLBTableViewControllerContainerProtocol >

@property(nonatomic, readonly, nullable, strong) id error;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
