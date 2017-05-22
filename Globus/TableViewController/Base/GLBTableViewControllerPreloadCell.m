/*--------------------------------------------------*/

#import "GLBDataViewControllerPreloadCell.h"
#import "GLBDataViewController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

static CGFloat DefaultHeight = 100;

/*--------------------------------------------------*/

@implementation GLBDataViewControllerPreloadCell

#pragma mark - GLBDataViewCell

+ (CGSize)sizeForItem:(GLBDataViewItem*)item availableSize:(CGSize)size {
    return CGSizeMake(size.width, DefaultHeight);
}

#pragma mark - GLBNibExtension

+ (NSBundle*)nibBundle {
    return GLBDataViewController.defaultNibBundle;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
