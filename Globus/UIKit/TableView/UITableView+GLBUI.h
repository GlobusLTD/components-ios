/*--------------------------------------------------*/

#include "UIView+GLBUI.h"
#import "UINib+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface UITableView (GLB_UI)

- (BOOL)glb_registerCell:(nonnull Class)cell;
- (BOOL)glb_registerCell:(nonnull Class)cell reuseIdentifier:(nonnull NSString*)reuseIdentifier;

- (BOOL)glb_registerView:(nonnull Class)view;
- (BOOL)glb_registerView:(nonnull Class)view reuseIdentifier:(nonnull NSString*)reuseIdentifier;

- (nullable __kindof UITableViewCell*)glb_dequeueReusableCell:(nonnull Class)cell;

- (nullable __kindof UITableViewHeaderFooterView*)glb_dequeueReusableView:(nonnull Class)view;

@end

/*--------------------------------------------------*/

@interface UITableViewCell (GLB_UI)

+ (nonnull NSString*)glb_reuseIdentifier;

@end

/*--------------------------------------------------*/

@interface UITableViewHeaderFooterView (GLB_UI)

+ (nonnull NSString*)glb_reuseIdentifier;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
