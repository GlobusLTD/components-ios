/*--------------------------------------------------*/

#import "NSArray+GLBNS.h"

/*--------------------------------------------------*/

#import "GLBObserver.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

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

@protocol GLBAudioSessionObserver < GLBObserverProtocol >

@optional
- (void)audioSessionBeginInterruption;
- (void)audioSessionEndInterruptionWithFlags:(AVAudioSessionInterruptionOptions)flags;

@optional
- (void)audioSessionChangeDeviceVolume:(CGFloat)volume;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
