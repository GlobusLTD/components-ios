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

@property(nonatomic, readonly, assign) CGPoint glb_boundsPosition;
@property(nonatomic, readonly, assign) CGPoint glb_boundsCenter;
@property(nonatomic, readonly, assign) CGSize glb_boundsSize;
@property(nonatomic, readonly, assign) CGFloat glb_boundsCX;
@property(nonatomic, readonly, assign) CGFloat glb_boundsCY;
@property(nonatomic, readonly, assign) CGFloat glb_boundsWidth;
@property(nonatomic, readonly, assign) CGFloat glb_boundsHeight;

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

- (NSLayoutConstraint*)glb_addConstraintAttribute:(NSLayoutAttribute)constraintAttribute relation:(NSLayoutRelation)relation view:(id)view attribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant;
- (NSLayoutConstraint*)glb_addConstraintAttribute:(NSLayoutAttribute)constraintAttribute relation:(NSLayoutRelation)relation view:(id)view attribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant priority:(UILayoutPriority)priority;
- (NSLayoutConstraint*)glb_addConstraintAttribute:(NSLayoutAttribute)constraintAttribute relation:(NSLayoutRelation)relation view:(id)view attribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant priority:(UILayoutPriority)priority multiplier:(CGFloat)multiplier;

- (NSLayoutConstraint*)glb_addConstraintFirstBaseline:(CGFloat)offset NS_ENUM_AVAILABLE_IOS(8_0);
- (NSLayoutConstraint*)glb_addConstraintFirstBaseline:(CGFloat)offset relation:(NSLayoutRelation)relation NS_ENUM_AVAILABLE_IOS(8_0);
- (NSLayoutConstraint*)glb_addConstraintFirstBaseline:(CGFloat)offset topView:(UIView*)topView NS_ENUM_AVAILABLE_IOS(8_0);
- (NSLayoutConstraint*)glb_addConstraintFirstBaseline:(CGFloat)offset relation:(NSLayoutRelation)relation topView:(UIView*)topView NS_ENUM_AVAILABLE_IOS(8_0);
- (NSLayoutConstraint*)glb_addConstraintFirstBaseline:(CGFloat)offset centerView:(UIView*)centerView NS_ENUM_AVAILABLE_IOS(8_0);
- (NSLayoutConstraint*)glb_addConstraintFirstBaseline:(CGFloat)offset relation:(NSLayoutRelation)relation centerView:(UIView*)centerView NS_ENUM_AVAILABLE_IOS(8_0);
- (NSLayoutConstraint*)glb_addConstraintFirstBaseline:(CGFloat)offset bottomView:(UIView*)bottomView NS_ENUM_AVAILABLE_IOS(8_0);
- (NSLayoutConstraint*)glb_addConstraintFirstBaseline:(CGFloat)offset relation:(NSLayoutRelation)relation bottomView:(UIView*)bottomView NS_ENUM_AVAILABLE_IOS(8_0);

- (NSLayoutConstraint*)glb_addConstraintLastBaseline:(CGFloat)offset;
- (NSLayoutConstraint*)glb_addConstraintLastBaseline:(CGFloat)offset relation:(NSLayoutRelation)relation;
- (NSLayoutConstraint*)glb_addConstraintLastBaseline:(CGFloat)offset topView:(UIView*)topView;
- (NSLayoutConstraint*)glb_addConstraintLastBaseline:(CGFloat)offset relation:(NSLayoutRelation)relation topView:(UIView*)topView;
- (NSLayoutConstraint*)glb_addConstraintLastBaseline:(CGFloat)offset centerView:(UIView*)centerView;
- (NSLayoutConstraint*)glb_addConstraintLastBaseline:(CGFloat)offset relation:(NSLayoutRelation)relation centerView:(UIView*)centerView;
- (NSLayoutConstraint*)glb_addConstraintLastBaseline:(CGFloat)offset bottomView:(UIView*)bottomView;
- (NSLayoutConstraint*)glb_addConstraintLastBaseline:(CGFloat)offset relation:(NSLayoutRelation)relation bottomView:(UIView*)bottomView;

- (NSLayoutConstraint*)glb_addConstraintTop:(CGFloat)offset;
- (NSLayoutConstraint*)glb_addConstraintTop:(CGFloat)offset relation:(NSLayoutRelation)relation;
- (NSLayoutConstraint*)glb_addConstraintTop:(CGFloat)offset topView:(UIView*)topView;
- (NSLayoutConstraint*)glb_addConstraintTop:(CGFloat)offset relation:(NSLayoutRelation)relation topView:(UIView*)topView;
- (NSLayoutConstraint*)glb_addConstraintTop:(CGFloat)offset centerView:(UIView*)centerView;
- (NSLayoutConstraint*)glb_addConstraintTop:(CGFloat)offset relation:(NSLayoutRelation)relation centerView:(UIView*)centerView;
- (NSLayoutConstraint*)glb_addConstraintTop:(CGFloat)offset bottomView:(UIView*)bottomView;
- (NSLayoutConstraint*)glb_addConstraintTop:(CGFloat)offset relation:(NSLayoutRelation)relation bottomView:(UIView*)bottomView;

- (NSLayoutConstraint*)glb_addConstraintRight:(CGFloat)offset;
- (NSLayoutConstraint*)glb_addConstraintRight:(CGFloat)offset relation:(NSLayoutRelation)relation;
- (NSLayoutConstraint*)glb_addConstraintRight:(CGFloat)offset leftView:(UIView*)leftView;
- (NSLayoutConstraint*)glb_addConstraintRight:(CGFloat)offset relation:(NSLayoutRelation)relation leftView:(UIView*)leftView;
- (NSLayoutConstraint*)glb_addConstraintRight:(CGFloat)offset centerView:(UIView*)centerView;
- (NSLayoutConstraint*)glb_addConstraintRight:(CGFloat)offset relation:(NSLayoutRelation)relation centerView:(UIView*)centerView;
- (NSLayoutConstraint*)glb_addConstraintRight:(CGFloat)offset rightView:(UIView*)rightView;
- (NSLayoutConstraint*)glb_addConstraintRight:(CGFloat)offset relation:(NSLayoutRelation)relation rightView:(UIView*)rightView;

- (NSLayoutConstraint*)glb_addConstraintBottom:(CGFloat)offset;
- (NSLayoutConstraint*)glb_addConstraintBottom:(CGFloat)offset relation:(NSLayoutRelation)relation;
- (NSLayoutConstraint*)glb_addConstraintBottom:(CGFloat)offset bottomView:(UIView*)bottomView;
- (NSLayoutConstraint*)glb_addConstraintBottom:(CGFloat)offset relation:(NSLayoutRelation)relation bottomView:(UIView*)bottomView;
- (NSLayoutConstraint*)glb_addConstraintBottom:(CGFloat)offset centerView:(UIView*)centerView;
- (NSLayoutConstraint*)glb_addConstraintBottom:(CGFloat)offset relation:(NSLayoutRelation)relation centerView:(UIView*)centerView;
- (NSLayoutConstraint*)glb_addConstraintBottom:(CGFloat)offset topView:(UIView*)topView;
- (NSLayoutConstraint*)glb_addConstraintBottom:(CGFloat)offset relation:(NSLayoutRelation)relation topView:(UIView*)topView;

- (NSLayoutConstraint*)glb_addConstraintLeft:(CGFloat)offset;
- (NSLayoutConstraint*)glb_addConstraintLeft:(CGFloat)offset relation:(NSLayoutRelation)relation;
- (NSLayoutConstraint*)glb_addConstraintLeft:(CGFloat)offset rightView:(UIView*)rightView;
- (NSLayoutConstraint*)glb_addConstraintLeft:(CGFloat)offset relation:(NSLayoutRelation)relation rightView:(UIView*)rightView;
- (NSLayoutConstraint*)glb_addConstraintLeft:(CGFloat)offset centerView:(UIView*)centerView;
- (NSLayoutConstraint*)glb_addConstraintLeft:(CGFloat)offset relation:(NSLayoutRelation)relation centerView:(UIView*)centerView;
- (NSLayoutConstraint*)glb_addConstraintLeft:(CGFloat)offset leftView:(UIView*)leftView;
- (NSLayoutConstraint*)glb_addConstraintLeft:(CGFloat)offset relation:(NSLayoutRelation)relation leftView:(UIView*)leftView;

- (NSLayoutConstraint*)glb_addConstraintVertical:(CGFloat)offset;
- (NSLayoutConstraint*)glb_addConstraintVertical:(CGFloat)offset relation:(NSLayoutRelation)relation;
- (NSLayoutConstraint*)glb_addConstraintVertical:(CGFloat)offset topView:(UIView*)topView;
- (NSLayoutConstraint*)glb_addConstraintVertical:(CGFloat)offset relation:(NSLayoutRelation)relation topView:(UIView*)topView;
- (NSLayoutConstraint*)glb_addConstraintVertical:(CGFloat)offset centerView:(UIView*)centerView;
- (NSLayoutConstraint*)glb_addConstraintVertical:(CGFloat)offset relation:(NSLayoutRelation)relation centerView:(UIView*)centerView;
- (NSLayoutConstraint*)glb_addConstraintVertical:(CGFloat)offset bottomView:(UIView*)bottomView;
- (NSLayoutConstraint*)glb_addConstraintVertical:(CGFloat)offset relation:(NSLayoutRelation)relation bottomView:(UIView*)bottomView;

- (NSLayoutConstraint*)glb_addConstraintHorizontal:(CGFloat)offset;
- (NSLayoutConstraint*)glb_addConstraintHorizontal:(CGFloat)offset relation:(NSLayoutRelation)relation;
- (NSLayoutConstraint*)glb_addConstraintHorizontal:(CGFloat)offset rightView:(UIView*)rightView;
- (NSLayoutConstraint*)glb_addConstraintHorizontal:(CGFloat)offset relation:(NSLayoutRelation)relation rightView:(UIView*)rightView;
- (NSLayoutConstraint*)glb_addConstraintHorizontal:(CGFloat)offset centerView:(UIView*)centerView;
- (NSLayoutConstraint*)glb_addConstraintHorizontal:(CGFloat)offset relation:(NSLayoutRelation)relation centerView:(UIView*)centerView;
- (NSLayoutConstraint*)glb_addConstraintHorizontal:(CGFloat)offset leftView:(UIView*)leftView;
- (NSLayoutConstraint*)glb_addConstraintHorizontal:(CGFloat)offset relation:(NSLayoutRelation)relation leftView:(UIView*)leftView;

- (NSLayoutConstraint*)glb_addConstraintWidth:(CGFloat)width;
- (NSLayoutConstraint*)glb_addConstraintWidth:(CGFloat)width relation:(NSLayoutRelation)relation;
- (NSLayoutConstraint*)glb_addConstraintWidthView:(UIView*)view;
- (NSLayoutConstraint*)glb_addConstraintWidth:(CGFloat)width view:(UIView*)view;
- (NSLayoutConstraint*)glb_addConstraintWidth:(CGFloat)width relation:(NSLayoutRelation)relation view:(UIView*)view;

- (NSLayoutConstraint*)glb_addConstraintHeight:(CGFloat)height;
- (NSLayoutConstraint*)glb_addConstraintHeight:(CGFloat)height relation:(NSLayoutRelation)relation;
- (NSLayoutConstraint*)glb_addConstraintHeightView:(UIView*)view;
- (NSLayoutConstraint*)glb_addConstraintHeight:(CGFloat)height view:(UIView*)view;
- (NSLayoutConstraint*)glb_addConstraintHeight:(CGFloat)height relation:(NSLayoutRelation)relation view:(UIView*)view;

- (NSArray< NSLayoutConstraint* >*)glb_addConstraintCenter;
- (NSArray< NSLayoutConstraint* >*)glb_addConstraintCenterRelation:(NSLayoutRelation)relation;
- (NSArray< NSLayoutConstraint* >*)glb_addConstraintCenter:(UIOffset)offset;
- (NSArray< NSLayoutConstraint* >*)glb_addConstraintCenter:(UIOffset)offset relation:(NSLayoutRelation)relation;
- (NSArray< NSLayoutConstraint* >*)glb_addConstraintCenter:(UIOffset)offset view:(UIView*)view;
- (NSArray< NSLayoutConstraint* >*)glb_addConstraintCenter:(UIOffset)offset relation:(NSLayoutRelation)relation view:(UIView*)view;

- (NSArray< NSLayoutConstraint* >*)glb_addConstraintEdgeInsets;
- (NSArray< NSLayoutConstraint* >*)glb_addConstraintEdgeInsetsRelation:(NSLayoutRelation)relation;
- (NSArray< NSLayoutConstraint* >*)glb_addConstraintEdgeInsets:(UIEdgeInsets)edgeInsets;
- (NSArray< NSLayoutConstraint* >*)glb_addConstraintEdgeInsets:(UIEdgeInsets)edgeInsets relation:(NSLayoutRelation)relation;
- (NSArray< NSLayoutConstraint* >*)glb_addConstraintEdgeInsets:(UIEdgeInsets)edgeInsets view:(UIView*)view;
- (NSArray< NSLayoutConstraint* >*)glb_addConstraintEdgeInsets:(UIEdgeInsets)edgeInsets relation:(NSLayoutRelation)relation view:(UIView*)view;

- (void)glb_removeAllConstraints;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
