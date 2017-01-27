/*--------------------------------------------------*/

#import "NSArray+GLBNS.h"
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

typedef void (^GLBAudioSessionActivateBlock)(NSError* _Nullable error);
typedef void (^GLBAudioSessionPermissionBlock)();

/*--------------------------------------------------*/

@interface GLBAudioSession : NSObject

@property(nonatomic) CGFloat volume;

+ (nullable instancetype)shared;

- (void)addObserver:(nonnull id< GLBAudioSessionObserver >)observer;
- (void)removeObserver:(nonnull id< GLBAudioSessionObserver >)observer;

+ (void)activateWithOptions:(AVAudioSessionSetActiveOptions)activeOptions
                   category:(nonnull NSString*)category
            categoryOptions:(AVAudioSessionCategoryOptions)categoryOptions
                       mode:(nonnull NSString*)mode
                      block:(nonnull GLBAudioSessionActivateBlock)block;

+ (void)recordPermission:(nonnull GLBAudioSessionPermissionBlock)block;

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
