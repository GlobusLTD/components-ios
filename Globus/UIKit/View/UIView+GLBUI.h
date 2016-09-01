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

- (void)glb_removeAllConstraints;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
