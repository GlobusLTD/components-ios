/*--------------------------------------------------*/

#import "GLBTextField.h"
#import "GLBButton.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@protocol GLBSearchBarDelegate;

/*--------------------------------------------------*/

@interface GLBSearchBar : UIView

@property(nonatomic, nullable, weak) IBOutlet id< GLBSearchBarDelegate > delegate;
@property(nonatomic, getter=isSearching) IBInspectable BOOL searching;
@property(nonatomic, getter=isEditing) BOOL editing;
@property(nonatomic) IBInspectable CGFloat minimalHeight;
@property(nonatomic) IBInspectable UIEdgeInsets margin;
@property(nonatomic) IBInspectable CGFloat spacing;
@property(nonatomic, nullable, strong) IBInspectable UIColor* separatorColor;
@property(nonatomic) IBInspectable BOOL alwaysShowCancelButton;
@property(nonatomic, nullable, readonly, weak) UIView* separatorView;
@property(nonatomic, nullable, readonly, weak) IBOutlet GLBTextField* searchField;
@property(nonatomic) BOOL showCancelButton;
@property(nonatomic, nullable, readonly, weak) IBOutlet GLBButton* cancelButton;

@property(nonatomic, getter = isBlurEnabled) IBInspectable BOOL blurEnabled GLB_DEPRECATED;
@property(nonatomic) IBInspectable CGFloat blurRadius GLB_DEPRECATED;
@property(nonatomic) IBInspectable NSUInteger blurIterations GLB_DEPRECATED;
@property(nonatomic, getter = isDynamic) IBInspectable BOOL dynamic GLB_DEPRECATED;
@property(nonatomic) IBInspectable NSTimeInterval updateInterval GLB_DEPRECATED;
@property(nonatomic, nullable, weak) IBOutlet UIView* underlyingView GLB_DEPRECATED;

- (void)setup NS_REQUIRES_SUPER;

- (void)setSearching:(BOOL)searching animated:(BOOL)animated complete:(GLBSimpleBlock _Nullable)complete;
- (void)setEditing:(BOOL)editing animated:(BOOL)animated complete:(GLBSimpleBlock _Nullable)complete;

@end

/*--------------------------------------------------*/

@protocol GLBSearchBarDelegate < NSObject >

@optional
- (void)searchBarBeginSearch:(GLBSearchBar* _Nonnull)searchBar;
- (void)searchBarEndSearch:(GLBSearchBar* _Nonnull)searchBar;

- (void)searchBarBeginEditing:(GLBSearchBar* _Nonnull)searchBar;
- (void)searchBar:(GLBSearchBar* _Nonnull)searchBar textChanged:(NSString* _Nonnull)textChanged;
- (void)searchBarEndEditing:(GLBSearchBar* _Nonnull)searchBar;

- (void)searchBarPressedClear:(GLBSearchBar* _Nonnull)searchBar;
- (void)searchBarPressedReturn:(GLBSearchBar* _Nonnull)searchBar;
- (void)searchBarPressedCancel:(GLBSearchBar* _Nonnull)searchBar;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
