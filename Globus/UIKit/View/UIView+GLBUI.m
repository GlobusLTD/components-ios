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

- (void)setGlb_horizontalContentHuggingPriority:(UILayoutPriority)horizontalContentHuggingPriority {
    [self setContentHuggingPriority:horizontalContentHuggingPriority forAxis:UILayoutConstraintAxisHorizontal];
}

- (UILayoutPriority)glb_horizontalContentHuggingPriority {
    return [self contentHuggingPriorityForAxis:UILayoutConstraintAxisHorizontal];
}

- (void)setGlb_verticalContentHuggingPriority:(UILayoutPriority)verticalContentHuggingPriority {
    [self setContentHuggingPriority:verticalContentHuggingPriority forAxis:UILayoutConstraintAxisVertical];
}

- (UILayoutPriority)glb_verticalContentHuggingPriority {
    return [self contentHuggingPriorityForAxis:UILayoutConstraintAxisVertical];
}

- (void)setGlb_horizontalContentCompressionResistancePriority:(UILayoutPriority)horizontalContentCompressionResistancePriority {
    [self setContentCompressionResistancePriority:horizontalContentCompressionResistancePriority forAxis:UILayoutConstraintAxisHorizontal];
}

- (UILayoutPriority)glb_horizontalContentCompressionResistancePriority {
    return [self contentCompressionResistancePriorityForAxis:UILayoutConstraintAxisHorizontal];
}

- (void)setGlb_verticalContentCompressionResistancePriority:(UILayoutPriority)verticalContentCompressionResistancePriority {
    [self setContentCompressionResistancePriority:verticalContentCompressionResistancePriority forAxis:UILayoutConstraintAxisVertical];
}

- (UILayoutPriority)glb_verticalContentCompressionResistancePriority {
    return [self contentCompressionResistancePriorityForAxis:UILayoutConstraintAxisVertical];
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

- (NSLayoutConstraint*)glb_addConstraintFirstBaseline:(CGFloat)offset {
    return [self glb_addConstraintFirstBaseline:offset relation:NSLayoutRelationEqual topView:self.superview];
}

- (NSLayoutConstraint*)glb_addConstraintFirstBaseline:(CGFloat)offset relation:(NSLayoutRelation)relation {
    return [self glb_addConstraintFirstBaseline:offset relation:relation topView:self.superview];
}

- (NSLayoutConstraint*)glb_addConstraintFirstBaseline:(CGFloat)offset topView:(UIView*)topView {
    return [self glb_addConstraintFirstBaseline:offset relation:NSLayoutRelationEqual topView:topView];
}

- (NSLayoutConstraint*)glb_addConstraintFirstBaseline:(CGFloat)offset relation:(NSLayoutRelation)relation topView:(UIView*)topView {
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeFirstBaseline
                                                                  relatedBy:relation
                                                                     toItem:topView
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0f
                                                                   constant:offset];
    [self.superview addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint*)glb_addConstraintFirstBaseline:(CGFloat)offset centerView:(UIView*)centerView {
    return [self glb_addConstraintFirstBaseline:offset relation:NSLayoutRelationEqual centerView:centerView];
}

- (NSLayoutConstraint*)glb_addConstraintFirstBaseline:(CGFloat)offset relation:(NSLayoutRelation)relation centerView:(UIView*)centerView {
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeFirstBaseline
                                                                  relatedBy:relation
                                                                     toItem:centerView
                                                                  attribute:NSLayoutAttributeCenterY
                                                                 multiplier:1.0f
                                                                   constant:offset];
    [self.superview addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint*)glb_addConstraintFirstBaseline:(CGFloat)offset bottomView:(UIView*)bottomView {
    return [self glb_addConstraintFirstBaseline:offset relation:NSLayoutRelationEqual bottomView:bottomView];
}

- (NSLayoutConstraint*)glb_addConstraintFirstBaseline:(CGFloat)offset relation:(NSLayoutRelation)relation bottomView:(UIView*)bottomView {
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeFirstBaseline
                                                                  relatedBy:relation
                                                                     toItem:bottomView
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0f
                                                                   constant:offset];
    [self.superview addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint*)glb_addConstraintLastBaseline:(CGFloat)offset {
    return [self glb_addConstraintLastBaseline:offset relation:NSLayoutRelationEqual topView:self.superview];
}

- (NSLayoutConstraint*)glb_addConstraintLastBaseline:(CGFloat)offset relation:(NSLayoutRelation)relation {
    return [self glb_addConstraintLastBaseline:offset relation:relation topView:self.superview];
}

- (NSLayoutConstraint*)glb_addConstraintLastBaseline:(CGFloat)offset topView:(UIView*)topView {
    return [self glb_addConstraintLastBaseline:offset relation:NSLayoutRelationEqual topView:topView];
}

- (NSLayoutConstraint*)glb_addConstraintLastBaseline:(CGFloat)offset relation:(NSLayoutRelation)relation topView:(UIView*)topView {
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeLastBaseline
                                                                  relatedBy:relation
                                                                     toItem:topView
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0f
                                                                   constant:offset];
    [self.superview addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint*)glb_addConstraintLastBaseline:(CGFloat)offset centerView:(UIView*)centerView {
    return [self glb_addConstraintLastBaseline:offset relation:NSLayoutRelationEqual centerView:centerView];
}

- (NSLayoutConstraint*)glb_addConstraintLastBaseline:(CGFloat)offset relation:(NSLayoutRelation)relation centerView:(UIView*)centerView {
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeLastBaseline
                                                                  relatedBy:relation
                                                                     toItem:centerView
                                                                  attribute:NSLayoutAttributeCenterY
                                                                 multiplier:1.0f
                                                                   constant:offset];
    [self.superview addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint*)glb_addConstraintLastBaseline:(CGFloat)offset bottomView:(UIView*)bottomView {
    return [self glb_addConstraintLastBaseline:offset relation:NSLayoutRelationEqual bottomView:bottomView];
}

- (NSLayoutConstraint*)glb_addConstraintLastBaseline:(CGFloat)offset relation:(NSLayoutRelation)relation bottomView:(UIView*)bottomView {
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeLastBaseline
                                                                  relatedBy:relation
                                                                     toItem:bottomView
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0f
                                                                   constant:offset];
    [self.superview addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint*)glb_addConstraintTop:(CGFloat)offset {
    return [self glb_addConstraintTop:offset relation:NSLayoutRelationEqual topView:self.superview];
}

- (NSLayoutConstraint*)glb_addConstraintTop:(CGFloat)offset relation:(NSLayoutRelation)relation {
    return [self glb_addConstraintTop:offset relation:relation topView:self.superview];
}

- (NSLayoutConstraint*)glb_addConstraintTop:(CGFloat)offset topView:(UIView*)topView {
    return [self glb_addConstraintTop:offset relation:NSLayoutRelationEqual topView:topView];
}

- (NSLayoutConstraint*)glb_addConstraintTop:(CGFloat)offset relation:(NSLayoutRelation)relation topView:(UIView*)topView {
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:relation
                                                                     toItem:topView
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0f
                                                                   constant:offset];
    [self.superview addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint*)glb_addConstraintTop:(CGFloat)offset centerView:(UIView*)centerView {
    return [self glb_addConstraintTop:offset relation:NSLayoutRelationEqual centerView:centerView];
}

- (NSLayoutConstraint*)glb_addConstraintTop:(CGFloat)offset relation:(NSLayoutRelation)relation centerView:(UIView*)centerView {
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:relation
                                                                     toItem:centerView
                                                                  attribute:NSLayoutAttributeCenterY
                                                                 multiplier:1.0f
                                                                   constant:offset];
    [self.superview addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint*)glb_addConstraintTop:(CGFloat)offset bottomView:(UIView*)bottomView {
    return [self glb_addConstraintTop:offset relation:NSLayoutRelationEqual bottomView:bottomView];
}

- (NSLayoutConstraint*)glb_addConstraintTop:(CGFloat)offset relation:(NSLayoutRelation)relation bottomView:(UIView*)bottomView {
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:relation
                                                                     toItem:bottomView
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0f
                                                                   constant:offset];
    [self.superview addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint*)glb_addConstraintRight:(CGFloat)offset {
    return [self glb_addConstraintRight:offset relation:NSLayoutRelationEqual rightView:self.superview];
}

- (NSLayoutConstraint*)glb_addConstraintRight:(CGFloat)offset relation:(NSLayoutRelation)relation {
    return [self glb_addConstraintRight:offset relation:relation rightView:self.superview];
}

- (NSLayoutConstraint*)glb_addConstraintRight:(CGFloat)offset rightView:(UIView*)rightView {
    return [self glb_addConstraintRight:offset relation:NSLayoutRelationEqual rightView:rightView];
}

- (NSLayoutConstraint*)glb_addConstraintRight:(CGFloat)offset relation:(NSLayoutRelation)relation rightView:(UIView*)rightView {
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:rightView
                                                                  attribute:NSLayoutAttributeTrailing
                                                                  relatedBy:relation
                                                                     toItem:self
                                                                  attribute:NSLayoutAttributeTrailing
                                                                 multiplier:1.0f
                                                                   constant:offset];
    [self.superview addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint*)glb_addConstraintRight:(CGFloat)offset centerView:(UIView*)centerView {
    return [self glb_addConstraintRight:offset relation:NSLayoutRelationEqual centerView:centerView];
}

- (NSLayoutConstraint*)glb_addConstraintRight:(CGFloat)offset relation:(NSLayoutRelation)relation centerView:(UIView*)centerView {
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:centerView
                                                                  attribute:NSLayoutAttributeCenterX
                                                                  relatedBy:relation
                                                                     toItem:self
                                                                  attribute:NSLayoutAttributeTrailing
                                                                 multiplier:1.0f
                                                                   constant:offset];
    [self.superview addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint*)glb_addConstraintRight:(CGFloat)offset leftView:(UIView*)leftView {
    return [self glb_addConstraintRight:offset relation:NSLayoutRelationEqual leftView:leftView];
}

- (NSLayoutConstraint*)glb_addConstraintRight:(CGFloat)offset relation:(NSLayoutRelation)relation leftView:(UIView*)leftView {
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:leftView
                                                                  attribute:NSLayoutAttributeLeading
                                                                  relatedBy:relation
                                                                     toItem:self
                                                                  attribute:NSLayoutAttributeTrailing
                                                                 multiplier:1.0f
                                                                   constant:offset];
    [self.superview addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint*)glb_addConstraintBottom:(CGFloat)offset {
    return [self glb_addConstraintBottom:offset relation:NSLayoutRelationEqual bottomView:self.superview];
}

- (NSLayoutConstraint*)glb_addConstraintBottom:(CGFloat)offset relation:(NSLayoutRelation)relation {
    return [self glb_addConstraintBottom:offset relation:relation bottomView:self.superview];
}

- (NSLayoutConstraint*)glb_addConstraintBottom:(CGFloat)offset bottomView:(UIView*)bottomView {
    return [self glb_addConstraintBottom:offset relation:NSLayoutRelationEqual bottomView:bottomView];
}

- (NSLayoutConstraint*)glb_addConstraintBottom:(CGFloat)offset relation:(NSLayoutRelation)relation bottomView:(UIView*)bottomView {
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:bottomView
                                                                  attribute:NSLayoutAttributeBottom
                                                                  relatedBy:relation
                                                                     toItem:self
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0f
                                                                   constant:offset];
    [self.superview addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint*)glb_addConstraintBottom:(CGFloat)offset centerView:(UIView*)centerView {
    return [self glb_addConstraintBottom:offset relation:NSLayoutRelationEqual centerView:centerView];
}

- (NSLayoutConstraint*)glb_addConstraintBottom:(CGFloat)offset relation:(NSLayoutRelation)relation centerView:(UIView*)centerView {
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:centerView
                                                                  attribute:NSLayoutAttributeCenterY
                                                                  relatedBy:relation
                                                                     toItem:self
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0f
                                                                   constant:offset];
    [self.superview addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint*)glb_addConstraintBottom:(CGFloat)offset topView:(UIView*)topView {
    return [self glb_addConstraintBottom:offset relation:NSLayoutRelationEqual topView:topView];
}

- (NSLayoutConstraint*)glb_addConstraintBottom:(CGFloat)offset relation:(NSLayoutRelation)relation topView:(UIView*)topView {
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:topView
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:relation
                                                                     toItem:self
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0f
                                                                   constant:offset];
    [self.superview addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint*)glb_addConstraintLeft:(CGFloat)offset {
    return [self glb_addConstraintLeft:offset relation:NSLayoutRelationEqual leftView:self.superview];
}

- (NSLayoutConstraint*)glb_addConstraintLeft:(CGFloat)offset relation:(NSLayoutRelation)relation {
    return [self glb_addConstraintLeft:offset relation:relation leftView:self.superview];
}

- (NSLayoutConstraint*)glb_addConstraintLeft:(CGFloat)offset leftView:(UIView*)leftView {
    return [self glb_addConstraintLeft:offset relation:NSLayoutRelationEqual leftView:leftView];
}

- (NSLayoutConstraint*)glb_addConstraintLeft:(CGFloat)offset relation:(NSLayoutRelation)relation leftView:(UIView*)leftView {
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeLeading
                                                                  relatedBy:relation
                                                                     toItem:leftView
                                                                  attribute:NSLayoutAttributeLeading
                                                                 multiplier:1.0f
                                                                   constant:offset];
    [self.superview addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint*)glb_addConstraintLeft:(CGFloat)offset centerView:(UIView*)centerView {
    return [self glb_addConstraintLeft:offset relation:NSLayoutRelationEqual centerView:centerView];
}

- (NSLayoutConstraint*)glb_addConstraintLeft:(CGFloat)offset relation:(NSLayoutRelation)relation centerView:(UIView*)centerView {
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeLeading
                                                                  relatedBy:relation
                                                                     toItem:centerView
                                                                  attribute:NSLayoutAttributeCenterX
                                                                 multiplier:1.0f
                                                                   constant:offset];
    [self.superview addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint*)glb_addConstraintLeft:(CGFloat)offset rightView:(UIView*)rightView {
    return [self glb_addConstraintLeft:offset relation:NSLayoutRelationEqual rightView:rightView];
}

- (NSLayoutConstraint*)glb_addConstraintLeft:(CGFloat)offset relation:(NSLayoutRelation)relation rightView:(UIView*)rightView {
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeLeading
                                                                  relatedBy:relation
                                                                     toItem:rightView
                                                                  attribute:NSLayoutAttributeTrailing
                                                                 multiplier:1.0f
                                                                   constant:offset];
    [self.superview addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint*)glb_addConstraintVertical:(CGFloat)offset {
    return [self glb_addConstraintVertical:offset relation:NSLayoutRelationEqual centerView:self.superview];
}

- (NSLayoutConstraint*)glb_addConstraintVertical:(CGFloat)offset relation:(NSLayoutRelation)relation {
    return [self glb_addConstraintVertical:offset relation:relation centerView:self.superview];
}

- (NSLayoutConstraint*)glb_addConstraintVertical:(CGFloat)offset topView:(UIView*)topView {
    return [self glb_addConstraintVertical:offset relation:NSLayoutRelationEqual topView:topView];
}

- (NSLayoutConstraint*)glb_addConstraintVertical:(CGFloat)offset relation:(NSLayoutRelation)relation topView:(UIView*)topView {
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeCenterY
                                                                  relatedBy:relation
                                                                     toItem:topView
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0f
                                                                   constant:offset];
    [self.superview addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint*)glb_addConstraintVertical:(CGFloat)offset centerView:(UIView*)centerView {
    return [self glb_addConstraintVertical:offset relation:NSLayoutRelationEqual centerView:centerView];
}

- (NSLayoutConstraint*)glb_addConstraintVertical:(CGFloat)offset relation:(NSLayoutRelation)relation centerView:(UIView*)centerView {
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeCenterY
                                                                  relatedBy:relation
                                                                     toItem:centerView
                                                                  attribute:NSLayoutAttributeCenterY
                                                                 multiplier:1.0f
                                                                   constant:offset];
    [self.superview addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint*)glb_addConstraintVertical:(CGFloat)offset bottomView:(UIView*)bottomView {
    return [self glb_addConstraintVertical:offset relation:NSLayoutRelationEqual bottomView:bottomView];
}

- (NSLayoutConstraint*)glb_addConstraintVertical:(CGFloat)offset relation:(NSLayoutRelation)relation bottomView:(UIView*)bottomView {
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeCenterY
                                                                  relatedBy:relation
                                                                     toItem:bottomView
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0f
                                                                   constant:offset];
    [self.superview addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint*)glb_addConstraintHorizontal:(CGFloat)offset {
    return [self glb_addConstraintHorizontal:offset relation:NSLayoutRelationEqual centerView:self.superview];
}

- (NSLayoutConstraint*)glb_addConstraintHorizontal:(CGFloat)offset relation:(NSLayoutRelation)relation {
    return [self glb_addConstraintHorizontal:offset relation:relation centerView:self.superview];
}

- (NSLayoutConstraint*)glb_addConstraintHorizontal:(CGFloat)offset leftView:(UIView*)leftView {
    return [self glb_addConstraintHorizontal:offset relation:NSLayoutRelationEqual leftView:leftView];
}

- (NSLayoutConstraint*)glb_addConstraintHorizontal:(CGFloat)offset relation:(NSLayoutRelation)relation leftView:(UIView*)leftView {
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeCenterX
                                                                  relatedBy:relation
                                                                     toItem:leftView
                                                                  attribute:NSLayoutAttributeLeading
                                                                 multiplier:1.0f
                                                                   constant:offset];
    [self.superview addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint*)glb_addConstraintHorizontal:(CGFloat)offset centerView:(UIView*)centerView {
    return [self glb_addConstraintHorizontal:offset relation:NSLayoutRelationEqual centerView:centerView];
}

- (NSLayoutConstraint*)glb_addConstraintHorizontal:(CGFloat)offset relation:(NSLayoutRelation)relation centerView:(UIView*)centerView {
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeCenterX
                                                                  relatedBy:relation
                                                                     toItem:centerView
                                                                  attribute:NSLayoutAttributeCenterX
                                                                 multiplier:1.0f
                                                                   constant:offset];
    [self.superview addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint*)glb_addConstraintHorizontal:(CGFloat)offset rightView:(UIView*)rightView {
    return [self glb_addConstraintHorizontal:offset relation:NSLayoutRelationEqual rightView:rightView];
}

- (NSLayoutConstraint*)glb_addConstraintHorizontal:(CGFloat)offset relation:(NSLayoutRelation)relation rightView:(UIView*)rightView {
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeCenterX
                                                                  relatedBy:relation
                                                                     toItem:rightView
                                                                  attribute:NSLayoutAttributeTrailing
                                                                 multiplier:1.0f
                                                                   constant:offset];
    [self.superview addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint*)glb_addConstraintWidth:(CGFloat)width {
    return [self glb_addConstraintWidth:width relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint*)glb_addConstraintWidth:(CGFloat)width relation:(NSLayoutRelation)relation {
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:relation
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1.0f
                                                                   constant:width];
    [self addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint*)glb_addConstraintWidthView:(UIView*)view {
    return [self glb_addConstraintWidth:0 relation:NSLayoutRelationEqual view:view];
}

- (NSLayoutConstraint*)glb_addConstraintWidth:(CGFloat)width view:(UIView*)view {
    return [self glb_addConstraintWidth:width relation:NSLayoutRelationEqual view:view];
}

- (NSLayoutConstraint*)glb_addConstraintWidth:(CGFloat)width relation:(NSLayoutRelation)relation view:(UIView*)view {
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:relation
                                                                     toItem:view
                                                                  attribute:NSLayoutAttributeWidth
                                                                 multiplier:1.0f
                                                                   constant:width];
    [self.superview addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint*)glb_addConstraintHeight:(CGFloat)height {
    return [self glb_addConstraintHeight:height relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint*)glb_addConstraintHeight:(CGFloat)height relation:(NSLayoutRelation)relation {
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:relation
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1.0f
                                                                   constant:height];
    [self addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint*)glb_addConstraintHeightView:(UIView*)view {
    return [self glb_addConstraintHeight:0 relation:NSLayoutRelationEqual view:view];
}

- (NSLayoutConstraint*)glb_addConstraintHeight:(CGFloat)height view:(UIView*)view {
    return [self glb_addConstraintHeight:height relation:NSLayoutRelationEqual view:view];
}

- (NSLayoutConstraint*)glb_addConstraintHeight:(CGFloat)height relation:(NSLayoutRelation)relation view:(UIView*)view {
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:relation
                                                                     toItem:view
                                                                  attribute:NSLayoutAttributeHeight
                                                                 multiplier:1.0f
                                                                   constant:height];
    [self.superview addConstraint:constraint];
    return constraint;
}

- (NSArray< NSLayoutConstraint* >*)glb_addConstraintCenter {
    return [self glb_addConstraintCenter:UIOffsetZero relation:NSLayoutRelationEqual view:self.superview];
}

- (NSArray< NSLayoutConstraint* >*)glb_addConstraintCenterRelation:(NSLayoutRelation)relation {
    return [self glb_addConstraintCenter:UIOffsetZero relation:relation view:self.superview];
}

- (NSArray< NSLayoutConstraint* >*)glb_addConstraintCenter:(UIOffset)offset {
    return [self glb_addConstraintCenter:offset relation:NSLayoutRelationEqual view:self.superview];
}

- (NSArray< NSLayoutConstraint* >*)glb_addConstraintCenter:(UIOffset)offset relation:(NSLayoutRelation)relation {
    return [self glb_addConstraintCenter:offset relation:relation view:self.superview];
}

- (NSArray< NSLayoutConstraint* >*)glb_addConstraintCenter:(UIOffset)offset view:(UIView*)view {
    return [self glb_addConstraintCenter:offset relation:NSLayoutRelationEqual view:view];
}

- (NSArray< NSLayoutConstraint* >*)glb_addConstraintCenter:(UIOffset)offset relation:(NSLayoutRelation)relation view:(UIView*)view {
    NSLayoutConstraint* horizontal = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeCenterY
                                                                  relatedBy:relation
                                                                     toItem:view
                                                                  attribute:NSLayoutAttributeCenterY
                                                                 multiplier:1.0f
                                                                   constant:offset.vertical];
    NSLayoutConstraint* vertical = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeCenterX
                                                                  relatedBy:relation
                                                                     toItem:view
                                                                  attribute:NSLayoutAttributeCenterX
                                                                 multiplier:1.0f
                                                                   constant:offset.horizontal];
    NSArray* constraints = @[ horizontal, vertical ];
    [self.superview addConstraints:constraints];
    return constraints;
}

- (NSArray< NSLayoutConstraint* >*)glb_addConstraintEdgeInsets {
    return [self glb_addConstraintEdgeInsets:UIEdgeInsetsZero relation:NSLayoutRelationEqual view:self.superview];
}

- (NSArray< NSLayoutConstraint* >*)glb_addConstraintEdgeInsetsRelation:(NSLayoutRelation)relation {
    return [self glb_addConstraintEdgeInsets:UIEdgeInsetsZero relation:relation view:self.superview];
}

- (NSArray< NSLayoutConstraint* >*)glb_addConstraintEdgeInsets:(UIEdgeInsets)edgeInsets {
    return [self glb_addConstraintEdgeInsets:UIEdgeInsetsZero relation:NSLayoutRelationEqual view:self.superview];
}

- (NSArray< NSLayoutConstraint* >*)glb_addConstraintEdgeInsets:(UIEdgeInsets)edgeInsets relation:(NSLayoutRelation)relation {
    return [self glb_addConstraintEdgeInsets:UIEdgeInsetsZero relation:relation view:self.superview];
}

- (NSArray< NSLayoutConstraint* >*)glb_addConstraintEdgeInsets:(UIEdgeInsets)edgeInsets view:(UIView*)view {
    return [self glb_addConstraintEdgeInsets:UIEdgeInsetsZero relation:NSLayoutRelationEqual view:view];
}

- (NSArray< NSLayoutConstraint* >*)glb_addConstraintEdgeInsets:(UIEdgeInsets)edgeInsets relation:(NSLayoutRelation)relation view:(UIView*)view {
    NSLayoutConstraint* top = [NSLayoutConstraint constraintWithItem:self
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:relation
                                                              toItem:view
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0f
                                                            constant:edgeInsets.top];
    NSLayoutConstraint* right = [NSLayoutConstraint constraintWithItem:view
                                                             attribute:NSLayoutAttributeTrailing
                                                             relatedBy:relation
                                                                toItem:self
                                                             attribute:NSLayoutAttributeTrailing
                                                            multiplier:1.0f
                                                              constant:edgeInsets.right];
    NSLayoutConstraint* bottom = [NSLayoutConstraint constraintWithItem:view
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:relation
                                                                 toItem:self
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0f
                                                               constant:edgeInsets.bottom];
    NSLayoutConstraint* left = [NSLayoutConstraint constraintWithItem:self
                                                           attribute:NSLayoutAttributeLeading
                                                           relatedBy:relation
                                                              toItem:view
                                                           attribute:NSLayoutAttributeLeading
                                                          multiplier:1.0f
                                                            constant:edgeInsets.left];
    NSArray* constraints = @[ top, right, bottom, left ];
    [self.superview addConstraints:constraints];
    return constraints;
}

- (void)glb_removeAllConstraints {
    [self removeConstraints:self.constraints];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
