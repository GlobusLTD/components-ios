/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/
#pragma mark - Forward declarations
/*--------------------------------------------------*/

@protocol GLBDataControllerDelegate;

/*--------------------------------------------------*/
#pragma mark - Public interface
/*--------------------------------------------------*/

@interface GLBDataController : NSObject

#pragma mark - Public properties

@property(nonatomic, weak) id< GLBDataControllerDelegate > delegate;
@property(nonatomic, readonly, assign, getter=isUpdating) BOOL updating;
@property(nonatomic, readonly, strong) NSError* error;

#pragma mark - Public constructors

+ (instancetype)dataController;
+ (instancetype)dataControllerWithDelegate:(id< GLBDataControllerDelegate >)delegate;

- (instancetype)initWithDelegate:(id< GLBDataControllerDelegate >)delegate;

#pragma mark - Public instance methods

- (void)setup NS_REQUIRES_SUPER;

- (void)load;
- (void)reload;
- (void)cancel;

@end

/*--------------------------------------------------*/
#pragma mark - Delegate protocol
/*--------------------------------------------------*/

@protocol GLBDataControllerDelegate < NSObject >

@required
- (void)startUpdatingInDataController:(GLBDataController*)dataController;
- (void)finishUpdatingInDataController:(GLBDataController*)dataController;

@end

/*--------------------------------------------------*/


