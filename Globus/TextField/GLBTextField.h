/*--------------------------------------------------*/

#import "GLBInputField.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import <UIKit/UIKit.h>

/*--------------------------------------------------*/

@interface GLBTextField : UITextField< GLBInputField >

@property(nonatomic) IBInspectable BOOL hiddenToolbar;
@property(nonatomic) IBInspectable BOOL hiddenToolbarArrows;
@property(nonatomic, strong) UIToolbar* toolbar;
@property(nonatomic, strong) UIBarButtonItem* prevButton;
@property(nonatomic, strong) UIBarButtonItem* nextButton;
@property(nonatomic, strong) UIBarButtonItem* flexButton;
@property(nonatomic, strong) UIBarButtonItem* doneButton;

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
