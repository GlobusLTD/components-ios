/*--------------------------------------------------*/

#include "UIView+GLBUI.h"
#import "UINib+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface UITableView (GLB_UI)

- (BOOL)glb_registerCell:(Class _Nonnull)cell;
- (BOOL)glb_registerCell:(Class _Nonnull)cell reuseIdentifier:(NSString* _Nonnull)reuseIdentifier;

- (BOOL)glb_registerView:(Class _Nonnull)view;
- (BOOL)glb_registerView:(Class _Nonnull)view reuseIdentifier:(NSString* _Nonnull)reuseIdentifier;

- (__kindof UITableViewCell* _Nullable)glb_dequeueReusableCell:(Class _Nonnull)cell;

- (__kindof UITableViewHeaderFooterView* _Nullable)glb_dequeueReusableView:(Class _Nonnull)view;

@end

/*--------------------------------------------------*/

@interface UITableViewCell (GLB_UI)

+ (NSString* _Nonnull)glb_reuseIdentifier;

@end

/*--------------------------------------------------*/

@interface UITableViewHeaderFooterView (GLB_UI)

+ (NSString* _Nonnull)glb_reuseIdentifier;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
