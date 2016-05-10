/*--------------------------------------------------*/

#import "UIView+GLBUI.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

typedef NS_ENUM(NSUInteger, GLBPageControlAlignment) {
	GLBPageControlAlignmentLeft = 1,
	GLBPageControlAlignmentCenter,
	GLBPageControlAlignmentRight
};

typedef NS_ENUM(NSUInteger, GLBPageControlVerticalAlignment) {
	GLBPageControlVerticalAlignmentTop = 1,
	GLBPageControlVerticalAlignmentMiddle,
	GLBPageControlVerticalAlignmentBottom
};

typedef NS_ENUM(NSUInteger, GLBPageControlTapBehavior) {
	GLBPageControlTapBehaviorStep = 1,
	GLBPageControlTapBehaviorJump
};

/*--------------------------------------------------*/

@interface GLBPageControl : UIControl

@property(nonatomic) IBInspectable NSInteger numberOfPages;
@property(nonatomic) IBInspectable NSInteger currentPage;
@property(nonatomic) IBInspectable CGFloat indicatorMargin;
@property(nonatomic) IBInspectable CGFloat indicatorDiameter;
@property(nonatomic) IBInspectable CGFloat minHeight;
@property(nonatomic) IBInspectable GLBPageControlAlignment alignment;
@property(nonatomic) IBInspectable GLBPageControlVerticalAlignment verticalAlignment;
@property(nonatomic, strong) IBInspectable UIImage* pageIndicatorImage;
@property(nonatomic, strong) IBInspectable UIImage* pageIndicatorMaskImage;
@property(nonatomic, strong) IBInspectable UIColor* pageIndicatorTintColor;
@property(nonatomic, strong) IBInspectable UIImage* currentPageIndicatorImage;
@property(nonatomic, strong) IBInspectable UIColor* currentPageIndicatorTintColor;
@property(nonatomic) IBInspectable BOOL hidesForSinglePage;
@property(nonatomic) IBInspectable BOOL defersCurrentPageDisplay;
@property(nonatomic) IBInspectable GLBPageControlTapBehavior tapBehavior;

- (void)setup NS_REQUIRES_SUPER;

- (void)updateCurrentPageDisplay;

- (CGRect)rectForPageIndicator:(NSInteger)pageIndex;
- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount;

- (void)setImage:(UIImage*)image forPage:(NSInteger)pageIndex;
- (UIImage*)imageForPage:(NSInteger)pageIndex;

- (void)setCurrentImage:(UIImage*)image forPage:(NSInteger)pageIndex;
- (UIImage*)currentImageForPage:(NSInteger)pageIndex;

- (void)setImageMask:(UIImage*)image forPage:(NSInteger)pageIndex;
- (UIImage*)imageMaskForPage:(NSInteger)pageIndex;

- (void)setScrollViewContentOffsetForCurrentPage:(UIScrollView*)scrollView animated:(BOOL)animated;
- (void)updatePageNumberForScrollView:(UIScrollView*)scrollView;

- (void)setName:(NSString*)name forPage:(NSInteger)pageIndex;
- (NSString*)nameForPage:(NSInteger)pageIndex;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
