/*--------------------------------------------------*/

#include "GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface UIView (GLB_UI)

@property(nonatomic) CGPoint glb_framePosition;
@property(nonatomic) CGPoint glb_frameCenter;
@property(nonatomic) CGSize glb_frameSize;
@property(nonatomic) CGFloat glb_frameSX;
@property(nonatomic) CGFloat glb_frameCX;
@property(nonatomic) CGFloat glb_frameEX;
@property(nonatomic) CGFloat glb_frameSY;
@property(nonatomic) CGFloat glb_frameCY;
@property(nonatomic) CGFloat glb_frameEY;
@property(nonatomic) CGFloat glb_frameWidth;
@property(nonatomic) CGFloat glb_frameHeight;
@property(nonatomic) CGFloat glb_frameLeft;
@property(nonatomic) CGFloat glb_frameRight;
@property(nonatomic) CGFloat glb_frameTop;
@property(nonatomic) CGFloat glb_frameBottom;

@property(nonatomic, readonly) CGPoint glb_boundsPosition;
@property(nonatomic, readonly) CGPoint glb_boundsCenter;
@property(nonatomic, readonly) CGSize glb_boundsSize;
@property(nonatomic, readonly) CGFloat glb_boundsCX;
@property(nonatomic, readonly) CGFloat glb_boundsCY;
@property(nonatomic, readonly) CGFloat glb_boundsWidth;
@property(nonatomic, readonly) CGFloat glb_boundsHeight;

@property(nonatomic) IBInspectable CGFloat glb_ZPosition;
@property(nonatomic) IBInspectable CGFloat glb_cornerRadius;
@property(nonatomic) IBInspectable CGFloat glb_borderWidth;
@property(nonatomic, strong) IBInspectable UIColor* glb_borderColor;
@property(nonatomic, strong) IBInspectable UIColor* glb_shadowColor;
@property(nonatomic) IBInspectable CGFloat glb_shadowOpacity;
@property(nonatomic) IBInspectable CGSize glb_shadowOffset;
@property(nonatomic) IBInspectable CGFloat glb_shadowRadius;
@property(nonatomic, strong) UIBezierPath* glb_shadowPath;

@property(nonatomic) IBInspectable UILayoutPriority glb_horizontalContentHuggingPriority;
@property(nonatomic) IBInspectable UILayoutPriority glb_verticalContentHuggingPriority;
@property(nonatomic) IBInspectable UILayoutPriority glb_horizontalContentCompressionResistancePriority;
@property(nonatomic) IBInspectable UILayoutPriority glb_verticalContentCompressionResistancePriority;

- (NSArray*)glb_responders;

- (BOOL)glb_isContainsSubview:(UIView*)subview;

- (void)glb_removeSubview:(UIView*)subview;

- (void)glb_setSubviews:(NSArray*)subviews;
- (void)glb_removeAllSubviews;

- (void)glb_blinkBackgroundColor:(UIColor*)color duration:(NSTimeInterval)duration timeout:(NSTimeInterval)timeout;

- (NSLayoutConstraint*)glb_addConstraintAttribute:(NSLayoutAttribute)constraintAttribute relation:(NSLayoutRelation)relation constant:(CGFloat)constant;
- (NSLayoutConstraint*)glb_addConstraintAttribute:(NSLayoutAttribute)constraintAttribute relation:(NSLayoutRelation)relation constant:(CGFloat)constant priority:(UILayoutPriority)priority;
- (NSLayoutConstraint*)glb_addConstraintAttribute:(NSLayoutAttribute)constraintAttribute relation:(NSLayoutRelation)relation constant:(CGFloat)constant priority:(UILayoutPriority)priority multiplier:(CGFloat)multiplier;

- (NSLayoutConstraint*)glb_addConstraintAttribute:(NSLayoutAttribute)constraintAttribute relation:(NSLayoutRelation)relation attribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant;
- (NSLayoutConstraint*)glb_addConstraintAttribute:(NSLayoutAttribute)constraintAttribute relation:(NSLayoutRelation)relation attribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant priority:(UILayoutPriority)priority;
- (NSLayoutConstraint*)glb_addConstraintAttribute:(NSLayoutAttribute)constraintAttribute relation:(NSLayoutRelation)relation attribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant priority:(UILayoutPriority)priority multiplier:(CGFloat)multiplier;

- (NSLayoutConstraint*)glb_addConstraintAttribute:(NSLayoutAttribute)constraintAttribute relation:(NSLayoutRelation)relation item:(id)item attribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant;
- (NSLayoutConstraint*)glb_addConstraintAttribute:(NSLayoutAttribute)constraintAttribute relation:(NSLayoutRelation)relation item:(id)item attribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant priority:(UILayoutPriority)priority;
- (NSLayoutConstraint*)glb_addConstraintAttribute:(NSLayoutAttribute)constraintAttribute relation:(NSLayoutRelation)relation item:(id)item attribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant priority:(UILayoutPriority)priority multiplier:(CGFloat)multiplier;

- (NSLayoutConstraint*)glb_addConstraintFirstBaseline:(CGFloat)offset NS_ENUM_AVAILABLE_IOS(8_0);
- (NSLayoutConstraint*)glb_addConstraintFirstBaseline:(CGFloat)offset relation:(NSLayoutRelation)relation NS_ENUM_AVAILABLE_IOS(8_0);
- (NSLayoutConstraint*)glb_addConstraintFirstBaseline:(CGFloat)offset topItem:(id)topItem NS_ENUM_AVAILABLE_IOS(8_0);
- (NSLayoutConstraint*)glb_addConstraintFirstBaseline:(CGFloat)offset relation:(NSLayoutRelation)relation topItem:(id)topItem NS_ENUM_AVAILABLE_IOS(8_0);
- (NSLayoutConstraint*)glb_addConstraintFirstBaseline:(CGFloat)offset centerItem:(id)centerItem NS_ENUM_AVAILABLE_IOS(8_0);
- (NSLayoutConstraint*)glb_addConstraintFirstBaseline:(CGFloat)offset relation:(NSLayoutRelation)relation centerItem:(id)centerItem NS_ENUM_AVAILABLE_IOS(8_0);
- (NSLayoutConstraint*)glb_addConstraintFirstBaseline:(CGFloat)offset bottomItem:(id)bottomItem NS_ENUM_AVAILABLE_IOS(8_0);
- (NSLayoutConstraint*)glb_addConstraintFirstBaseline:(CGFloat)offset relation:(NSLayoutRelation)relation bottomItem:(id)bottomItem NS_ENUM_AVAILABLE_IOS(8_0);

- (NSLayoutConstraint*)glb_addConstraintLastBaseline:(CGFloat)offset;
- (NSLayoutConstraint*)glb_addConstraintLastBaseline:(CGFloat)offset relation:(NSLayoutRelation)relation;
- (NSLayoutConstraint*)glb_addConstraintLastBaseline:(CGFloat)offset topItem:(id)topItem;
- (NSLayoutConstraint*)glb_addConstraintLastBaseline:(CGFloat)offset relation:(NSLayoutRelation)relation topItem:(id)topItem;
- (NSLayoutConstraint*)glb_addConstraintLastBaseline:(CGFloat)offset centerItem:(id)centerItem;
- (NSLayoutConstraint*)glb_addConstraintLastBaseline:(CGFloat)offset relation:(NSLayoutRelation)relation centerItem:(id)centerItem;
- (NSLayoutConstraint*)glb_addConstraintLastBaseline:(CGFloat)offset bottomItem:(id)bottomItem;
- (NSLayoutConstraint*)glb_addConstraintLastBaseline:(CGFloat)offset relation:(NSLayoutRelation)relation bottomItem:(id)bottomItem;

- (NSLayoutConstraint*)glb_addConstraintTop:(CGFloat)offset;
- (NSLayoutConstraint*)glb_addConstraintTop:(CGFloat)offset relation:(NSLayoutRelation)relation;
- (NSLayoutConstraint*)glb_addConstraintTop:(CGFloat)offset topItem:(id)topItem;
- (NSLayoutConstraint*)glb_addConstraintTop:(CGFloat)offset relation:(NSLayoutRelation)relation topItem:(id)topItem;
- (NSLayoutConstraint*)glb_addConstraintTop:(CGFloat)offset centerItem:(id)centerItem;
- (NSLayoutConstraint*)glb_addConstraintTop:(CGFloat)offset relation:(NSLayoutRelation)relation centerItem:(id)centerItem;
- (NSLayoutConstraint*)glb_addConstraintTop:(CGFloat)offset bottomItem:(id)bottomItem;
- (NSLayoutConstraint*)glb_addConstraintTop:(CGFloat)offset relation:(NSLayoutRelation)relation bottomItem:(id)bottomItem;

- (NSLayoutConstraint*)glb_addConstraintRight:(CGFloat)offset;
- (NSLayoutConstraint*)glb_addConstraintRight:(CGFloat)offset relation:(NSLayoutRelation)relation;
- (NSLayoutConstraint*)glb_addConstraintRight:(CGFloat)offset leftItem:(id)leftItem;
- (NSLayoutConstraint*)glb_addConstraintRight:(CGFloat)offset relation:(NSLayoutRelation)relation leftItem:(id)leftItem;
- (NSLayoutConstraint*)glb_addConstraintRight:(CGFloat)offset centerItem:(id)centerItem;
- (NSLayoutConstraint*)glb_addConstraintRight:(CGFloat)offset relation:(NSLayoutRelation)relation centerItem:(id)centerItem;
- (NSLayoutConstraint*)glb_addConstraintRight:(CGFloat)offset rightItem:(id)lrightItem;
- (NSLayoutConstraint*)glb_addConstraintRight:(CGFloat)offset relation:(NSLayoutRelation)relation rightItem:(id)lrightItem;

- (NSLayoutConstraint*)glb_addConstraintBottom:(CGFloat)offset;
- (NSLayoutConstraint*)glb_addConstraintBottom:(CGFloat)offset relation:(NSLayoutRelation)relation;
- (NSLayoutConstraint*)glb_addConstraintBottom:(CGFloat)offset bottomItem:(id)bottomItem;
- (NSLayoutConstraint*)glb_addConstraintBottom:(CGFloat)offset relation:(NSLayoutRelation)relation bottomItem:(id)bottomItem;
- (NSLayoutConstraint*)glb_addConstraintBottom:(CGFloat)offset centerItem:(id)centerItem;
- (NSLayoutConstraint*)glb_addConstraintBottom:(CGFloat)offset relation:(NSLayoutRelation)relation centerItem:(id)centerItem;
- (NSLayoutConstraint*)glb_addConstraintBottom:(CGFloat)offset topItem:(id)topItem;
- (NSLayoutConstraint*)glb_addConstraintBottom:(CGFloat)offset relation:(NSLayoutRelation)relation topItem:(id)topItem;

- (NSLayoutConstraint*)glb_addConstraintLeft:(CGFloat)offset;
- (NSLayoutConstraint*)glb_addConstraintLeft:(CGFloat)offset relation:(NSLayoutRelation)relation;
- (NSLayoutConstraint*)glb_addConstraintLeft:(CGFloat)offset rightItem:(id)lrightItem;
- (NSLayoutConstraint*)glb_addConstraintLeft:(CGFloat)offset relation:(NSLayoutRelation)relation rightItem:(id)lrightItem;
- (NSLayoutConstraint*)glb_addConstraintLeft:(CGFloat)offset centerItem:(id)centerItem;
- (NSLayoutConstraint*)glb_addConstraintLeft:(CGFloat)offset relation:(NSLayoutRelation)relation centerItem:(id)centerItem;
- (NSLayoutConstraint*)glb_addConstraintLeft:(CGFloat)offset leftItem:(id)leftItem;
- (NSLayoutConstraint*)glb_addConstraintLeft:(CGFloat)offset relation:(NSLayoutRelation)relation leftItem:(id)leftItem;

- (NSLayoutConstraint*)glb_addConstraintVertical:(CGFloat)offset;
- (NSLayoutConstraint*)glb_addConstraintVertical:(CGFloat)offset relation:(NSLayoutRelation)relation;
- (NSLayoutConstraint*)glb_addConstraintVertical:(CGFloat)offset topItem:(id)topItem;
- (NSLayoutConstraint*)glb_addConstraintVertical:(CGFloat)offset relation:(NSLayoutRelation)relation topItem:(id)topItem;
- (NSLayoutConstraint*)glb_addConstraintVertical:(CGFloat)offset centerItem:(id)centerItem;
- (NSLayoutConstraint*)glb_addConstraintVertical:(CGFloat)offset relation:(NSLayoutRelation)relation centerItem:(id)centerItem;
- (NSLayoutConstraint*)glb_addConstraintVertical:(CGFloat)offset bottomItem:(id)bottomItem;
- (NSLayoutConstraint*)glb_addConstraintVertical:(CGFloat)offset relation:(NSLayoutRelation)relation bottomItem:(id)bottomItem;

- (NSLayoutConstraint*)glb_addConstraintHorizontal:(CGFloat)offset;
- (NSLayoutConstraint*)glb_addConstraintHorizontal:(CGFloat)offset relation:(NSLayoutRelation)relation;
- (NSLayoutConstraint*)glb_addConstraintHorizontal:(CGFloat)offset rightItem:(id)lrightItem;
- (NSLayoutConstraint*)glb_addConstraintHorizontal:(CGFloat)offset relation:(NSLayoutRelation)relation rightItem:(id)lrightItem;
- (NSLayoutConstraint*)glb_addConstraintHorizontal:(CGFloat)offset centerItem:(id)centerItem;
- (NSLayoutConstraint*)glb_addConstraintHorizontal:(CGFloat)offset relation:(NSLayoutRelation)relation centerItem:(id)centerItem;
- (NSLayoutConstraint*)glb_addConstraintHorizontal:(CGFloat)offset leftItem:(id)leftItem;
- (NSLayoutConstraint*)glb_addConstraintHorizontal:(CGFloat)offset relation:(NSLayoutRelation)relation leftItem:(id)leftItem;

- (NSLayoutConstraint*)glb_addConstraintWidth:(CGFloat)width;
- (NSLayoutConstraint*)glb_addConstraintWidth:(CGFloat)width relation:(NSLayoutRelation)relation;
- (NSLayoutConstraint*)glb_addConstraintWidthItem:(id)item;
- (NSLayoutConstraint*)glb_addConstraintWidth:(CGFloat)width item:(id)item;
- (NSLayoutConstraint*)glb_addConstraintWidth:(CGFloat)width relation:(NSLayoutRelation)relation item:(id)item;

- (NSLayoutConstraint*)glb_addConstraintHeight:(CGFloat)height;
- (NSLayoutConstraint*)glb_addConstraintHeight:(CGFloat)height relation:(NSLayoutRelation)relation;
- (NSLayoutConstraint*)glb_addConstraintHeightItem:(id)item;
- (NSLayoutConstraint*)glb_addConstraintHeight:(CGFloat)height item:(id)item;
- (NSLayoutConstraint*)glb_addConstraintHeight:(CGFloat)height relation:(NSLayoutRelation)relation item:(id)item;

- (NSArray< NSLayoutConstraint* >*)glb_addConstraintCenter;
- (NSArray< NSLayoutConstraint* >*)glb_addConstraintCenterRelation:(NSLayoutRelation)relation;
- (NSArray< NSLayoutConstraint* >*)glb_addConstraintCenter:(UIOffset)offset;
- (NSArray< NSLayoutConstraint* >*)glb_addConstraintCenter:(UIOffset)offset relation:(NSLayoutRelation)relation;
- (NSArray< NSLayoutConstraint* >*)glb_addConstraintCenter:(UIOffset)offset item:(id)item;
- (NSArray< NSLayoutConstraint* >*)glb_addConstraintCenter:(UIOffset)offset relation:(NSLayoutRelation)relation item:(id)item;

- (NSArray< NSLayoutConstraint* >*)glb_addConstraintEdgeInsets;
- (NSArray< NSLayoutConstraint* >*)glb_addConstraintEdgeInsetsRelation:(NSLayoutRelation)relation;
- (NSArray< NSLayoutConstraint* >*)glb_addConstraintEdgeInsets:(UIEdgeInsets)edgeInsets;
- (NSArray< NSLayoutConstraint* >*)glb_addConstraintEdgeInsets:(UIEdgeInsets)edgeInsets relation:(NSLayoutRelation)relation;
- (NSArray< NSLayoutConstraint* >*)glb_addConstraintEdgeInsets:(UIEdgeInsets)edgeInsets item:(id)item;
- (NSArray< NSLayoutConstraint* >*)glb_addConstraintEdgeInsets:(UIEdgeInsets)edgeInsets relation:(NSLayoutRelation)relation item:(id)item;

- (void)glb_removeAllConstraints;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
