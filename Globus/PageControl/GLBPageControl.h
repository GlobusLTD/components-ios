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

@property(nonatomic) IBInspectable NSUInteger numberOfPages;
@property(nonatomic) IBInspectable NSUInteger currentPage;
@property(nonatomic) IBInspectable CGFloat indicatorMargin;
@property(nonatomic) IBInspectable CGFloat indicatorDiameter;
@property(nonatomic) IBInspectable CGFloat minHeight;
@property(nonatomic) IBInspectable GLBPageControlAlignment alignment;
@property(nonatomic) IBInspectable GLBPageControlVerticalAlignment verticalAlignment;
@property(nonatomic, nullable, strong) IBInspectable UIImage* pageIndicatorImage;
@property(nonatomic, nullable, strong) IBInspectable UIImage* pageIndicatorMaskImage;
@property(nonatomic, nullable, strong) IBInspectable UIColor* pageIndicatorTintColor;
@property(nonatomic, nullable, strong) IBInspectable UIImage* currentPageIndicatorImage;
@property(nonatomic, nullable, strong) IBInspectable UIColor* currentPageIndicatorTintColor;
@property(nonatomic) IBInspectable BOOL hidesForSinglePage;
@property(nonatomic) IBInspectable BOOL defersCurrentPageDisplay;
@property(nonatomic) IBInspectable GLBPageControlTapBehavior tapBehavior;

- (void)setup NS_REQUIRES_SUPER;

- (void)updateCurrentPageDisplay;

- (CGRect)rectForPageIndicator:(NSUInteger)pageIndex;
- (CGSize)sizeForNumberOfPages:(NSUInteger)pageCount;

- (void)setImage:(nullable UIImage*)image forPage:(NSUInteger)pageIndex;
- (nullable UIImage*)imageForPage:(NSUInteger)pageIndex;

- (void)setCurrentImage:(nullable UIImage*)image forPage:(NSUInteger)pageIndex;
- (nullable UIImage*)currentImageForPage:(NSUInteger)pageIndex;

- (void)setImageMask:(nullable UIImage*)image forPage:(NSUInteger)pageIndex;
- (nullable UIImage*)imageMaskForPage:(NSUInteger)pageIndex;

- (void)setScrollViewContentOffsetForCurrentPage:(nonnull UIScrollView*)scrollView animated:(BOOL)animated;
- (void)updatePageNumberForScrollView:(nonnull UIScrollView*)scrollView;

- (void)setName:(nullable NSString*)name forPage:(NSUInteger)pageIndex;
- (nullable NSString*)nameForPage:(NSUInteger)pageIndex;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
