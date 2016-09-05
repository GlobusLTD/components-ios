/*--------------------------------------------------*/

#import "GLBTextField.h"
#import "GLBButton.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@protocol GLBSearchBarDelegate;

/*--------------------------------------------------*/

@interface GLBSearchBar : UIView

@property(nonatomic, weak) IBOutlet id< GLBSearchBarDelegate > delegate;
@property(nonatomic, getter=isSearching) IBInspectable BOOL searching;
@property(nonatomic, getter=isEditing) BOOL editing;
@property(nonatomic) IBInspectable CGFloat minimalHeight;
@property(nonatomic) IBInspectable UIEdgeInsets margin;
@property(nonatomic) IBInspectable CGFloat spacing;
@property(nonatomic, strong) IBInspectable UIColor* separatorColor;
@property(nonatomic) IBInspectable BOOL alwaysShowCancelButton;
@property(nonatomic, readonly, weak) UIView* separatorView;
@property(nonatomic, readonly, weak) IBOutlet GLBTextField* searchField;
@property(nonatomic) BOOL showCancelButton;
@property(nonatomic, readonly, weak) IBOutlet GLBButton* cancelButton;

@property(nonatomic, getter = isBlurEnabled) IBInspectable BOOL blurEnabled GLB_DEPRECATED;
@property(nonatomic) IBInspectable CGFloat blurRadius GLB_DEPRECATED;
@property(nonatomic) IBInspectable NSUInteger blurIterations GLB_DEPRECATED;
@property(nonatomic, getter = isDynamic) IBInspectable BOOL dynamic GLB_DEPRECATED;
@property(nonatomic) IBInspectable NSTimeInterval updateInterval GLB_DEPRECATED;
@property(nonatomic, weak) IBOutlet UIView* underlyingView GLB_DEPRECATED;

- (void)setup NS_REQUIRES_SUPER;

- (void)setSearching:(BOOL)searching animated:(BOOL)animated complete:(GLBSimpleBlock)complete;
- (void)setEditing:(BOOL)editing animated:(BOOL)animated complete:(GLBSimpleBlock)complete;

@end

/*--------------------------------------------------*/

@protocol GLBSearchBarDelegate < NSObject >

@optional
- (void)searchBarBeginSearch:(GLBSearchBar*)searchBar;
- (void)searchBarEndSearch:(GLBSearchBar*)searchBar;

- (void)searchBarBeginEditing:(GLBSearchBar*)searchBar;
- (void)searchBar:(GLBSearchBar*)searchBar textChanged:(NSString*)textChanged;
- (void)searchBarEndEditing:(GLBSearchBar*)searchBar;

- (void)searchBarPressedClear:(GLBSearchBar*)searchBar;
- (void)searchBarPressedReturn:(GLBSearchBar*)searchBar;
- (void)searchBarPressedCancel:(GLBSearchBar*)searchBar;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
