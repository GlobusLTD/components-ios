/*--------------------------------------------------*/

#import "UIView+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface UIButton (GLB_UI)

@property(nonatomic, nullable, strong) NSString* glb_normalTitle;
@property(nonatomic, nullable, strong) NSAttributedString* glb_normalAttributedTitle;
@property(nonatomic, nullable, strong) UIColor* glb_normalTitleColor;
@property(nonatomic, nullable, strong) UIColor* glb_normalTitleShadowColor;
@property(nonatomic, nullable, strong) UIImage* glb_normalImage;
@property(nonatomic, nullable, strong) UIImage* glb_normalBackgroundImage;

@property(nonatomic, nullable, strong) NSString* glb_highlightedTitle;
@property(nonatomic, nullable, strong) NSAttributedString* glb_highlightedAttributedTitle;
@property(nonatomic, nullable, strong) UIColor* glb_highlightedTitleColor;
@property(nonatomic, nullable, strong) UIColor* glb_highlightedTitleShadowColor;
@property(nonatomic, nullable, strong) UIImage* glb_highlightedImage;
@property(nonatomic, nullable, strong) UIImage* glb_highlightedBackgroundImage;

@property(nonatomic, nullable, strong) NSString* glb_selectedTitle;
@property(nonatomic, nullable, strong) NSAttributedString* glb_selectedAttributedTitle;
@property(nonatomic, nullable, strong) UIColor* glb_selectedTitleColor;
@property(nonatomic, nullable, strong) UIColor* glb_selectedTitleShadowColor;
@property(nonatomic, nullable, strong) UIImage* glb_selectedImage;
@property(nonatomic, nullable, strong) UIImage* glb_selectedBackgroundImage;

@property(nonatomic, nullable, strong) NSString* glb_disabledTitle;
@property(nonatomic, nullable, strong) NSAttributedString* glb_disabledAttributedTitle;
@property(nonatomic, nullable, strong) UIColor* glb_disabledTitleColor;
@property(nonatomic, nullable, strong) UIColor* glb_disabledTitleShadowColor;
@property(nonatomic, nullable, strong) UIImage* glb_disabledImage;
@property(nonatomic, nullable, strong) UIImage* glb_disabledBackgroundImage;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
