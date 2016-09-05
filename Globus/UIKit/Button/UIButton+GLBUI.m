/*--------------------------------------------------*/

#import "UIButton+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation UIButton (GLB_UI)

#pragma mark - Property

- (void)setGlb_normalTitle:(NSString*)normalTitle {
    [self setTitle:normalTitle forState:UIControlStateNormal];
}

- (NSString*)glb_normalTitle {
    return [self titleForState:UIControlStateNormal];
}

- (void)setGlb_normalTitleColor:(UIColor*)normalTitleColor {
    [self setTitleColor:normalTitleColor forState:UIControlStateNormal];
}

- (UIColor*)glb_normalTitleColor {
    return [self titleColorForState:UIControlStateNormal];
}

- (void)setGlb_normalTitleShadowColor:(UIColor*)normalTitleShadowColor {
    [self setTitleShadowColor:normalTitleShadowColor forState:UIControlStateNormal];
}

- (UIColor*)glb_normalTitleShadowColor {
    return [self titleShadowColorForState:UIControlStateNormal];
}

- (void)setGlb_normalImage:(UIImage*)normalImage {
    [self setImage:normalImage forState:UIControlStateNormal];
}

- (UIImage*)glb_normalImage {
    return [self imageForState:UIControlStateNormal];
}

- (void)setGlb_normalBackgroundImage:(UIImage*)normalBackgroundImage {
    [self setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
}

- (UIImage*)glb_normalBackgroundImage {
    return [self backgroundImageForState:UIControlStateNormal];
}

- (void)setGlb_highlightedTitle:(NSString*)highlightedTitle {
    [self setTitle:highlightedTitle forState:UIControlStateHighlighted];
}

- (NSString*)glb_highlightedTitle {
    return [self titleForState:UIControlStateHighlighted];
}

- (void)setGlb_highlightedTitleColor:(UIColor*)highlightedTitleColor {
    [self setTitleColor:highlightedTitleColor forState:UIControlStateHighlighted];
}

- (UIColor*)glb_highlightedTitleColor {
    return [self titleColorForState:UIControlStateHighlighted];
}

- (void)setGlb_highlightedTitleShadowColor:(UIColor*)highlightedTitleShadowColor {
    [self setTitleShadowColor:highlightedTitleShadowColor forState:UIControlStateHighlighted];
}

- (UIColor*)glb_highlightedTitleShadowColor {
    return [self titleShadowColorForState:UIControlStateHighlighted];
}

- (void)setGlb_highlightedImage:(UIImage*)highlightedImage {
    [self setImage:highlightedImage forState:UIControlStateHighlighted];
}

- (UIImage*)glb_highlightedImage {
    return [self imageForState:UIControlStateHighlighted];
}

- (void)setGlb_highlightedBackgroundImage:(UIImage*)highlightedBackgroundImage {
    [self setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted];
}

- (UIImage*)glb_highlightedBackgroundImage {
    return [self backgroundImageForState:UIControlStateHighlighted];
}

- (void)setGlb_selectedTitle:(NSString*)selectedTitle {
    [self setTitle:selectedTitle forState:UIControlStateSelected];
}

- (NSString*)glb_selectedTitle {
    return [self titleForState:UIControlStateSelected];
}

- (void)setGlb_selectedTitleColor:(UIColor*)selectedTitleColor {
    [self setTitleColor:selectedTitleColor forState:UIControlStateSelected];
}

- (UIColor*)glb_selectedTitleColor {
    return [self titleColorForState:UIControlStateSelected];
}

- (void)setGlb_selectedTitleShadowColor:(UIColor*)selectedTitleShadowColor {
    [self setTitleShadowColor:selectedTitleShadowColor forState:UIControlStateSelected];
}

- (UIColor*)glb_selectedTitleShadowColor {
    return [self titleShadowColorForState:UIControlStateSelected];
}

- (void)setGlb_selectedImage:(UIImage*)selectedImage {
    [self setImage:selectedImage forState:UIControlStateSelected];
}

- (UIImage*)glb_selectedImage {
    return [self imageForState:UIControlStateSelected];
}

- (void)setGlb_selectedBackgroundImage:(UIImage*)selectedBackgroundImage {
    [self setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected];
}

- (UIImage*)glb_selectedBackgroundImage {
    return [self backgroundImageForState:UIControlStateSelected];
}

- (void)setGlb_disabledTitle:(NSString*)disabledTitle {
    [self setTitle:disabledTitle forState:UIControlStateDisabled];
}

- (NSString*)glb_disabledTitle {
    return [self titleForState:UIControlStateDisabled];
}

- (void)setGlb_disabledTitleColor:(UIColor*)disabledTitleColor {
    [self setTitleColor:disabledTitleColor forState:UIControlStateDisabled];
}

- (UIColor*)glb_disabledTitleColor {
    return [self titleColorForState:UIControlStateDisabled];
}

- (void)setGlb_disabledTitleShadowColor:(UIColor*)disabledTitleShadowColor {
    [self setTitleShadowColor:disabledTitleShadowColor forState:UIControlStateDisabled];
}

- (UIColor*)glb_disabledTitleShadowColor {
    return [self titleShadowColorForState:UIControlStateDisabled];
}

- (void)setGlb_disabledImage:(UIImage*)disabledImage {
    [self setImage:disabledImage forState:UIControlStateDisabled];
}

- (UIImage*)glb_disabledImage {
    return [self imageForState:UIControlStateDisabled];
}

- (void)setGlb_disabledBackgroundImage:(UIImage*)disabledBackgroundImage {
    [self setBackgroundImage:disabledBackgroundImage forState:UIControlStateDisabled];
}

- (UIImage*)glb_disabledBackgroundImage {
    return [self backgroundImageForState:UIControlStateDisabled];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
