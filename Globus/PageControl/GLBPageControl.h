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

- (void)setImage:(UIImage* _Nullable)image forPage:(NSUInteger)pageIndex;
- (UIImage* _Nullable)imageForPage:(NSUInteger)pageIndex;

- (void)setCurrentImage:(UIImage* _Nullable)image forPage:(NSUInteger)pageIndex;
- (UIImage* _Nullable)currentImageForPage:(NSUInteger)pageIndex;

- (void)setImageMask:(UIImage* _Nullable)image forPage:(NSUInteger)pageIndex;
- (UIImage* _Nullable)imageMaskForPage:(NSUInteger)pageIndex;

- (void)setScrollViewContentOffsetForCurrentPage:(UIScrollView* _Nonnull)scrollView animated:(BOOL)animated;
- (void)updatePageNumberForScrollView:(UIScrollView* _Nonnull)scrollView;

- (void)setName:(NSString* _Nullable)name forPage:(NSUInteger)pageIndex;
- (NSString* _Nullable)nameForPage:(NSUInteger)pageIndex;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
