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

+ (instancetype _Nullable)shared;

- (void)addObserver:(id< GLBAudioSessionObserver > _Nonnull)observer;
- (void)removeObserver:(id< GLBAudioSessionObserver > _Nonnull)observer;

+ (void)activateWithOptions:(AVAudioSessionSetActiveOptions)activeOptions
                   category:(NSString* _Nonnull)category
            categoryOptions:(AVAudioSessionCategoryOptions)categoryOptions
                       mode:(NSString* _Nonnull)mode
                      block:(GLBAudioSessionActivateBlock _Nonnull)block;

+ (void)recordPermission:(GLBAudioSessionPermissionBlock _Nonnull)block;

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
