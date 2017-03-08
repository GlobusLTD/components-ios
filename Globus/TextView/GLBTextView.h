/*--------------------------------------------------*/

#import "UIResponder+GLBUI.h"
#import "UIView+GLBUI.h"

/*--------------------------------------------------*/

#import "GLBAction.h"
#import "GLBTextStyle.h"

/*--------------------------------------------------*/

#import "GLBInputForm.h"
#import "GLBInputField.h"
#import "GLBInputValidator.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBTextView : UITextView< GLBInputField, UITextViewDelegate >

@property(nonatomic, readonly, getter=isEditing) BOOL editing;
@property(nonatomic) IBInspectable NSUInteger maximumNumberOfCharecters;
@property(nonatomic) IBInspectable NSUInteger maximumNumberOfLines;

@property(nonatomic) IBInspectable CGFloat minimumHeight;
@property(nonatomic) IBInspectable CGFloat maximumHeight;
@property(nonatomic, nullable, weak) IBOutlet NSLayoutConstraint* constraintHeight;

@property(nonatomic, nullable, copy) IBInspectable NSString* placeholder;
@property(nonatomic, nullable, copy) IBInspectable NSAttributedString* attributedPlaceholder;
@property(nonatomic, nullable, strong) IBInspectable UIFont* placeholderFont;
@property(nonatomic, nullable, strong) IBInspectable UIColor* placeholderColor;
@property(nonatomic, nullable, strong) GLBTextStyle* placeholderStyle;

@property(nonatomic) IBInspectable BOOL hiddenToolbar;
@property(nonatomic) IBInspectable BOOL hiddenToolbarArrows;
@property(nonatomic) IBInspectable CGFloat toolbarHeight;
@property(nonatomic, nullable, strong) UIToolbar* toolbar;
@property(nonatomic, nullable, strong) UIBarButtonItem* prevButton;
@property(nonatomic, nullable, strong) UIBarButtonItem* nextButton;
@property(nonatomic, nullable, strong) UIBarButtonItem* flexButton;
@property(nonatomic, nullable, strong) UIBarButtonItem* doneButton;

@property(nonatomic, nullable, strong) GLBAction* actionBeginEditing;
@property(nonatomic, nullable, strong) GLBAction* actionEndEditing;
@property(nonatomic, nullable, strong) GLBAction* actionValueChanged;
@property(nonatomic, nullable, strong) GLBAction* actionHeightChanged;

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
