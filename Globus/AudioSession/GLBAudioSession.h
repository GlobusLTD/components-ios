/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import <AVFoundation/AVFoundation.h>

/*--------------------------------------------------*/

@protocol GLBAudioSessionObserver;

/*--------------------------------------------------*/

typedef void (^GLBAudioSessionActivateBlock)(NSError* error);
typedef void (^GLBAudioSessionPermissionBlock)();

/*--------------------------------------------------*/

@interface GLBAudioSession : NSObject

@property(nonatomic) CGFloat volume;

+ (instancetype)shared;

- (void)addObserver:(id< GLBAudioSessionObserver >)observer;
- (void)removeObserver:(id< GLBAudioSessionObserver >)observer;

+ (void)activateWithOptions:(AVAudioSessionSetActiveOptions)activeOptions
                   category:(NSString*)category
            categoryOptions:(AVAudioSessionCategoryOptions)categoryOptions
                       mode:(NSString*)mode
                      block:(GLBAudioSessionActivateBlock)block;

+ (void)recordPermission:(GLBAudioSessionPermissionBlock)block;

@end

/*--------------------------------------------------*/

@protocol GLBAudioSessionObserver < NSObject >

@optional
- (void)audioSessionChangeDeviceVolume:(CGFloat)volume;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
