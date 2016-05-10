/*--------------------------------------------------*/

#import "UITabBar+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation UITabBar (GLB_UI)

#pragma mark - Property

- (void)setGlb_selectedItemIndex:(NSUInteger)selectedItemIndex {
    self.selectedItem = (self.items)[selectedItemIndex];
}

- (NSUInteger)glb_selectedItemIndex {
    return [self.items indexOfObject:self.selectedItem];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
