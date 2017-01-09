/*--------------------------------------------------*/

#include "UIView+GLBUI.h"
#include "UINib+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface UICollectionView (GLB_UI)

- (BOOL)glb_registerCell:(Class _Nonnull)cell;
- (BOOL)glb_registerCell:(Class _Nonnull)cell reuseIdentifier:(NSString* _Nonnull)reuseIdentifier;

- (BOOL)glb_registerView:(Class _Nonnull)view kind:(NSString* _Nonnull)kind;
- (BOOL)glb_registerView:(Class _Nonnull)view kind:(NSString* _Nonnull)kind reuseIdentifier:(NSString* _Nonnull)reuseIdentifier;

- (__kindof UICollectionViewCell* _Nullable)glb_dequeueReusableCell:(Class _Nonnull)cell indexPath:(NSIndexPath* _Nonnull)indexPath;

- (__kindof UICollectionReusableView* _Nullable)glb_dequeueReusableView:(Class _Nonnull)view kind:(NSString* _Nonnull)kind indexPath:(NSIndexPath* _Nonnull)indexPath;

@end

/*--------------------------------------------------*/

@interface UICollectionViewCell (GLB_UI)

+ (NSString* _Nonnull)glb_reuseIdentifier;

@end

/*--------------------------------------------------*/

@interface UICollectionReusableView (GLB_UI)

+ (NSString* _Nonnull)glb_reuseIdentifier;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
