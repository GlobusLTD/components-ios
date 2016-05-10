/*--------------------------------------------------*/

#import "UINavigationController+GLBUI.h"
#import "UIButton+GLBUI.h"
#import "NSArray+GLBNS.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation UINavigationController (GLB_UI)

#pragma mark - Property

- (void)setGlb_translucent:(BOOL)translucent {
    self.navigationBar.translucent = translucent;
}

- (BOOL)glb_translucent {
    return self.navigationBar.isTranslucent;
}

- (void)setGlb_tintColor:(UIColor*)tintColor {
    self.navigationBar.tintColor = tintColor;
}

- (UIColor*)glb_tintColor {
    return self.navigationBar.tintColor;
}

- (void)setGlb_barTintColor:(UIColor*)barTintColor {
    self.navigationBar.barTintColor = barTintColor;
}

- (UIColor*)glb_barTintColor {
    return self.navigationBar.barTintColor;
}

- (void)setGlb_shadowImage:(UIImage*)shadowImage {
    self.navigationBar.shadowImage = shadowImage;
}

- (UIImage*)glb_shadowImage {
    return self.navigationBar.shadowImage;
}

- (void)setGlb_titleTextAttributes:(NSDictionary*)titleTextAttributes {
    self.navigationBar.titleTextAttributes = titleTextAttributes;
}

- (NSDictionary*)glb_titleTextAttributes {
    return self.navigationBar.titleTextAttributes;
}

- (void)setGlb_backIndicatorImage:(UIImage*)backIndicatorImage {
    self.navigationBar.backIndicatorImage = backIndicatorImage;
}

- (UIImage*)glb_backIndicatorImage {
    return self.navigationBar.backIndicatorImage;
}

- (void)setGlb_backIndicatorTransitionMaskImage:(UIImage*)backIndicatorTransitionMaskImage {
    self.navigationBar.backIndicatorTransitionMaskImage = backIndicatorTransitionMaskImage;
}

- (UIImage*)glb_backIndicatorTransitionMaskImage {
    return self.navigationBar.backIndicatorTransitionMaskImage;
}

- (UIViewController*)glb_rootController {
    NSArray* viewControllers = self.viewControllers;
    if(viewControllers.count > 0) {
        return viewControllers[0];
    }
    return nil;
}

@end

/*--------------------------------------------------*/

@implementation UINavigationItem (GLB_UI)

#pragma mark - Public

- (UIBarButtonItem*)glb_addLeftBarSpace:(CGFloat)space
                               animated:(BOOL)animated {
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [item setWidth:space];
    [self glb_addLeftBarButtonItem:item animated:animated];
    return item;
}

- (UIBarButtonItem*)glb_addRightBarSpace:(CGFloat)space
                                animated:(BOOL)animated {
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [item setWidth:space];
    [self glb_addRightBarButtonItem:item animated:animated];
    return item;
}

- (UIButton*)glb_addLeftBarButtonNormalImage:(UIImage*)normalImage
                                      target:(id)target
                                      action:(SEL)action
                                    animated:(BOOL)animated {
    return [self glb_addLeftBarButtonNormalImage:normalImage
                                highlightedImage:nil
                                   selectedImage:nil
                                   disabledImage:nil
                                          target:target
                                          action:action
                                        animated:animated];
}

- (UIButton*)glb_addLeftBarButtonNormalImage:(UIImage*)normalImage
                            highlightedImage:(UIImage*)highlightedImage
                                      target:(id)target
                                      action:(SEL)action
                                    animated:(BOOL)animated {
    return [self glb_addLeftBarButtonNormalImage:normalImage
                                highlightedImage:highlightedImage
                                   selectedImage:nil
                                   disabledImage:nil
                                          target:target
                                          action:action
                                        animated:animated];
}

- (UIButton*)glb_addLeftBarButtonNormalImage:(UIImage*)normalImage
                            highlightedImage:(UIImage*)highlightedImage
                               disabledImage:(UIImage*)disabledImage
                                      target:(id)target
                                      action:(SEL)action
                                    animated:(BOOL)animated {
    return [self glb_addLeftBarButtonNormalImage:normalImage
                                highlightedImage:highlightedImage
                                   selectedImage:nil
                                   disabledImage:disabledImage
                                          target:target
                                          action:action
                                        animated:animated];
}

- (UIButton*)glb_addLeftBarButtonNormalImage:(UIImage*)normalImage
                            highlightedImage:(UIImage*)highlightedImage
                               selectedImage:(UIImage*)selectedImage
                               disabledImage:(UIImage*)disabledImage
                                      target:(id)target
                                      action:(SEL)action
                                    animated:(BOOL)animated {
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectZero];
    if(normalImage != nil) {
        button.glb_normalImage = normalImage;
    }
    if(highlightedImage != nil) {
        button.glb_highlightedImage = highlightedImage;
    }
    if(selectedImage != nil) {
        button.glb_selectedImage = selectedImage;
    }
    if(disabledImage != nil) {
        button.glb_disabledImage = disabledImage;
    }
    if((target != nil) && (action != nil)) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    [button sizeToFit];
    [self glb_addLeftBarView:button animated:animated];
    return button;
}

- (UIButton*)glb_addRightBarButtonNormalImage:(UIImage*)normalImage
                                       target:(id)target
                                       action:(SEL)action
                                     animated:(BOOL)animated {
    return [self glb_addRightBarButtonNormalImage:normalImage
                                 highlightedImage:nil
                                    selectedImage:nil
                                    disabledImage:nil
                                           target:target
                                           action:action
                                         animated:animated];
}

- (UIButton*)glb_addRightBarButtonNormalImage:(UIImage*)normalImage
                             highlightedImage:(UIImage*)highlightedImage
                                       target:(id)target
                                       action:(SEL)action
                                     animated:(BOOL)animated {
    return [self glb_addRightBarButtonNormalImage:normalImage
                                 highlightedImage:highlightedImage
                                    selectedImage:nil
                                    disabledImage:nil
                                           target:target
                                           action:action
                                         animated:animated];
}

- (UIButton*)glb_addRightBarButtonNormalImage:(UIImage*)normalImage
                             highlightedImage:(UIImage*)highlightedImage
                                disabledImage:(UIImage*)disabledImage
                                       target:(id)target
                                       action:(SEL)action
                                     animated:(BOOL)animated {
    return [self glb_addRightBarButtonNormalImage:normalImage
                                 highlightedImage:highlightedImage
                                    selectedImage:nil
                                    disabledImage:disabledImage
                                           target:target
                                           action:action
                                         animated:animated];
}

- (UIButton*)glb_addRightBarButtonNormalImage:(UIImage*)normalImage
                             highlightedImage:(UIImage*)highlightedImage
                                selectedImage:(UIImage*)selectedImage
                                disabledImage:(UIImage*)disabledImage
                                       target:(id)target
                                       action:(SEL)action
                                     animated:(BOOL)animated {
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectZero];
    if(normalImage != nil) {
        button.glb_normalImage = normalImage;
    }
    if(highlightedImage != nil) {
        button.glb_highlightedImage = highlightedImage;
    }
    if(selectedImage != nil) {
        button.glb_selectedImage = selectedImage;
    }
    if(disabledImage != nil) {
        button.glb_disabledImage = disabledImage;
    }
    if((target != nil) && (action != nil)) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    [button sizeToFit];
    [self glb_addRightBarView:button animated:animated];
    return button;
}

- (UIButton*)glb_addLeftBarButtonNormalTitle:(NSString*)normalTitle
                                      target:(id)target
                                      action:(SEL)action
                                    animated:(BOOL)animated {
    return [self glb_addLeftBarButtonNormalTitle:normalTitle
                                highlightedTitle:nil
                                   selectedTitle:nil
                                   disabledTitle:nil
                                normalTitleColor:nil
                           highlightedTitleColor:nil
                              selectedTitleColor:nil
                              disabledTitleColor:nil
                                            font:nil
                                           frame:CGRectZero
                                          target:target
                                          action:action
                                        animated:animated];
}

- (UIButton*)glb_addLeftBarButtonNormalTitle:(NSString*)normalTitle
                            normalTitleColor:(UIColor*)normalTitleColor
                                      target:(id)target
                                      action:(SEL)action
                                    animated:(BOOL)animated {
    return [self glb_addLeftBarButtonNormalTitle:normalTitle
                                highlightedTitle:nil
                                   selectedTitle:nil
                                   disabledTitle:nil
                                normalTitleColor:normalTitleColor
                           highlightedTitleColor:nil
                              selectedTitleColor:nil
                              disabledTitleColor:nil
                                            font:nil
                                           frame:CGRectZero
                                          target:target
                                          action:action
                                        animated:animated];
}

- (UIButton*)glb_addLeftBarButtonNormalTitle:(NSString*)normalTitle
                            normalTitleColor:(UIColor*)normalTitleColor
                                        font:(UIFont*)font
                                      target:(id)target
                                      action:(SEL)action
                                    animated:(BOOL)animated {
    return [self glb_addLeftBarButtonNormalTitle:normalTitle
                                highlightedTitle:nil
                                   selectedTitle:nil
                                   disabledTitle:nil
                                normalTitleColor:normalTitleColor
                           highlightedTitleColor:nil
                              selectedTitleColor:nil
                              disabledTitleColor:nil
                                            font:font
                                           frame:CGRectZero
                                          target:target
                                          action:action
                                        animated:animated];
}

- (UIButton*)glb_addLeftBarButtonNormalTitle:(NSString*)normalTitle
                            normalTitleColor:(UIColor*)normalTitleColor
                                        font:(UIFont*)font
                                       frame:(CGRect)frame
                                      target:(id)target
                                      action:(SEL)action
                                    animated:(BOOL)animated {
    return [self glb_addLeftBarButtonNormalTitle:normalTitle
                                highlightedTitle:nil
                                   selectedTitle:nil
                                   disabledTitle:nil
                                normalTitleColor:normalTitleColor
                           highlightedTitleColor:nil
                              selectedTitleColor:nil
                              disabledTitleColor:nil
                                            font:font
                                           frame:frame
                                          target:target
                                          action:action
                                        animated:animated];
}

- (UIButton*)glb_addLeftBarButtonNormalTitle:(NSString*)normalTitle
                            highlightedTitle:(NSString*)highlightedTitle
                                      target:(id)target
                                      action:(SEL)action
                                    animated:(BOOL)animated {
    return [self glb_addLeftBarButtonNormalTitle:normalTitle
                                highlightedTitle:highlightedTitle
                                   selectedTitle:nil
                                   disabledTitle:nil
                                normalTitleColor:nil
                           highlightedTitleColor:nil
                              selectedTitleColor:nil
                              disabledTitleColor:nil
                                            font:nil
                                           frame:CGRectZero
                                          target:target
                                          action:action
                                        animated:animated];
}

- (UIButton*)glb_addLeftBarButtonNormalTitle:(NSString*)normalTitle
                            highlightedTitle:(NSString*)highlightedTitle
                               disabledTitle:(NSString*)disabledTitle
                                      target:(id)target
                                      action:(SEL)action
                                    animated:(BOOL)animated {
    return [self glb_addLeftBarButtonNormalTitle:normalTitle
                                highlightedTitle:highlightedTitle
                                   selectedTitle:nil
                                   disabledTitle:disabledTitle
                                normalTitleColor:nil
                           highlightedTitleColor:nil
                              selectedTitleColor:nil
                              disabledTitleColor:nil
                                            font:nil
                                           frame:CGRectZero
                                          target:target
                                          action:action
                                        animated:animated];
}

- (UIButton*)glb_addLeftBarButtonNormalTitle:(NSString*)normalTitle
                            highlightedTitle:(NSString*)highlightedTitle
                               selectedTitle:(NSString*)selectedTitle
                               disabledTitle:(NSString*)disabledTitle
                                      target:(id)target
                                      action:(SEL)action
                                    animated:(BOOL)animated {
    return [self glb_addLeftBarButtonNormalTitle:normalTitle
                                highlightedTitle:highlightedTitle
                                   selectedTitle:selectedTitle
                                   disabledTitle:disabledTitle
                                normalTitleColor:nil
                           highlightedTitleColor:nil
                              selectedTitleColor:nil
                              disabledTitleColor:nil
                                            font:nil
                                           frame:CGRectZero
                                          target:target
                                          action:action
                                        animated:animated];
}

- (UIButton*)glb_addLeftBarButtonNormalTitle:(NSString*)normalTitle
                            highlightedTitle:(NSString*)highlightedTitle
                               selectedTitle:(NSString*)selectedTitle
                               disabledTitle:(NSString*)disabledTitle
                            normalTitleColor:(UIColor*)normalTitleColor
                       highlightedTitleColor:(UIColor*)highlightedTitleColor
                          selectedTitleColor:(UIColor*)selectedTitleColor
                          disabledTitleColor:(UIColor*)disabledTitleColor
                                        font:(UIFont*)font
                                       frame:(CGRect)frame
                                      target:(id)target
                                      action:(SEL)action
                                    animated:(BOOL)animated {
    UIButton* button = [[UIButton alloc] initWithFrame:frame];
    if(normalTitle != nil) {
        button.glb_normalTitle = normalTitle;
    }
    if(normalTitleColor != nil) {
        button.glb_normalTitleColor = normalTitleColor;
    }
    if(highlightedTitle != nil) {
        button.glb_highlightedTitle = highlightedTitle;
    }
    if(highlightedTitleColor != nil) {
        button.glb_highlightedTitleColor = highlightedTitleColor;
    }
    if(selectedTitle != nil) {
        button.glb_selectedTitle = selectedTitle;
    }
    if(selectedTitleColor != nil) {
        button.glb_selectedTitleColor = selectedTitleColor;
    }
    if(disabledTitle != nil) {
        button.glb_disabledTitle = disabledTitle;
    }
    if(disabledTitleColor != nil) {
        button.glb_disabledTitleColor = disabledTitleColor;
    }
    if(font != nil) {
        button.titleLabel.font = font;
    }
    if((target != nil) && (action != nil)) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    [button sizeToFit];
    [self glb_addLeftBarView:button animated:animated];
    return button;
}

- (UIButton*)glb_addRightBarButtonNormalTitle:(NSString*)normalTitle
                                       target:(id)target
                                       action:(SEL)action
                                     animated:(BOOL)animated {
    return [self glb_addRightBarButtonNormalTitle:normalTitle
                                 highlightedTitle:nil
                                    selectedTitle:nil
                                    disabledTitle:nil
                                 normalTitleColor:nil
                            highlightedTitleColor:nil
                               selectedTitleColor:nil
                               disabledTitleColor:nil
                                             font:nil
                                            frame:CGRectZero
                                           target:target
                                           action:action
                                         animated:animated];
}

- (UIButton*)glb_addRightBarButtonNormalTitle:(NSString*)normalTitle
                             normalTitleColor:(UIColor*)normalTitleColor
                                       target:(id)target
                                       action:(SEL)action
                                     animated:(BOOL)animated {
    return [self glb_addRightBarButtonNormalTitle:normalTitle
                                 highlightedTitle:nil
                                    selectedTitle:nil
                                    disabledTitle:nil
                                 normalTitleColor:normalTitleColor
                            highlightedTitleColor:nil
                               selectedTitleColor:nil
                               disabledTitleColor:nil
                                             font:nil
                                            frame:CGRectZero
                                           target:target
                                           action:action
                                         animated:animated];
}

- (UIButton*)glb_addRightBarButtonNormalTitle:(NSString*)normalTitle
                             normalTitleColor:(UIColor*)normalTitleColor
                                         font:(UIFont*)font
                                       target:(id)target
                                       action:(SEL)action
                                     animated:(BOOL)animated {
    return [self glb_addRightBarButtonNormalTitle:normalTitle
                                 highlightedTitle:nil
                                    selectedTitle:nil
                                    disabledTitle:nil
                                 normalTitleColor:normalTitleColor
                            highlightedTitleColor:nil
                               selectedTitleColor:nil
                               disabledTitleColor:nil
                                             font:font
                                            frame:CGRectZero
                                           target:target
                                           action:action
                                         animated:animated];
}

- (UIButton*)glb_addRightBarButtonNormalTitle:(NSString*)normalTitle
                             normalTitleColor:(UIColor*)normalTitleColor
                                         font:(UIFont*)font
                                        frame:(CGRect)frame
                                       target:(id)target
                                       action:(SEL)action
                                     animated:(BOOL)animated {
    return [self glb_addRightBarButtonNormalTitle:normalTitle
                                 highlightedTitle:nil
                                    selectedTitle:nil
                                    disabledTitle:nil
                                 normalTitleColor:normalTitleColor
                            highlightedTitleColor:nil
                               selectedTitleColor:nil
                               disabledTitleColor:nil
                                             font:font
                                            frame:frame
                                           target:target
                                           action:action
                                         animated:animated];
}

- (UIButton*)glb_addRightBarButtonNormalTitle:(NSString*)normalTitle
                             highlightedTitle:(NSString*)highlightedTitle
                                       target:(id)target
                                       action:(SEL)action
                                     animated:(BOOL)animated {
    return [self glb_addRightBarButtonNormalTitle:normalTitle
                                 highlightedTitle:highlightedTitle
                                    selectedTitle:nil
                                    disabledTitle:nil
                                 normalTitleColor:nil
                            highlightedTitleColor:nil
                               selectedTitleColor:nil
                               disabledTitleColor:nil
                                             font:nil
                                            frame:CGRectZero
                                           target:target
                                           action:action
                                         animated:animated];
}

- (UIButton*)glb_addRightBarButtonNormalTitle:(NSString*)normalTitle
                             highlightedTitle:(NSString*)highlightedTitle
                                disabledTitle:(NSString*)disabledTitle
                                       target:(id)target
                                       action:(SEL)action
                                     animated:(BOOL)animated {
    return [self glb_addRightBarButtonNormalTitle:normalTitle
                                 highlightedTitle:highlightedTitle
                                    selectedTitle:nil
                                    disabledTitle:disabledTitle
                                 normalTitleColor:nil
                            highlightedTitleColor:nil
                               selectedTitleColor:nil
                               disabledTitleColor:nil
                                             font:nil
                                            frame:CGRectZero
                                           target:target
                                           action:action
                                         animated:animated];
}

- (UIButton*)glb_addRightBarButtonNormalTitle:(NSString*)normalTitle
                             highlightedTitle:(NSString*)highlightedTitle
                                selectedTitle:(NSString*)selectedTitle
                                disabledTitle:(NSString*)disabledTitle
                                       target:(id)target
                                       action:(SEL)action
                                     animated:(BOOL)animated {
    return [self glb_addRightBarButtonNormalTitle:normalTitle
                                 highlightedTitle:highlightedTitle
                                    selectedTitle:selectedTitle
                                    disabledTitle:disabledTitle
                                 normalTitleColor:nil
                            highlightedTitleColor:nil
                               selectedTitleColor:nil
                               disabledTitleColor:nil
                                             font:nil
                                            frame:CGRectZero
                                           target:target
                                           action:action
                                         animated:animated];
}

- (UIButton*)glb_addRightBarButtonNormalTitle:(NSString*)normalTitle
                             highlightedTitle:(NSString*)highlightedTitle
                                selectedTitle:(NSString*)selectedTitle
                                disabledTitle:(NSString*)disabledTitle
                             normalTitleColor:(UIColor*)normalTitleColor
                        highlightedTitleColor:(UIColor*)highlightedTitleColor
                           selectedTitleColor:(UIColor*)selectedTitleColor
                           disabledTitleColor:(UIColor*)disabledTitleColor
                                         font:(UIFont*)font
                                        frame:(CGRect)frame
                                       target:(id)target
                                       action:(SEL)action
                                     animated:(BOOL)animated {
    UIButton* button = [[UIButton alloc] initWithFrame:frame];
    if(normalTitle != nil) {
        button.glb_normalTitle = normalTitle;
    }
    if(normalTitleColor != nil) {
        button.glb_normalTitleColor = normalTitleColor;
    }
    if(highlightedTitle != nil) {
        button.glb_highlightedTitle = highlightedTitle;
    }
    if(highlightedTitleColor != nil) {
        button.glb_highlightedTitleColor = highlightedTitleColor;
    }
    if(selectedTitle != nil) {
        button.glb_selectedTitle = selectedTitle;
    }
    if(selectedTitleColor != nil) {
        button.glb_selectedTitleColor = selectedTitleColor;
    }
    if(disabledTitle != nil) {
        button.glb_disabledTitle = disabledTitle;
    }
    if(disabledTitleColor != nil) {
        button.glb_disabledTitleColor = disabledTitleColor;
    }
    if(font != nil) {
        button.titleLabel.font = font;
    }
    if((target != nil) && (action != nil)) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    [button sizeToFit];
    [self glb_addRightBarView:button animated:animated];
    return button;
}

- (UIBarButtonItem*)glb_addLeftBarView:(UIView*)view
                              animated:(BOOL)animated {
    return [self glb_addLeftBarView:view
                             target:nil
                             action:nil
                           animated:animated];
}

- (UIBarButtonItem*)glb_addLeftBarView:(UIView*)view
                                target:(id)target
                                action:(SEL)action
                              animated:(BOOL)animated {
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    if((target != nil) && (action != nil)) {
        UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
        [view addGestureRecognizer:tapGesture];
    }
    [self glb_addLeftBarButtonItem:barButtonItem animated:animated];
    return barButtonItem;
}

- (UIBarButtonItem*)glb_addRightBarView:(UIView*)view
                               animated:(BOOL)animated {
    return [self glb_addRightBarView:view
                              target:nil
                              action:nil
                            animated:animated];
}

- (UIBarButtonItem*)glb_addRightBarView:(UIView*)view
                                 target:(id)target
                                 action:(SEL)action
                               animated:(BOOL)animated {
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    if((target != nil) && (action != nil)) {
        UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
        [view addGestureRecognizer:tapGesture];
    }
    [self glb_addRightBarButtonItem:barButtonItem animated:animated];
    return barButtonItem;
}

- (void)glb_addLeftBarButtonItem:(UIBarButtonItem*)barButtonItem
                        animated:(BOOL)animated {
    [self setLeftBarButtonItems:[NSArray glb_arrayWithArray:self.leftBarButtonItems addingObject:barButtonItem]
                       animated:animated];
}

- (void)glb_addRightBarButtonItem:(UIBarButtonItem*)barButtonItem
                         animated:(BOOL)animated {
    [self setRightBarButtonItems:[NSArray glb_arrayWithArray:self.rightBarButtonItems addingObject:barButtonItem]
                        animated:animated];
}

- (void)glb_removeLeftBarButtonItem:(UIBarButtonItem*)barButtonItem
                           animated:(BOOL)animated {
    [self setLeftBarButtonItems:[NSArray glb_arrayWithArray:self.leftBarButtonItems removingObject:barButtonItem]
                       animated:animated];
}

- (void)glb_removeRightBarButtonItem:(UIBarButtonItem*)barButtonItem
                            animated:(BOOL)animated {
    [self setRightBarButtonItems:[NSArray glb_arrayWithArray:self.rightBarButtonItems removingObject:barButtonItem]
                        animated:animated];
}

- (void)glb_removeAllLeftBarButtonItemsAnimated:(BOOL)animated {
    [self setLeftBarButtonItems:@[]
                       animated:animated];
}

- (void)glb_removeAllRightBarButtonItemsAnimated:(BOOL)animated {
    [self setRightBarButtonItems:@[]
                        animated:animated];
}

- (void)glb_setLeftBarAutomaticAlignmentAnimated:(BOOL)animated {
    __block CGFloat width = 0.0f;
    [self.rightBarButtonItems glb_each:^(UIBarButtonItem* barButtonItem) {
        width += barButtonItem.width;
    }];
    [self glb_addLeftBarSpace:width
                     animated:animated];
}

- (void)glb_setRightBarAutomaticAlignmentAnimated:(BOOL)animated {
    __block CGFloat width = 0.0f;
    [self.leftBarButtonItems glb_each:^(UIBarButtonItem* barButtonItem) {
        width += barButtonItem.width;
    }];
    [self glb_addRightBarSpace:width
                      animated:animated];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
