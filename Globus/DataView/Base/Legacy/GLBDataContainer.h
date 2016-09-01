/*--------------------------------------------------*/

#import "GLBDataViewContainer.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

typedef GLBDataViewContainerOrientation GLBDataContainerOrientation;

/*--------------------------------------------------*/

#define GLBDataContainerOrientationVertical         GLBDataViewContainerOrientationVertical
#define GLBDataContainerOrientationHorizontal       GLBDataViewContainerOrientationHorizontal

/*--------------------------------------------------*/

typedef GLBDataViewContainerAlign GLBDataContainerAlign;

/*--------------------------------------------------*/

#define GLBDataContainerAlignNone                   GLBDataViewContainerAlignNone
#define GLBDataContainerAlignTop                    GLBDataViewContainerAlignTop
#define GLBDataContainerAlignCenteredVertically     GLBDataViewContainerAlignCenteredVertically
#define GLBDataContainerAlignBottom                 GLBDataViewContainerAlignBottom
#define GLBDataContainerAlignLeft                   GLBDataViewContainerAlignLeft
#define GLBDataContainerAlignCenteredHorizontally   GLBDataViewContainerAlignCenteredHorizontally
#define GLBDataContainerAlignRight                  GLBDataViewContainerAlignRight
#define GLBDataContainerAlignCentered               GLBDataViewContainerAlignCentered

/*--------------------------------------------------*/

typedef void(^GLBDataViewContainerConfigureItemBlock)(__kindof GLBDataViewItem* item);

GLB_DEPRECATED
@interface GLBDataContainer : GLBDataViewContainer
@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/

#if __has_include("GLBDataContainerSections.h")
#import "GLBDataContainerSections.h"
#endif

#if __has_include("GLBDataContainerItems.h")
#import "GLBDataContainerItems.h"
#endif

#if __has_include("GLBDataContainerSectionsList.h")
#import "GLBDataContainerSectionsList.h"
#endif

#if __has_include("GLBDataContainerItemsList.h")
#import "GLBDataContainerItemsList.h"
#endif

#if __has_include("GLBDataContainerItemsFlow.h")
#import "GLBDataContainerItemsFlow.h"
#endif

/*--------------------------------------------------*/
