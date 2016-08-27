/*--------------------------------------------------*/

#import "UIViewController+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface UINavigationController (GLB_UI)

@property(nonatomic) BOOL glb_translucent;
@property(nonatomic, retain) UIColor* glb_tintColor;
@property(nonatomic, retain) UIColor* glb_barTintColor;
@property(nonatomic, retain) UIImage* glb_shadowImage;
@property(nonatomic, copy) NSDictionary* glb_titleTextAttributes;
@property(nonatomic, retain) UIImage* glb_backIndicatorImage;
@property(nonatomic, retain) UIImage* glb_backIndicatorTransitionMaskImage;
@property(nonatomic, readonly, strong) UIViewController* glb_rootController;

@end

/*--------------------------------------------------*/

@interface UINavigationItem (GLB_UI)

- (UIBarButtonItem*)glb_addLeftBarSpace:(CGFloat)space
                               animated:(BOOL)animated;

- (UIBarButtonItem*)glb_addRightBarSpace:(CGFloat)space
                                animated:(BOOL)animated;

- (UIButton*)glb_addLeftBarButtonNormalImage:(UIImage*)normalImage
                                      target:(id)target
                                      action:(SEL)action
                                    animated:(BOOL)animated;

- (UIButton*)glb_addLeftBarButtonNormalImage:(UIImage*)normalImage
                            highlightedImage:(UIImage*)highlightedImage
                                      target:(id)target
                                      action:(SEL)action
                                    animated:(BOOL)animated;

- (UIButton*)glb_addLeftBarButtonNormalImage:(UIImage*)normalImage
                            highlightedImage:(UIImage*)highlightedImage
                               disabledImage:(UIImage*)disabledImage
                                      target:(id)target
                                      action:(SEL)action
                                    animated:(BOOL)animated;

- (UIButton*)glb_addLeftBarButtonNormalImage:(UIImage*)normalImage
                            highlightedImage:(UIImage*)highlightedImage
                               selectedImage:(UIImage*)selectedImage
                               disabledImage:(UIImage*)disabledImage
                                      target:(id)target
                                      action:(SEL)action
                                    animated:(BOOL)animated;

- (UIButton*)glb_addRightBarButtonNormalImage:(UIImage*)normalImage
                                       target:(id)target
                                       action:(SEL)action
                                     animated:(BOOL)animated;

- (UIButton*)glb_addRightBarButtonNormalImage:(UIImage*)normalImage
                             highlightedImage:(UIImage*)highlightedImage
                                       target:(id)target
                                       action:(SEL)action
                                     animated:(BOOL)animated;

- (UIButton*)glb_addRightBarButtonNormalImage:(UIImage*)normalImage
                             highlightedImage:(UIImage*)highlightedImage
                                disabledImage:(UIImage*)disabledImage
                                       target:(id)target
                                       action:(SEL)action
                                     animated:(BOOL)animated;

- (UIButton*)glb_addRightBarButtonNormalImage:(UIImage*)normalImage
                             highlightedImage:(UIImage*)highlightedImage
                                selectedImage:(UIImage*)selectedImage
                                disabledImage:(UIImage*)disabledImage
                                       target:(id)target
                                       action:(SEL)action
                                     animated:(BOOL)animated;

- (UIButton*)glb_addLeftBarButtonNormalTitle:(NSString*)normalTitle
                                      target:(id)target
                                      action:(SEL)action
                                    animated:(BOOL)animated;

- (UIButton*)glb_addLeftBarButtonNormalTitle:(NSString*)normalTitle
                            normalTitleColor:(UIColor*)normalTitleColor
                                      target:(id)target
                                      action:(SEL)action
                                    animated:(BOOL)animated;

- (UIButton*)glb_addLeftBarButtonNormalTitle:(NSString*)normalTitle
                            normalTitleColor:(UIColor*)normalTitleColor
                                        font:(UIFont*)font
                                      target:(id)target
                                      action:(SEL)action
                                    animated:(BOOL)animated;

- (UIButton*)glb_addLeftBarButtonNormalTitle:(NSString*)normalTitle
                            normalTitleColor:(UIColor*)normalTitleColor
                                        font:(UIFont*)font
                                       frame:(CGRect)frame
                                      target:(id)target
                                      action:(SEL)action
                                    animated:(BOOL)animated;

- (UIButton*)glb_addLeftBarButtonNormalTitle:(NSString*)normalTitle
                            highlightedTitle:(NSString*)highlightedTitle
                                      target:(id)target
                                      action:(SEL)action
                                    animated:(BOOL)animated;

- (UIButton*)glb_addLeftBarButtonNormalTitle:(NSString*)normalTitle
                            highlightedTitle:(NSString*)highlightedTitle
                               disabledTitle:(NSString*)disabledTitle
                                      target:(id)target
                                      action:(SEL)action
                                    animated:(BOOL)animated;

- (UIButton*)glb_addLeftBarButtonNormalTitle:(NSString*)normalTitle
                            highlightedTitle:(NSString*)highlightedTitle
                               selectedTitle:(NSString*)selectedTitle
                               disabledTitle:(NSString*)disabledTitle
                                      target:(id)target
                                      action:(SEL)action
                                    animated:(BOOL)animated;

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
                                    animated:(BOOL)animated;

- (UIButton*)glb_addRightBarButtonNormalTitle:(NSString*)normalTitle
                                       target:(id)target
                                       action:(SEL)action
                                     animated:(BOOL)animated;

- (UIButton*)glb_addRightBarButtonNormalTitle:(NSString*)normalTitle
                             normalTitleColor:(UIColor*)normalTitleColor
                                       target:(id)target
                                       action:(SEL)action
                                     animated:(BOOL)animated;

- (UIButton*)glb_addRightBarButtonNormalTitle:(NSString*)normalTitle
                             normalTitleColor:(UIColor*)normalTitleColor
                                         font:(UIFont*)font
                                       target:(id)target
                                       action:(SEL)action
                                     animated:(BOOL)animated;

- (UIButton*)glb_addRightBarButtonNormalTitle:(NSString*)normalTitle
                             normalTitleColor:(UIColor*)normalTitleColor
                                         font:(UIFont*)font
                                        frame:(CGRect)frame
                                       target:(id)target
                                       action:(SEL)action
                                     animated:(BOOL)animated;

- (UIButton*)glb_addRightBarButtonNormalTitle:(NSString*)normalTitle
                             highlightedTitle:(NSString*)highlightedTitle
                                       target:(id)target
                                       action:(SEL)action
                                     animated:(BOOL)animated;

- (UIButton*)glb_addRightBarButtonNormalTitle:(NSString*)normalTitle
                             highlightedTitle:(NSString*)highlightedTitle
                                disabledTitle:(NSString*)disabledTitle
                                       target:(id)target
                                       action:(SEL)action
                                     animated:(BOOL)animated;

- (UIButton*)glb_addRightBarButtonNormalTitle:(NSString*)normalTitle
                             highlightedTitle:(NSString*)highlightedTitle
                                selectedTitle:(NSString*)selectedTitle
                                disabledTitle:(NSString*)disabledTitle
                                       target:(id)target
                                       action:(SEL)action
                                     animated:(BOOL)animated;

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
                                     animated:(BOOL)animated;

- (UIBarButtonItem*)glb_addLeftBarView:(UIView*)view
                              animated:(BOOL)animated;

- (UIBarButtonItem*)glb_addLeftBarView:(UIView*)view
                                target:(id)target
                                action:(SEL)action
                              animated:(BOOL)animated;

- (UIBarButtonItem*)glb_addRightBarView:(UIView*)view
                               animated:(BOOL)animated;

- (UIBarButtonItem*)glb_addRightBarView:(UIView*)view
                                 target:(id)target
                                 action:(SEL)action
                               animated:(BOOL)animated;

- (void)glb_addLeftBarButtonItem:(UIBarButtonItem*)barButtonItem
                        animated:(BOOL)animated;

- (void)glb_addRightBarButtonItem:(UIBarButtonItem*)barButtonItem
                         animated:(BOOL)animated;

- (void)glb_removeLeftBarButtonItem:(UIBarButtonItem*)barButtonItem
                           animated:(BOOL)animated;

- (void)glb_removeRightBarButtonItem:(UIBarButtonItem*)barButtonItem
                            animated:(BOOL)animated;

- (void)glb_removeAllLeftBarButtonItemsAnimated:(BOOL)animated;
- (void)glb_removeAllRightBarButtonItemsAnimated:(BOOL)animated;

- (void)glb_setLeftBarAutomaticAlignmentAnimated:(BOOL)animated;
- (void)glb_setRightBarAutomaticAlignmentAnimated:(BOOL)animated;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
