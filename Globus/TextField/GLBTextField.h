/*--------------------------------------------------*/

#import "UIResponder+GLBUI.h"
#import "UIView+GLBUI.h"

/*--------------------------------------------------*/

#import "GLBTextStyle.h"

/*--------------------------------------------------*/

#import "GLBInputForm.h"
#import "GLBInputField.h"
#import "GLBInputValidator.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBTextField : UITextField< GLBInputField >

@property(nonatomic, nullable, strong) GLBTextStyle* textStyle;
@property(nonatomic, nullable, strong) GLBTextStyle* placeholderStyle;
@property(nonatomic) IBInspectable BOOL hiddenToolbar;
@property(nonatomic) IBInspectable BOOL hiddenToolbarArrows;
@property(nonatomic) IBInspectable CGFloat toolbarHeight;
@property(nonatomic, nullable, strong) UIToolbar* toolbar;
@property(nonatomic, nullable, strong) UIBarButtonItem* prevButton;
@property(nonatomic, nullable, strong) UIBarButtonItem* nextButton;
@property(nonatomic, nullable, strong) UIBarButtonItem* flexButton;
@property(nonatomic, nullable, strong) UIBarButtonItem* doneButton;

- (void)setup NS_REQUIRES_SUPER;

- (void)setHiddenToolbar:(BOOL)hiddenToolbar animated:(BOOL)animated;

- (void)didBeginEditing;
- (void)didEndEditing;
- (void)didValueChanged;

- (void)validate;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
