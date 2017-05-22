/*--------------------------------------------------*/

#import "GLBDataViewControllerErrorCell.h"
#import "GLBDataViewController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBDataViewControllerErrorCell

#pragma mark - GLBDataViewCell

+ (CGSize)sizeForItem:(GLBDataViewItem*)item availableSize:(CGSize)size {
    return size;
}

#pragma mark - GLBNibExtension

+ (NSBundle*)nibBundle {
    return GLBDataViewController.defaultNibBundle;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
