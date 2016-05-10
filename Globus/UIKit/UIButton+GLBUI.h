/*--------------------------------------------------*/

#import "UIView+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface UIButton (GLB_UI)

@property(nonatomic, strong, nullable) NSString* glb_normalTitle;
@property(nonatomic, strong, nullable) UIColor* glb_normalTitleColor;
@property(nonatomic, strong, nullable) UIColor* glb_normalTitleShadowColor;
@property(nonatomic, strong, nullable) UIImage* glb_normalImage;
@property(nonatomic, strong, nullable) UIImage* glb_normalBackgroundImage;

@property(nonatomic, strong, nullable) NSString* glb_highlightedTitle;
@property(nonatomic, strong, nullable) UIColor* glb_highlightedTitleColor;
@property(nonatomic, strong, nullable) UIColor* glb_highlightedTitleShadowColor;
@property(nonatomic, strong, nullable) UIImage* glb_highlightedImage;
@property(nonatomic, strong, nullable) UIImage* glb_highlightedBackgroundImage;

@property(nonatomic, strong, nullable) NSString* glb_selectedTitle;
@property(nonatomic, strong, nullable) UIColor* glb_selectedTitleColor;
@property(nonatomic, strong, nullable) UIColor* glb_selectedTitleShadowColor;
@property(nonatomic, strong, nullable) UIImage* glb_selectedImage;
@property(nonatomic, strong, nullable) UIImage* glb_selectedBackgroundImage;

@property(nonatomic, strong, nullable) NSString* glb_disabledTitle;
@property(nonatomic, strong, nullable) UIColor* glb_disabledTitleColor;
@property(nonatomic, strong, nullable) UIColor* glb_disabledTitleShadowColor;
@property(nonatomic, strong, nullable) UIImage* glb_disabledImage;
@property(nonatomic, strong, nullable) UIImage* glb_disabledBackgroundImage;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
