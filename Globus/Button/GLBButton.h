/*--------------------------------------------------*/

#import "UIButton+GLBUI.h"
#import "UIColor+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

typedef NS_ENUM(NSInteger, GLBButtonImageAlignment) {
    GLBButtonImageAlignmentLeft,
    GLBButtonImageAlignmentRight,
    GLBButtonImageAlignmentTop,
    GLBButtonImageAlignmentBottom
};

typedef NS_ENUM(NSInteger, GLBButtonBadgeAlias) {
    GLBButtonBadgeAliasTitle,
    GLBButtonBadgeAliasImage,
    GLBButtonBadgeAliasContent
};

typedef NS_ENUM(NSInteger, GLBButtonBadgeHorizontalAlignment) {
    GLBButtonBadgeHorizontalAlignmentLeft,
    GLBButtonBadgeHorizontalAlignmentCenter,
    GLBButtonBadgeHorizontalAlignmentRight
};

typedef NS_ENUM(NSInteger, GLBButtonBadgeVerticalAlignment) {
    GLBButtonBadgeVerticalAlignmentTop,
    GLBButtonBadgeVerticalAlignmentCenter,
    GLBButtonBadgeVerticalAlignmentBottom
};

/*--------------------------------------------------*/

@class GLBBadgeView;

/*--------------------------------------------------*/

@interface GLBButton : UIButton

@property(nonatomic) IBInspectable GLBButtonImageAlignment imageAlignment;

@property(nonatomic, strong) IBInspectable UIColor* normalBackgroundColor;
@property(nonatomic, strong) IBInspectable UIColor* selectedBackgroundColor;
@property(nonatomic, strong) IBInspectable UIColor* highlightedBackgroundColor;
@property(nonatomic, strong) IBInspectable UIColor* disabledBackgroundColor;
@property(nonatomic, readonly, strong) UIColor* currentBackgroundColor;

@property(nonatomic, strong) IBInspectable UIColor* normalBorderColor;
@property(nonatomic, strong) IBInspectable UIColor* selectedBorderColor;
@property(nonatomic, strong) IBInspectable UIColor* highlightedBorderColor;
@property(nonatomic, strong) IBInspectable UIColor* disabledBorderColor;
@property(nonatomic, readonly, strong) UIColor* currentBorderColor;

@property(nonatomic) IBInspectable CGFloat normalBorderWidth;
@property(nonatomic) IBInspectable CGFloat selectedBorderWidth;
@property(nonatomic) IBInspectable CGFloat highlightedBorderWidth;
@property(nonatomic) IBInspectable CGFloat disabledBorderWidth;
@property(nonatomic, readonly, assign) CGFloat currentBorderWidth;

@property(nonatomic) IBInspectable CGFloat normalCornerRadius;
@property(nonatomic) IBInspectable CGFloat selectedCornerRadius;
@property(nonatomic) IBInspectable CGFloat highlightedCornerRadius;
@property(nonatomic) IBInspectable CGFloat disabledCornerRadius;
@property(nonatomic, readonly, assign) CGFloat currentCornerRadius;

@property(nonatomic, readonly, strong) GLBBadgeView* badgeView;
@property(nonatomic) IBInspectable GLBButtonBadgeAlias badgeAlias;
@property(nonatomic) IBInspectable GLBButtonBadgeHorizontalAlignment badgeHorizontalAlignment;
@property(nonatomic) IBInspectable GLBButtonBadgeVerticalAlignment badgeVerticalAlignment;

- (void)setup NS_REQUIRES_SUPER;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
