/*--------------------------------------------------*/

#include "UIView+GLBUI.h"
#include "UINib+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface UICollectionView (GLB_UI)

- (BOOL)glb_registerCell:(nonnull Class)cell;
- (BOOL)glb_registerCell:(nonnull Class)cell reuseIdentifier:(nonnull NSString*)reuseIdentifier;

- (BOOL)glb_registerView:(nonnull Class)view kind:(nonnull NSString*)kind;
- (BOOL)glb_registerView:(nonnull Class)view kind:(nonnull NSString*)kind reuseIdentifier:(nonnull NSString*)reuseIdentifier;

- (nullable __kindof UICollectionViewCell*)glb_dequeueReusableCell:(nonnull Class)cell indexPath:(nonnull NSIndexPath*)indexPath;

- (nullable __kindof UICollectionReusableView*)glb_dequeueReusableView:(nonnull Class)view kind:(nonnull NSString*)kind indexPath:(nonnull NSIndexPath*)indexPath;

@end

/*--------------------------------------------------*/

@interface UICollectionViewCell (GLB_UI)

+ (nonnull NSString*)glb_reuseIdentifier;

@end

/*--------------------------------------------------*/

@interface UICollectionReusableView (GLB_UI)

+ (nonnull NSString*)glb_reuseIdentifier;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
