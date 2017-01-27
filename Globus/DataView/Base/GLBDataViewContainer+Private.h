/*--------------------------------------------------*/

#import "GLBDataViewContainer.h"
#import "GLBDataViewItem+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewContainer () {
@protected
    __weak GLBDataView* _dataView;
    __weak GLBDataViewContainer* _container;
    BOOL _hidden;
    BOOL _allowAutoAlign;
    UIEdgeInsets _alignInsets;
    GLBDataViewContainerAlign _alignPosition;
    UIOffset _alignThreshold;
    CGRect _frame;
}

@property(nonatomic, nullable, weak) __kindof GLBDataView* dataView;
@property(nonatomic, nullable, weak) __kindof GLBDataViewContainer* container;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
