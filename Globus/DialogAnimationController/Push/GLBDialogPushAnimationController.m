/*--------------------------------------------------*/

#import "GLBDialogPushAnimationController.h"
#import "GLBDialogViewController+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBDialogPushAnimationController

#pragma mark - Public

- (void)presentDialogViewController:(GLBDialogViewController*)dialogViewController completion:(GLBSimpleBlock)completion {
    NSTimeInterval duration = dialogViewController.animationDuration;
    NSTimeInterval backgroundDuration = duration * 0.5;
    NSTimeInterval backgroundDelay = 0.0;
    NSTimeInterval contentDuration = duration * 0.8;
    NSTimeInterval contentDelay = duration * 0.4;
    
    dialogViewController.view.alpha = 0.0;
#if __has_include("GLBBlurView.h")
    if(dialogViewController.backgroundBlurred == YES) {
        dialogViewController.backgroundView.blurRadius = 0.0;
    }
#endif
    [UIView animateWithDuration:backgroundDuration  delay:backgroundDelay options:0 animations:^{
#if __has_include("GLBBlurView.h")
        if(dialogViewController.backgroundBlurred == YES) {
            dialogViewController.backgroundView.blurRadius = dialogViewController.backgroundBlurRadius;
        }
#endif
        dialogViewController.view.alpha = 1.0;
    } completion:nil];
    
    dialogViewController.contentViewController.view.alpha = 0.0;
    dialogViewController.contentVerticalOffset = -50.0;
    [dialogViewController _updateConstraintContentView];
    [dialogViewController.view layoutIfNeeded];
    
    dialogViewController.contentVerticalOffset = 0.0;
    [dialogViewController _updateConstraintContentView];
    
    [UIView animateWithDuration:contentDuration  delay:contentDelay options:0 animations:^{
        dialogViewController.contentViewController.view.alpha = 1.0;
        [dialogViewController.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if(completion != nil) {
            completion();
        }
    }];
}

- (void)dismissDialogViewController:(GLBDialogViewController*)dialogViewController completion:(GLBSimpleBlock)completion {
    NSTimeInterval duration = dialogViewController.animationDuration;
    NSTimeInterval backgroundDuration = duration * 0.5;
    NSTimeInterval backgroundDelay = duration * 0.4;
    NSTimeInterval contentDuration = duration * 0.8;
    NSTimeInterval contentDelay = 0.0;
    
    [UIView animateWithDuration:backgroundDuration  delay:backgroundDelay options:0 animations:^{
#if __has_include("GLBBlurView.h")
        if(dialogViewController.backgroundBlurred == YES) {
            dialogViewController.backgroundView.blurRadius = 0.0;
        }
#endif
        dialogViewController.view.alpha = 0.0;
    } completion:nil];
    
    dialogViewController.contentVerticalOffset = -500.0;
    [dialogViewController _updateConstraintContentView];
    
    [UIView animateWithDuration:contentDuration  delay:contentDelay options:0 animations:^{
        dialogViewController.contentViewController.view.alpha = 0.0;
        [dialogViewController.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if(completion != nil) {
            completion();
        }
        dialogViewController.view.alpha = 1.0;
        dialogViewController.contentVerticalOffset = 0.0;
        dialogViewController.contentViewController.view.alpha = 1.0;
    }];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
