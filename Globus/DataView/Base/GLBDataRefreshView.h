/*--------------------------------------------------*/

#import "GLBDataViewTypes.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBDataView;

/*--------------------------------------------------*/

typedef NS_ENUM(NSUInteger, GLBDataRefreshViewType) {
    GLBDataRefreshViewTypeTop,
    GLBDataRefreshViewTypeBottom,
    GLBDataRefreshViewTypeLeft,
    GLBDataRefreshViewTypeRight
};

/*--------------------------------------------------*/

typedef NS_ENUM(NSUInteger, GLBDataRefreshViewState) {
    GLBDataRefreshViewStateIdle,
    GLBDataRefreshViewStatePull,
    GLBDataRefreshViewStateRelease,
    GLBDataRefreshViewStateLoading
};

/*--------------------------------------------------*/

@interface GLBDataRefreshView : UIView

@property(nonatomic) GLBDataRefreshViewType type;
@property(nonatomic, nullable, readonly, weak) __kindof GLBDataView* view;
@property(nonatomic, nullable, readonly, weak) NSLayoutConstraint* constraintOffset;
@property(nonatomic, nullable, readonly, weak) NSLayoutConstraint* constraintSize;
@property(nonatomic, readonly, assign) GLBDataRefreshViewState state;
@property(nonatomic) IBInspectable BOOL triggeredOnRelease;
@property(nonatomic) IBInspectable CGFloat size;
@property(nonatomic) IBInspectable CGFloat threshold;

- (void)setup NS_REQUIRES_SUPER;

- (void)showAnimated:(BOOL)animated complete:(nullable GLBSimpleBlock)complete;
- (void)hideAnimated:(BOOL)animated complete:(nullable GLBSimpleBlock)complete;

- (void)showAnimated:(BOOL)animated velocity:(CGFloat)velocity complete:(nullable GLBSimpleBlock)complete;
- (void)hideAnimated:(BOOL)animated velocity:(CGFloat)velocity complete:(nullable GLBSimpleBlock)complete;

- (void)didProgress:(CGFloat)progress;
- (void)didIdle;
- (void)didPull;
- (void)didRelease;
- (void)didLoading;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
