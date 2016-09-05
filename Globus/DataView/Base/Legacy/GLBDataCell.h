/*--------------------------------------------------*/

#import "GLBDataViewCell.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

GLB_DEPRECATED
@interface GLBDataCell : GLBDataViewCell
@end

/*--------------------------------------------------*/

#define GLBDataCellPressed GLBDataViewCellPressed
#define GLBDataCellLongPressed GLBDataViewCellLongPressed

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/

#if __has_include("GLBDataCellSwipe.h")
#import "GLBDataCellSwipe.h"
#endif

/*--------------------------------------------------*/
