/*--------------------------------------------------*/

#import "GLBAudioSession.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBAudioSession

#pragma mark Public

+ (void)activateWithOptions:(AVAudioSessionSetActiveOptions)activeOptions
                   category:(NSString*)category
            categoryOptions:(AVAudioSessionCategoryOptions)categoryOptions
                       mode:(NSString*)mode
                      block:(GLBAudioSessionActivateBlock)block {
    NSError* error = nil;
    AVAudioSession* audioSession = AVAudioSession.sharedInstance;
    if((category != nil) && (([audioSession.category isEqualToString:category] == NO) || (audioSession.categoryOptions != categoryOptions))) {
        if([audioSession setCategory:category withOptions:categoryOptions error:&error] == NO) {
            if(block != nil) {
                block(error);
            }
            return;
        }
    }
    if((mode != nil) && ([audioSession.mode isEqualToString:mode] == NO)) {
        if([audioSession setMode:mode error:&error] == NO) {
            if(block != nil) {
                block(error);
            }
            return;
        }
    }
    if([audioSession setActive:YES withOptions:activeOptions error:&error] == NO) {
        if(block != nil) {
            block(error);
        }
        return;
    }
    if(block != nil) {
        block(nil);
    }
}

+ (void)recordPermission:(GLBAudioSessionPermissionBlock)block {
    AVAudioSession* audioSession = AVAudioSession.sharedInstance;
    if(audioSession.recordPermission != AVAudioSessionRecordPermissionGranted) {
        [audioSession requestRecordPermission:^(BOOL granted) {
            if(granted == YES) {
                if(block != nil) {
                    block();
                }
            }
        }];
    } else if(block != nil) {
        block();
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
