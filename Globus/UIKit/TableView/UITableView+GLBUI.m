/*--------------------------------------------------*/

#import "UITableView+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation UITableView (GLB_UI)

- (BOOL)glb_registerCell:(Class)cell {
    return [self glb_registerCell:cell reuseIdentifier:[cell glb_reuseIdentifier]];
}

- (BOOL)glb_registerCell:(Class)cell reuseIdentifier:(NSString*)reuseIdentifier {
    UINib* nib = [UINib glb_nibWithClass:cell];
    if(nib != nil) {
        [self registerNib:nib forCellReuseIdentifier:reuseIdentifier];
    }
    return (nib != nil);
}

- (BOOL)glb_registerView:(Class)view {
    return [self glb_registerView:view reuseIdentifier:[view glb_reuseIdentifier]];
}

- (BOOL)glb_registerView:(Class)view reuseIdentifier:(NSString*)reuseIdentifier {
    UINib* nib = [UINib glb_nibWithClass:view];
    if(nib != nil) {
        [self registerNib:nib forHeaderFooterViewReuseIdentifier:reuseIdentifier];
    }
    return (nib != nil);
}

- (UITableViewCell*)glb_dequeueReusableCell:(Class)cell {
    return [self dequeueReusableCellWithIdentifier:[cell glb_reuseIdentifier]];
}


- (UITableViewHeaderFooterView*)glb_dequeueReusableView:(Class)view {
    return [self dequeueReusableHeaderFooterViewWithIdentifier:[view glb_reuseIdentifier]];
}

@end

/*--------------------------------------------------*/

@implementation UITableViewCell (GLB_UI)

+ (NSString*)glb_reuseIdentifier {
    return @"UniqueIdentifier";
}

@end

/*--------------------------------------------------*/

@implementation UITableViewHeaderFooterView (GLB_UI)

+ (NSString*)glb_reuseIdentifier {
    return @"UniqueIdentifier";
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
