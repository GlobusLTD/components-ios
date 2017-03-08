/*--------------------------------------------------*/

#import "GLBTextField.h"
#import "GLBButton.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@protocol GLBSearchBarDelegate;

@class GLBSearchBarTextField;

/*--------------------------------------------------*/

@interface GLBSearchBar : UIView

@property(nonatomic, nullable, weak) IBOutlet id< GLBSearchBarDelegate > delegate;
@property(nonatomic, getter=isSearching) IBInspectable BOOL searching;
@property(nonatomic, getter=isEditing) BOOL editing;
@property(nonatomic) IBInspectable UIEdgeInsets margin;
@property(nonatomic) IBInspectable CGFloat spacing;
@property(nonatomic, nullable, strong) IBInspectable UIColor* separatorColor;
@property(nonatomic) IBInspectable BOOL alwaysShowCancelButton;
@property(nonatomic, nullable, readonly, weak) UIView* separatorView;
@property(nonatomic, nullable, readonly, weak) IBOutlet GLBSearchBarTextField* searchField;
@property(nonatomic) BOOL showCancelButton;
@property(nonatomic, nullable, readonly, weak) IBOutlet GLBButton* cancelButton;

@property(nonatomic, getter = isBlurEnabled) IBInspectable BOOL blurEnabled GLB_DEPRECATED;
@property(nonatomic) IBInspectable CGFloat blurRadius GLB_DEPRECATED;
@property(nonatomic) IBInspectable NSUInteger blurIterations GLB_DEPRECATED;
@property(nonatomic, getter = isDynamic) IBInspectable BOOL dynamic GLB_DEPRECATED;
@property(nonatomic) IBInspectable NSTimeInterval updateInterval GLB_DEPRECATED;
@property(nonatomic, nullable, weak) IBOutlet UIView* underlyingView GLB_DEPRECATED;

- (void)setup NS_REQUIRES_SUPER;

- (void)setSearching:(BOOL)searching animated:(BOOL)animated complete:(nullable GLBSimpleBlock)complete;
- (void)setEditing:(BOOL)editing animated:(BOOL)animated complete:(nullable GLBSimpleBlock)complete;

@end

/*--------------------------------------------------*/

@interface GLBSearchBarTextField : GLBTextField
@end

/*--------------------------------------------------*/

@protocol GLBSearchBarDelegate < NSObject >

@optional
- (void)searchBarBeginSearch:(nonnull GLBSearchBar*)searchBar;
- (void)searchBarEndSearch:(nonnull GLBSearchBar*)searchBar;

- (void)searchBarBeginEditing:(nonnull GLBSearchBar*)searchBar;
- (void)searchBar:(nonnull GLBSearchBar*)searchBar textChanged:(nonnull NSString*)textChanged;
- (void)searchBarEndEditing:(nonnull GLBSearchBar*)searchBar;

- (void)searchBarPressedClear:(nonnull GLBSearchBar*)searchBar;
- (void)searchBarPressedReturn:(nonnull GLBSearchBar*)searchBar;
- (void)searchBarPressedCancel:(nonnull GLBSearchBar*)searchBar;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
