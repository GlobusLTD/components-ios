/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import <AVFoundation/AVFoundation.h>

/*--------------------------------------------------*/

typedef void (^GLBAudioSessionActivateBlock)(NSError* error);
typedef void (^GLBAudioSessionPermissionBlock)();

/*--------------------------------------------------*/

@interface GLBAudioSession : NSObject

+ (void)activateWithOptions:(AVAudioSessionSetActiveOptions)activeOptions
                   category:(NSString*)category
            categoryOptions:(AVAudioSessionCategoryOptions)categoryOptions
                       mode:(NSString*)mode
                      block:(GLBAudioSessionActivateBlock)block;

+ (void)recordPermission:(GLBAudioSessionPermissionBlock)block;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
