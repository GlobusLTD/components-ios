/*--------------------------------------------------*/

#import "UIResponder+GLBUI.h"
#import "UIView+GLBUI.h"

/*--------------------------------------------------*/

#import "GLBInputForm.h"
#import "GLBInputField.h"
#import "GLBInputValidator.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBTextView : UITextView< GLBInputField >

@property(nonatomic, readonly, assign, getter=isEditing) BOOL editing;

@property(nonatomic, nullable, copy) IBInspectable NSString* placeholder;
@property(nonatomic, nullable, copy) IBInspectable NSAttributedString* attributedPlaceholder;
@property(nonatomic, nullable, strong) IBInspectable UIFont* placeholderFont;
@property(nonatomic, nullable, strong) IBInspectable UIColor* placeholderColor;

@property(nonatomic) IBInspectable BOOL hiddenToolbar;
@property(nonatomic) IBInspectable BOOL hiddenToolbarArrows;
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

- (CGRect)placeholderRectForBounds:(CGRect)bounds;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
