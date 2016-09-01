/*--------------------------------------------------*/

#import "NSDictionary+GLBNS.h"
#import "NSArray+GLBNS.h"

/*--------------------------------------------------*/

#import "UIGestureRecognizer+GLBUI.h"
#import "UINib+GLBUI.h"
#import "UIDevice+GLBUI.h"

/*--------------------------------------------------*/

#import "GLBAction.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

typedef NS_OPTIONS(NSUInteger, GLBDataViewPosition) {
    GLBDataViewPositionNone = 0,
    GLBDataViewPositionTop = 1 << 0,
    GLBDataViewPositionCenteredVertically = 1 << 1,
    GLBDataViewPositionBottom = 1 << 2,
    GLBDataViewPositionLeft = 1 << 3,
    GLBDataViewPositionCenteredHorizontally = 1 << 4,
    GLBDataViewPositionRight = 1 << 5,
    GLBDataViewPositionCentered = GLBDataViewPositionCenteredVertically | GLBDataViewPositionCenteredHorizontally,
    GLBDataViewPositionInsideVertically = (GLBDataViewPositionTop | GLBDataViewPositionCenteredVertically | GLBDataViewPositionBottom),
    GLBDataViewPositionInsideHorizontally = (GLBDataViewPositionLeft | GLBDataViewPositionCenteredHorizontally | GLBDataViewPositionRight),
    GLBDataViewPositionInside = GLBDataViewPositionInsideVertically | GLBDataViewPositionInsideHorizontally,
};

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
