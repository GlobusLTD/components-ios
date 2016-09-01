/*--------------------------------------------------*/

#import "GLBDataViewSwipeCell.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

typedef GLBDataViewSwipeCellStyle GLBDataCellSwipeStyle;

/*--------------------------------------------------*/

#define GLBDataSwipeCellStyleStands                 GLBDataViewSwipeCellStyleStands
#define GLBDataSwipeCellStyleLeaves                 GLBDataViewSwipeCellStyleLeaves
#define GLBDataSwipeCellStylePushes                 GLBDataViewSwipeCellStylePushes
#define GLBDataSwipeCellStyleStretch                GLBDataViewSwipeCellStyleStretch

/*--------------------------------------------------*/

GLB_DEPRECATED
@interface GLBDataCellSwipe : GLBDataViewSwipeCell
@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
