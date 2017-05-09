/*--------------------------------------------------*/

#import "GLBBaseDataViewController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

typedef NS_ENUM(NSUInteger, GLBDataViewControllerState) {
    GLBDataViewControllerStateNone,
    GLBDataViewControllerStateContent,
    GLBDataViewControllerStatePreload,
    GLBDataViewControllerStateEmpty,
    GLBDataViewControllerStateError
};

/*--------------------------------------------------*/

@protocol GLBDataViewControllerRootContainerProtocol;
@protocol GLBDataViewControllerContentContainerProtocol;
@protocol GLBDataViewControllerPreloadContainerProtocol;
@protocol GLBDataViewControllerEmptyContainerProtocol;
@protocol GLBDataViewControllerErrorContainerProtocol;

/*--------------------------------------------------*/

@interface GLBDataViewController : GLBBaseDataViewController

@property(nonatomic, readonly) GLBDataViewControllerState state;
@property(nonatomic, readonly, nullable, strong) __kindof GLBDataViewContainer< GLBDataViewControllerRootContainerProtocol >* rootContainer;
@property(nonatomic, readonly, nullable, strong) __kindof GLBDataViewContainer< GLBDataViewControllerContentContainerProtocol >* contentContainer;
@property(nonatomic, readonly, nullable, strong) __kindof GLBDataViewContainer< GLBDataViewControllerPreloadContainerProtocol >* preloadContainer;
@property(nonatomic, readonly, nullable, strong) __kindof GLBDataViewContainer< GLBDataViewControllerEmptyContainerProtocol >* emptyContainer;
@property(nonatomic, readonly, nullable, strong) __kindof GLBDataViewContainer< GLBDataViewControllerErrorContainerProtocol >* errorContainer;

+ (nonnull NSBundle*)defaultNibBundle;

- (nullable __kindof GLBDataViewContainer< GLBDataViewControllerRootContainerProtocol >*)prepareRootContainer;
- (nullable __kindof GLBDataViewContainer< GLBDataViewControllerContentContainerProtocol >*)prepareContentContainer;
- (nullable __kindof GLBDataViewContainer< GLBDataViewControllerPreloadContainerProtocol >*)preparePreloadContainer;
- (nullable __kindof GLBDataViewContainer< GLBDataViewControllerEmptyContainerProtocol >*)prepareEmptyContainer;
- (nullable __kindof GLBDataViewContainer< GLBDataViewControllerErrorContainerProtocol >*)prepareErrorContainerWithError:(nullable id)error;

- (void)showPreloadContainer;
- (void)showContentContainer:(nonnull GLBSimpleBlock)update;
- (void)showEmptyContainer;
- (void)showErrorContainer:(nonnull id)error;

@end

/*--------------------------------------------------*/

@protocol GLBDataViewControllerContainerProtocol < NSObject >

@property(nonatomic, nullable, weak) GLBDataViewController* viewController;

@end

/*--------------------------------------------------*/

@protocol GLBDataViewControllerRootContainerProtocol < GLBDataViewControllerContainerProtocol >

@property(nonatomic, readonly, nullable, strong) GLBDataViewContainer< GLBDataViewControllerContainerProtocol >* currentContainer;

- (void)showContentContainer:(nullable GLBDataViewContainer< GLBDataViewControllerContentContainerProtocol >*)container;
- (void)showPreloadContainer:(nullable GLBDataViewContainer< GLBDataViewControllerPreloadContainerProtocol >*)container;
- (void)showEmptyContainer:(nullable GLBDataViewContainer< GLBDataViewControllerEmptyContainerProtocol >*)container;
- (void)showErrorContainer:(nullable GLBDataViewContainer< GLBDataViewControllerErrorContainerProtocol >*)container;
- (void)hideCurrentContainer;

@end

/*--------------------------------------------------*/

@protocol GLBDataViewControllerContentContainerProtocol < GLBDataViewControllerContainerProtocol >
@end

/*--------------------------------------------------*/

@protocol GLBDataViewControllerPreloadContainerProtocol < GLBDataViewControllerContainerProtocol >
@end

/*--------------------------------------------------*/

@protocol GLBDataViewControllerEmptyContainerProtocol < GLBDataViewControllerContainerProtocol >
@end

/*--------------------------------------------------*/

@protocol GLBDataViewControllerErrorContainerProtocol < GLBDataViewControllerContainerProtocol >

@property(nonatomic, readonly, nullable, strong) id error;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
