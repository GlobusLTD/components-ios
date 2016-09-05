/*--------------------------------------------------*/

#import "GLBDataViewItemsListContainer.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

typedef GLBDataViewItemsListContainerMode GLBDataContainerItemsListMode;

/*--------------------------------------------------*/

#define GLBDataContainerItemsListModeBegin          GLBDataViewItemsListContainerModeBegin
#define GLBDataContainerItemsListModeCenter         GLBDataViewItemsListContainerModeCenter
#define GLBDataContainerItemsListModeEnd            GLBDataViewItemsListContainerModeEnd

/*--------------------------------------------------*/

GLB_DEPRECATED
@interface GLBDataContainerItemsList : GLBDataViewItemsListContainer
@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
