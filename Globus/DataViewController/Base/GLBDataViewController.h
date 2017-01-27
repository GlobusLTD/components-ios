/*--------------------------------------------------*/

#import "GLBViewController.h"

/*--------------------------------------------------*/

#import "GLBDataView.h"
#import "GLBDataViewContainer.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewController : GLBViewController

@property(nonatomic, nullable, readwrite, strong) IBOutlet GLBDataView* dataView;
@property(nonatomic, nullable, readwrite, strong) IBOutlet NSLayoutConstraint* constraintDataViewTop;
@property(nonatomic, nullable, readwrite, strong) IBOutlet NSLayoutConstraint* constraintDataViewLeft;
@property(nonatomic, nullable, readwrite, strong) IBOutlet NSLayoutConstraint* constraintDataViewRight;
@property(nonatomic, nullable, readwrite, strong) IBOutlet NSLayoutConstraint* constraintDataViewBottom;

+ (BOOL)useNibForInstantiate NS_SWIFT_NAME(useNibForInstantiate());

- (void)prepareDataView;
- (void)cleanupDataView;

- (void)updateConstraintsDataView;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
