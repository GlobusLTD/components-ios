/*--------------------------------------------------*/

#import "UIView+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation UIView (GLB_UI)

#pragma mark - Property

- (void)setGlb_framePosition:(CGPoint)framePosition {
    CGRect frame = self.frame;
    self.frame = CGRectMake(framePosition.x, framePosition.y, frame.size.width, frame.size.height);
}

- (CGPoint)glb_framePosition {
    return self.frame.origin;
}

- (void)setGlb_frameCenter:(CGPoint)frameCenter {
    CGRect frame = self.frame;
    self.frame = CGRectMake(frameCenter.x - (frame.size.width * 0.5f), frameCenter.y - (frame.size.height * 0.5f), frame.size.width, frame.size.height);
}

- (CGPoint)glb_frameCenter {
    CGRect frame = self.frame;
    return CGPointMake(frame.origin.x + (frame.size.width * 0.5f), frame.origin.y + (frame.size.height * 0.5f));
}

- (void)setGlb_frameSize:(CGSize)frameSize {
    CGRect frame = self.frame;
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, frameSize.width, frameSize.height);
}

- (CGSize)glb_frameSize {
    return self.frame.size;
}

- (void)setGlb_frameSX:(CGFloat)frameSX {
    CGRect frame = self.frame;
    self.frame = CGRectMake(frameSX, frame.origin.y, frame.size.width, frame.size.height);
}

- (CGFloat)glb_frameSX {
    return CGRectGetMinX(self.frame);
}

- (void)setGlb_frameCX:(CGFloat)frameCX {
    CGRect frame = self.frame;
    self.frame = CGRectMake(frameCX - (frame.size.width * 0.5f), frame.origin.y, frame.size.width, frame.size.height);
}

- (CGFloat)glb_frameCX {
    return CGRectGetMidX(self.frame);
}

- (void)setGlb_frameEX:(CGFloat)frameEX {
    CGRect frame = self.frame;
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, frameEX - frame.origin.x, frame.size.height);
}

- (CGFloat)glb_frameEX {
    return CGRectGetMaxX(self.frame);
}

- (void)setGlb_frameSY:(CGFloat)frameSY {
    CGRect frame = self.frame;
    self.frame = CGRectMake(frame.origin.x, frameSY, frame.size.width, frame.size.height);
}

- (CGFloat)glb_frameSY {
    return CGRectGetMinY(self.frame);
}

- (void)setGlb_frameCY:(CGFloat)frameCY {
    CGRect frame = self.frame;
    self.frame = CGRectMake(frame.origin.x, frameCY - (frame.size.height * 0.5f), frame.size.width, frame.size.height);
}

- (CGFloat)glb_frameCY {
    return CGRectGetMidY(self.frame);
}

- (void)setGlb_frameEY:(CGFloat)frameEY {
    CGRect frame = self.frame;
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frameEY - frame.origin.y);
}

- (CGFloat)glb_frameEY {
    return CGRectGetMaxY(self.frame);
}

- (void)setGlb_frameWidth:(CGFloat)frameWidth {
    CGRect frame = self.frame;
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, frameWidth, frame.size.height);
}

- (CGFloat)glb_frameWidth {
    return CGRectGetWidth(self.frame);
}

- (void)setGlb_frameHeight:(CGFloat)frameHeight {
    CGRect frame = self.frame;
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frameHeight);
}

- (CGFloat)glb_frameHeight {
    return CGRectGetHeight(self.frame);
}

- (void)setGlb_frameLeft:(CGFloat)frameLeft {
    CGRect frame = self.frame;
    CGFloat size = frame.size.width - (frameLeft - frame.origin.x);
    self.frame = CGRectMake(frameLeft, frame.origin.y, size, frame.size.height);
}

- (CGFloat)glb_frameLeft {
    return self.frame.origin.x;
}

- (void)setGlb_frameRight:(CGFloat)frameRight {
    CGRect frame = self.frame;
    CGRect bounds = self.superview.bounds;
    CGFloat size = bounds.size.width - (frame.origin.x + frameRight);
    self.frame = CGRectMake(frameRight, frame.origin.y, size, frame.size.height);
}

- (CGFloat)glb_frameRight {
    CGRect frame = self.frame;
    CGRect bounds = self.superview.bounds;
    return bounds.size.width - (frame.origin.x + frame.size.width);
}

- (void)setGlb_frameTop:(CGFloat)frameTop {
    CGRect frame = self.frame;
    CGFloat size = frame.size.height - (frameTop - frame.origin.y);
    self.frame = CGRectMake(frame.origin.x, frameTop, frame.size.width, size);
}

- (CGFloat)glb_frameTop {
    CGRect frame = self.frame;
    return frame.origin.y;
}

- (void)setGlb_frameBottom:(CGFloat)frameBottom {
    CGRect frame = self.frame;
    CGRect bounds = self.superview.bounds;
    CGFloat size = bounds.size.height - (frame.origin.y + frameBottom);
    self.frame = CGRectMake(frame.origin.x, frameBottom, frame.size.width, size);
}

- (CGFloat)glb_frameBottom {
    CGRect frame = self.frame;
    CGRect bounds = self.superview.bounds;
    return bounds.size.height - (frame.origin.y + frame.size.height);
}

- (CGPoint)glb_boundsPosition {
    return self.bounds.origin;
}

- (CGSize)glb_boundsSize {
    return self.bounds.size;
}

- (CGPoint)glb_boundsCenter {
    CGRect bounds = self.bounds;
    return CGPointMake(bounds.origin.x + (bounds.size.width * 0.5f), bounds.origin.y + (bounds.size.height * 0.5f));
}

- (CGFloat)glb_boundsCX {
    return CGRectGetMidX(self.bounds);
}

- (CGFloat)glb_boundsCY {
    return CGRectGetMidY(self.bounds);
}

- (CGFloat)glb_boundsWidth {
    return CGRectGetWidth(self.bounds);
}

- (CGFloat)glb_boundsHeight {
    return CGRectGetHeight(self.bounds);
}

- (void)setGlb_ZPosition:(CGFloat)ZPosition {
    self.layer.zPosition = ZPosition;
}

- (CGFloat)glb_ZPosition {
    return self.layer.zPosition;
}

- (void)setGlb_cornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
}

- (CGFloat)glb_cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setGlb_borderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)glb_borderWidth {
    return self.layer.borderWidth;
}

- (void)setGlb_borderColor:(UIColor*)borderColor {
    if(borderColor != nil) {
        self.layer.borderColor = borderColor.CGColor;
    } else {
        self.layer.borderColor = nil;
    }
}

- (UIColor*)glb_borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setGlb_shadowColor:(UIColor*)shadowColor {
    if(shadowColor != nil) {
        self.layer.shadowColor = shadowColor.CGColor;
    } else {
        self.layer.shadowColor = nil;
    }
}

- (UIColor*)glb_shadowColor {
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}

- (void)setGlb_shadowOpacity:(CGFloat)shadowOpacity {
    self.layer.shadowOpacity = (float)shadowOpacity;
}

- (CGFloat)glb_shadowOpacity {
    return self.layer.shadowOpacity;
}

- (void)setGlb_shadowOffset:(CGSize)shadowOffset {
    self.layer.shadowOffset = shadowOffset;
}

- (CGSize)glb_shadowOffset {
    return self.layer.shadowOffset;
}

- (void)setGlb_shadowRadius:(CGFloat)shadowRadius {
    self.layer.shadowRadius = shadowRadius;
}

- (CGFloat)glb_shadowRadius {
    return self.layer.shadowRadius;
}

- (void)setGlb_shadowPath:(UIBezierPath*)shadowPath {
    if(shadowPath != nil) {
        self.layer.shadowPath = shadowPath.CGPath;
    } else {
        self.layer.shadowPath = nil;
    }
}

- (UIBezierPath*)glb_shadowPath {
    return [UIBezierPath bezierPathWithCGPath:self.layer.shadowPath];
}

#pragma mark - Public

- (NSArray*)glb_responders {
    NSMutableArray* result = NSMutableArray.array;
    if(self.canBecomeFirstResponder) {
        [result addObject:self];
    }
    for(UIView* view in self.subviews) {
        [result addObjectsFromArray:view.glb_responders];
    }
    [result sortWithOptions:0 usingComparator:^NSComparisonResult(UIView* viewA, UIView* viewB) {
        CGRect aFrame = [viewA convertRect:[viewA bounds] toView:nil], bFrame = [viewB convertRect:[viewB bounds] toView:nil];
        CGFloat aOrder = [viewA.layer zPosition], bOrder = [viewB.layer zPosition];
        if(aOrder < bOrder) {
            return NSOrderedAscending;
        } else if(aOrder > bOrder) {
            return NSOrderedDescending;
        } else {
            if(aFrame.origin.y < bFrame.origin.y) {
                return NSOrderedAscending;
            } else if(aFrame.origin.y > bFrame.origin.y) {
                return NSOrderedDescending;
            } else {
                if(aFrame.origin.x < bFrame.origin.x) {
                    return NSOrderedAscending;
                } else if(aFrame.origin.x > bFrame.origin.x) {
                    return NSOrderedDescending;
                }
            }
        }
        return NSOrderedSame;
    }];
    return result;
}

- (BOOL)glb_isContainsSubview:(UIView*)subview {
    NSArray* subviews = self.subviews;
    if([subviews containsObject:subview]) {
        return YES;
    }
    for(UIView* view in subviews) {
        if([view glb_isContainsSubview:subview]) {
            return YES;
        }
    }
    return NO;
}

- (void)glb_removeSubview:(UIView*)subview {
    [subview removeFromSuperview];
}

- (void)glb_setSubviews:(NSArray*)subviews {
    NSArray* currentSubviews = self.subviews;
    if([currentSubviews isEqualToArray:subviews] == NO) {
        for(UIView* view in currentSubviews) {
            [view removeFromSuperview];
        }
        for(UIView* view in subviews) {
            [self addSubview:view];
        }
    }
}

- (void)glb_removeAllSubviews {
    for(UIView* view in self.subviews) {
        [view removeFromSuperview];
    }
}

- (void)glb_blinkBackgroundColor:(UIColor*)color duration:(NSTimeInterval)duration timeout:(NSTimeInterval)timeout {
    UIColor* prevColor = self.backgroundColor;
    [UIView animateWithDuration:duration
                     animations:^{
                         self.backgroundColor = color;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:duration
                                               delay:timeout
                                             options:0
                                          animations:^{
                                              self.backgroundColor = prevColor;
                                          }
                                          completion:nil];
                     }];
}

- (NSLayoutConstraint*)glb_addConstraintAttribute:(NSLayoutAttribute)constraintAttribute relation:(NSLayoutRelation)relation constant:(CGFloat)constant {
    return [self glb_addConstraintAttribute:constraintAttribute relation:relation constant:constant priority:UILayoutPriorityRequired multiplier:1.0];
}

- (NSLayoutConstraint*)glb_addConstraintAttribute:(NSLayoutAttribute)constraintAttribute relation:(NSLayoutRelation)relation constant:(CGFloat)constant priority:(UILayoutPriority)priority {
    return [self glb_addConstraintAttribute:constraintAttribute relation:relation constant:constant priority:priority multiplier:1.0];
}

- (NSLayoutConstraint*)glb_addConstraintAttribute:(NSLayoutAttribute)constraintAttribute relation:(NSLayoutRelation)relation constant:(CGFloat)constant priority:(UILayoutPriority)priority multiplier:(CGFloat)multiplier {
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self attribute:constraintAttribute relatedBy:relation toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:multiplier constant:constant];
    constraint.priority = priority;
    [self addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint*)glb_addConstraintAttribute:(NSLayoutAttribute)constraintAttribute relation:(NSLayoutRelation)relation attribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant {
    return [self glb_addConstraintAttribute:constraintAttribute relation:relation view:self.superview attribute:attribute constant:constant priority:UILayoutPriorityRequired multiplier:1.0];
}

- (NSLayoutConstraint*)glb_addConstraintAttribute:(NSLayoutAttribute)constraintAttribute relation:(NSLayoutRelation)relation attribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant priority:(UILayoutPriority)priority {
    return [self glb_addConstraintAttribute:constraintAttribute relation:relation view:self.superview attribute:attribute constant:constant priority:priority multiplier:1.0];
}

- (NSLayoutConstraint*)glb_addConstraintAttribute:(NSLayoutAttribute)constraintAttribute relation:(NSLayoutRelation)relation attribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant priority:(UILayoutPriority)priority multiplier:(CGFloat)multiplier {
    return [self glb_addConstraintAttribute:constraintAttribute relation:relation view:self.superview attribute:attribute constant:constant priority:priority multiplier:multiplier];
}

- (NSLayoutConstraint*)glb_addConstraintAttribute:(NSLayoutAttribute)constraintAttribute relation:(NSLayoutRelation)relation view:(id)view attribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant {
    return [self glb_addConstraintAttribute:constraintAttribute relation:relation view:view attribute:attribute constant:constant priority:UILayoutPriorityRequired multiplier:1.0];
}

- (NSLayoutConstraint*)glb_addConstraintAttribute:(NSLayoutAttribute)constraintAttribute relation:(NSLayoutRelation)relation view:(id)view attribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant priority:(UILayoutPriority)priority {
    return [self glb_addConstraintAttribute:constraintAttribute relation:relation view:view attribute:attribute constant:constant priority:priority multiplier:1.0];
}

- (NSLayoutConstraint*)glb_addConstraintAttribute:(NSLayoutAttribute)constraintAttribute relation:(NSLayoutRelation)relation view:(id)view attribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant priority:(UILayoutPriority)priority multiplier:(CGFloat)multiplier {
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self attribute:constraintAttribute relatedBy:relation toItem:view attribute:attribute multiplier:multiplier constant:constant];
    constraint.priority = priority;
    [self.superview addConstraint:constraint];
    return constraint;
}

- (void)glb_removeAllConstraints {
    [self removeConstraints:self.constraints];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
