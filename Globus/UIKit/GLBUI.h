/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import <UIKit/UIKit.h>

/*--------------------------------------------------*/

typedef NS_OPTIONS(NSUInteger, GLBUIVerticalAlignment) {
    GLBUIVerticalAlignmentTop,
    GLBUIVerticalAlignmentCenter,
    GLBUIVerticalAlignmentBottom
};

typedef NS_OPTIONS(NSUInteger, GLBUIHorizontalAlignment) {
    GLBUIHorizontalAlignmentLeft,
    GLBUIHorizontalAlignmentCenter,
    GLBUIHorizontalAlignmentRight
};

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/

typedef void(^GLBSimpleBlock)();

/*--------------------------------------------------*/
