/*--------------------------------------------------*/

#import "UICollectionView+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation UICollectionView (GLB_UI)

- (BOOL)glb_registerCell:(Class)cell {
    return [self glb_registerCell:cell reuseIdentifier:[cell glb_reuseIdentifier]];
}

- (BOOL)glb_registerCell:(Class)cell reuseIdentifier:(NSString*)reuseIdentifier {
    UINib* nib = [UINib glb_nibWithClass:cell];
    if(nib != nil) {
        [self registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    }
    return (nib != nil);
}

- (BOOL)glb_registerView:(Class)view kind:(NSString*)kind {
    return [self glb_registerView:view kind:kind reuseIdentifier:[view glb_reuseIdentifier]];
}

- (BOOL)glb_registerView:(Class)view kind:(NSString*)kind reuseIdentifier:(NSString*)reuseIdentifier {
    UINib* nib = [UINib glb_nibWithClass:view];
    if(nib != nil) {
        [self registerNib:nib forSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier];
    }
    return (nib != nil);
}

- (UICollectionViewCell*)glb_dequeueReusableCell:(Class)cell indexPath:(NSIndexPath*)indexPath {
    return [self dequeueReusableCellWithReuseIdentifier:[cell glb_reuseIdentifier] forIndexPath:indexPath];
}

- (UICollectionReusableView*)glb_dequeueReusableView:(Class)view kind:(NSString*)kind indexPath:(NSIndexPath*)indexPath {
    return [self dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[view glb_reuseIdentifier] forIndexPath:indexPath];
}

@end

/*--------------------------------------------------*/

@implementation UICollectionViewCell (GLB_UI)

+ (NSString*)glb_reuseIdentifier {
    return @"UniqueIdentifier";
}

@end

/*--------------------------------------------------*/

@implementation UICollectionReusableView (GLB_UI)

+ (NSString*)glb_reuseIdentifier {
    return @"UniqueIdentifier";
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
