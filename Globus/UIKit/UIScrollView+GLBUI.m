/*--------------------------------------------------*/

#import "UIScrollView+GLBUI.h"
#import "UIResponder+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import <objc/runtime.h>

/*--------------------------------------------------*/

@interface UIScrollView (GLB_Keyboard)

@property(nonatomic) BOOL glb_keyboardShowed;
@property(nonatomic, weak) UIResponder* glb_keyboardResponder;
@property(nonatomic) UIEdgeInsets glb_keyboardContentInset;
@property(nonatomic) UIEdgeInsets glb_keyboardIndicatorInset;

@end

/*--------------------------------------------------*/

@implementation UIScrollView (GLB_UI)

#pragma mark - Property

- (void)setGlb_keyboardShowed:(BOOL)keyboardShowed {
    BOOL oldKeyboardShowed = self.glb_keyboardShowed;
    if((keyboardShowed == NO) && (oldKeyboardShowed == YES)) {
        if([self conformsToProtocol:@protocol(GLBScrollViewExtension)] == YES) {
            id< GLBScrollViewExtension > extension = (id< GLBScrollViewExtension >)self;
            [extension restoreInputState];
        } else {
            self.contentInset = self.glb_keyboardContentInset;
            self.scrollIndicatorInsets = self.glb_keyboardIndicatorInset;
        }
        self.glb_keyboardResponder = nil;
    }
    objc_setAssociatedObject(self, @selector(glb_keyboardShowed), @(keyboardShowed), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if((keyboardShowed == YES) && (oldKeyboardShowed == NO)) {
        if([self conformsToProtocol:@protocol(GLBScrollViewExtension)] == YES) {
            id< GLBScrollViewExtension > extension = (id< GLBScrollViewExtension >)self;
            [extension saveInputState];
        } else {
            self.glb_keyboardContentInset = self.contentInset;
            self.glb_keyboardIndicatorInset = self.scrollIndicatorInsets;
        }
    }
    self.glb_keyboardResponder = [UIResponder glb_currentFirstResponderInView:self];
}

- (BOOL)glb_keyboardShowed {
    return [objc_getAssociatedObject(self, @selector(glb_keyboardShowed)) boolValue];
}

- (void)setGlb_keyboardResponder:(UIResponder*)keyboardResponder {
    objc_setAssociatedObject(self, @selector(glb_keyboardResponder), keyboardResponder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIResponder*)glb_keyboardResponder {
    return objc_getAssociatedObject(self, @selector(glb_keyboardResponder));
}

- (void)setGlb_keyboardContentInset:(UIEdgeInsets)keyboardContentInset {
    objc_setAssociatedObject(self, @selector(glb_keyboardContentInset), [NSValue valueWithUIEdgeInsets:keyboardContentInset], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)glb_keyboardContentInset {
    return [objc_getAssociatedObject(self, @selector(glb_keyboardContentInset)) UIEdgeInsetsValue];
}

- (void)setGlb_keyboardIndicatorInset:(UIEdgeInsets)keyboardIndicatorInset {
    objc_setAssociatedObject(self, @selector(glb_keyboardIndicatorInset), [NSValue valueWithUIEdgeInsets:keyboardIndicatorInset], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)glb_keyboardIndicatorInset {
    return [objc_getAssociatedObject(self, @selector(glb_keyboardIndicatorInset)) UIEdgeInsetsValue];
}

- (void)setGlb_keyboardInset:(UIEdgeInsets)keyboardInset {
    objc_setAssociatedObject(self, @selector(glb_keyboardInset), [NSValue valueWithUIEdgeInsets:keyboardInset], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)glb_keyboardInset {
    NSValue* value = objc_getAssociatedObject(self, @selector(glb_keyboardInset));
    if(value != nil) {
        return value.UIEdgeInsetsValue;
    }
    return UIEdgeInsetsMake(2.0f, 0.0f, 2.0f, 0.0f);
}

- (void)setGlb_contentOffsetX:(CGFloat)contentOffsetX {
    [self setContentOffset:CGPointMake(contentOffsetX, self.contentOffset.y)];
}

- (CGFloat)glb_contentOffsetX {
    return self.contentOffset.x;
}

- (void)setGlb_contentOffsetY:(CGFloat)contentOffsetY {
    [self setContentOffset:CGPointMake(self.contentOffset.x, contentOffsetY)];
}

- (CGFloat)glb_contentOffsetY {
    return self.contentOffset.y;
}

- (void)setGlb_contentSizeWidth:(CGFloat)contentSizeWidth {
    [self setContentSize:CGSizeMake(contentSizeWidth, self.contentSize.height)];
}

- (CGFloat)glb_contentSizeWidth {
    return self.contentSize.width;
}

- (void)setGlb_contentSizeHeight:(CGFloat)contentSizeHeight {
    self.contentSize = CGSizeMake(self.contentSize.width, contentSizeHeight);
}

- (CGFloat)glb_contentSizeHeight {
    return self.contentSize.height;
}

- (void)setGlb_contentInsetTop:(CGFloat)contentInsetTop {
    self.contentInset = UIEdgeInsetsMake(contentInsetTop, self.contentInset.left, self.contentInset.bottom, self.contentInset.right);
}

- (CGFloat)glb_contentInsetTop {
    return self.contentInset.top;
}

- (void)setGlb_contentInsetRight:(CGFloat)contentInsetRight {
    self.contentInset = UIEdgeInsetsMake(self.contentInset.top, self.contentInset.left, self.contentInset.bottom, contentInsetRight);
}

- (CGFloat)glb_contentInsetRight {
    return self.contentInset.right;
}

- (void)setGlb_contentInsetBottom:(CGFloat)contentInsetBottom {
    self.contentInset = UIEdgeInsetsMake(self.contentInset.top, self.contentInset.left, contentInsetBottom, self.contentInset.right);
}

- (CGFloat)glb_contentInsetBottom {
    return self.contentInset.bottom;
}

- (void)setGlb_contentInsetLeft:(CGFloat)contentInsetLeft {
    self.contentInset = UIEdgeInsetsMake(self.contentInset.top, contentInsetLeft, self.contentInset.bottom, self.contentInset.right);
}

- (CGFloat)glb_contentInsetLeft {
    return self.contentInset.left;
}

- (void)setGlb_scrollIndicatorInsetTop:(CGFloat)scrollIndicatorInsetTop {
    self.scrollIndicatorInsets = UIEdgeInsetsMake(scrollIndicatorInsetTop, self.scrollIndicatorInsets.left, self.scrollIndicatorInsets.bottom, self.scrollIndicatorInsets.right);
}

- (CGFloat)glb_scrollIndicatorInsetTop {
    return self.scrollIndicatorInsets.top;
}

- (void)setGlb_scrollIndicatorInsetRight:(CGFloat)scrollIndicatorInsetRight {
    self.scrollIndicatorInsets = UIEdgeInsetsMake(self.scrollIndicatorInsets.top, self.scrollIndicatorInsets.left, self.scrollIndicatorInsets.bottom, scrollIndicatorInsetRight);
}

- (CGFloat)glb_scrollIndicatorInsetRight {
    return self.scrollIndicatorInsets.right;
}

- (void)setGlb_scrollIndicatorInsetBottom:(CGFloat)scrollIndicatorInsetBottom {
    self.scrollIndicatorInsets = UIEdgeInsetsMake(self.scrollIndicatorInsets.top, self.scrollIndicatorInsets.left, scrollIndicatorInsetBottom, self.scrollIndicatorInsets.right);
}

- (CGFloat)glb_scrollIndicatorInsetBottom {
    return self.scrollIndicatorInsets.bottom;
}

- (void)setGlb_scrollIndicatorInsetLeft:(CGFloat)scrollIndicatorInsetLeft {
    self.scrollIndicatorInsets = UIEdgeInsetsMake(self.scrollIndicatorInsets.top, scrollIndicatorInsetLeft, self.scrollIndicatorInsets.bottom, self.scrollIndicatorInsets.right);
}

- (CGFloat)glb_scrollIndicatorInsetLeft {
    return self.scrollIndicatorInsets.left;
}

- (CGRect)glb_visibleBounds {
    return UIEdgeInsetsInsetRect(self.bounds, self.contentInset);
}

#pragma mark - Public

- (void)glb_setContentOffsetX:(CGFloat)glb_contentOffsetX animated:(BOOL)animated {
    [self setContentOffset:CGPointMake(glb_contentOffsetX, self.contentOffset.y) animated:animated];
}

- (void)glb_setContentOffsetY:(CGFloat)glb_contentOffsetY animated:(BOOL)animated {
    [self setContentOffset:CGPointMake(self.contentOffset.x, glb_contentOffsetY) animated:animated];
}

- (void)glb_registerAdjustmentResponder {
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(glb_adjustmentNotificationKeyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(glb_adjustmentNotificationKeyboardShow:) name:UIKeyboardDidShowNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(glb_adjustmentNotificationKeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(glb_adjustmentNotificationKeyboardHide:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)glb_unregisterAdjustmentResponder {
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

#pragma mark - UIKeyboarNotification

- (void)glb_adjustmentNotificationKeyboardShow:(NSNotification*)notification {
    self.glb_keyboardShowed = YES;
    CGRect scrollRect = [self convertRect:self.bounds toView:nil];
    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect intersectionRect = CGRectIntersection(scrollRect, keyboardRect);
    if(CGRectIsNull(intersectionRect) == NO) {
        if(intersectionRect.size.height > FLT_EPSILON) {
            if([self conformsToProtocol:@protocol(GLBScrollViewExtension)] == YES) {
                id< GLBScrollViewExtension > extension = (id< GLBScrollViewExtension >)self;
                [extension showInputIntersectionRect:intersectionRect];
            } else {
                self.glb_scrollIndicatorInsetBottom = intersectionRect.size.height;
                self.glb_contentInsetBottom = intersectionRect.size.height;
            }
        }
        if([self.glb_keyboardResponder isKindOfClass:UIView.class] == YES) {
            UIView* responderView = (UIView*)self.glb_keyboardResponder;
            CGRect visibleRect = [self convertRect:UIEdgeInsetsInsetRect(self.glb_visibleBounds, self.glb_keyboardInset) toView:nil];
            CGRect responderRect = [responderView convertRect:responderView.bounds toView:nil];
            if(CGRectContainsRect(visibleRect, responderRect) == NO) {
                CGPoint contentOffset = self.contentOffset;
                if(visibleRect.size.width > responderRect.size.width) {
                    CGFloat vrsx = CGRectGetMinX(visibleRect);
                    CGFloat vrex = CGRectGetMaxX(visibleRect);
                    CGFloat rrsx = CGRectGetMinX(responderRect);
                    CGFloat rrex = CGRectGetMaxX(responderRect);
                    if((vrex - vrsx) < (rrex - rrsx)) {
                        contentOffset.x -= vrsx - rrsx;
                    } else if(vrsx > rrsx) {
                        contentOffset.x -= vrsx - rrsx;
                    } else if(vrex < rrex) {
                        contentOffset.x -= vrex - rrex;
                    }
                }
                if(visibleRect.size.height > responderRect.size.height) {
                    CGFloat vrsy = CGRectGetMinY(visibleRect);
                    CGFloat vrey = CGRectGetMaxY(visibleRect);
                    CGFloat rrsy = CGRectGetMinY(responderRect);
                    CGFloat rrey = CGRectGetMaxY(responderRect);
                    if((vrey - vrsy) < (rrey - rrsy)) {
                        contentOffset.y -= vrsy - rrsy;
                    } else if(vrsy > rrsy) {
                        contentOffset.y -= vrsy - rrsy;
                    } else if(vrey < rrey) {
                        contentOffset.y -= vrey - rrey;
                    }
                }
                if(CGPointEqualToPoint(contentOffset, self.contentOffset) == NO) {
                    [self setContentOffset:contentOffset animated:YES];
                }
            }
        }
    }
}

- (void)glb_adjustmentNotificationKeyboardHide:(NSNotification*)notification {
    self.glb_keyboardShowed = NO;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
