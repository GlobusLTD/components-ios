/*--------------------------------------------------*/

#import "GLBPageControl.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

typedef NS_ENUM(NSUInteger, GLBPageControlImageType) {
	GLBPageControlImageTypeNormal = 1,
	GLBPageControlImageTypeCurrent,
	GLBPageControlImageTypeMask
};

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface GLBPageControl () {
@private
    NSUInteger _displayedPage;
    CGFloat _measuredIndicatorWidth;
    CGFloat	_measuredIndicatorHeight;
    CGImageRef _pageImageMask;
}

@property(nonatomic, readonly, strong) NSMutableDictionary* pageNames;
@property(nonatomic, readonly, strong) NSMutableDictionary* pageImages;
@property(nonatomic, readonly, strong) NSMutableDictionary* currentPageImages;
@property(nonatomic, readonly, strong) NSMutableDictionary* pageImageMasks;
@property(nonatomic, readonly, strong) NSMutableDictionary* cgImageMasks;
@property(nonatomic, strong) NSArray* pageRects;
@property(nonatomic, strong) UIPageControl* accessibilityPageControl;

- (void)_setCurrentPage:(NSUInteger)currentPage sendAction:(BOOL)sendAction canDefer:(BOOL)defer;

- (CGFloat)_leftOffset;
- (CGFloat)_topOffsetForHeight:(CGFloat)height rect:(CGRect)rect;
- (void)_setImage:(UIImage*)image forPage:(NSUInteger)pageIndex type:(GLBPageControlImageType)type;
- (id)_imageForPage:(NSUInteger)pageIndex type:(GLBPageControlImageType)type;
- (CGImageRef)_createMaskForImage:(UIImage*)image CF_RETURNS_RETAINED;
- (void)_updateMeasuredIndicatorSizeWithSize:(CGSize)size;
- (void)_updateMeasuredIndicatorSizes;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBPageControl

#pragma mark - Synthesize

@synthesize pageNames = _pageNames;
@synthesize pageImages = _pageImages;
@synthesize currentPageImages = _currentPageImages;
@synthesize pageImageMasks = _pageImageMasks;
@synthesize cgImageMasks = _cgImageMasks;

#pragma mark - Init / Free

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _indicatorDiameter = 7.0;
    _indicatorMargin = 14.0;
    _minHeight = 36.0;
    _alignment = GLBPageControlAlignmentCenter;
    _verticalAlignment = GLBPageControlVerticalAlignmentMiddle;
    _pageIndicatorTintColor = [UIColor colorWithWhite:0.8f alpha:0.5f];
    _currentPageIndicatorTintColor = [UIColor colorWithWhite:0.5f alpha:0.5f];
    _tapBehavior = GLBPageControlTapBehaviorStep;
    
    self.backgroundColor = [UIColor clearColor];
    self.contentMode = UIViewContentModeRedraw;
    self.isAccessibilityElement = YES;
    self.accessibilityTraits = UIAccessibilityTraitUpdatesFrequently;
    _accessibilityPageControl = [[UIPageControl alloc] init];
}

- (void)dealloc {
	if(_pageImageMask != nil) {
		CGImageRelease(_pageImageMask);
	}	
}

#pragma mark - Property

- (void)setIndicatorDiameter:(CGFloat)indicatorDiameter {
    if(_indicatorDiameter != indicatorDiameter) {
        _indicatorDiameter = indicatorDiameter;
        if(_minHeight < indicatorDiameter) {
            _minHeight = indicatorDiameter;
        }
        [self _updateMeasuredIndicatorSizes];
        [self setNeedsDisplay];
    }
}

- (void)setIndicatorMargin:(CGFloat)indicatorMargin {
    if(_indicatorMargin != indicatorMargin) {
        _indicatorMargin = indicatorMargin;
        [self setNeedsDisplay];
    }
}

- (void)setMinHeight:(CGFloat)minHeight {
    if(minHeight < _indicatorDiameter) {
        minHeight = _indicatorDiameter;
    }
    if(_minHeight != minHeight) {
        _minHeight = minHeight;
        if([self respondsToSelector:@selector(invalidateIntrinsicContentSize)] == YES) {
            [self invalidateIntrinsicContentSize];
        }
        [self setNeedsLayout];
    }
}

- (void)setNumberOfPages:(NSUInteger)numberOfPages {
    if(_numberOfPages != numberOfPages) {
        _accessibilityPageControl.numberOfPages = (NSInteger)_numberOfPages;
        if([self respondsToSelector:@selector(invalidateIntrinsicContentSize)] == YES) {
            [self invalidateIntrinsicContentSize];
        }
        [self updateAccessibilityValue];
        [self setNeedsDisplay];
    }
}

- (void)setCurrentPage:(NSUInteger)currentPage {
    [self _setCurrentPage:currentPage sendAction:NO canDefer:NO];
}

- (void)setCurrentPageIndicatorImage:(UIImage*)currentPageIndicatorImage {
    if([currentPageIndicatorImage isEqual:_currentPageIndicatorImage] == NO) {
        _currentPageIndicatorImage = currentPageIndicatorImage;
        [self _updateMeasuredIndicatorSizes];
        [self setNeedsDisplay];
    }
}

- (void)setPageIndicatorImage:(UIImage*)pageIndicatorImage {
    if([pageIndicatorImage isEqual:_pageIndicatorImage] == NO) {
        _pageIndicatorImage = pageIndicatorImage;
        [self _updateMeasuredIndicatorSizes];
        [self setNeedsDisplay];
    }
}

- (void)setPageIndicatorMaskImage:(UIImage*)pageIndicatorMaskImage {
    if([pageIndicatorMaskImage isEqual:_pageIndicatorMaskImage] == NO) {
        _pageIndicatorMaskImage = pageIndicatorMaskImage;
        if(_pageImageMask != NULL) {
            CGImageRelease(_pageImageMask);
        }
        _pageImageMask = [self _createMaskForImage:_pageIndicatorMaskImage];
        [self _updateMeasuredIndicatorSizes];
        [self setNeedsDisplay];
    }
}

- (NSMutableDictionary*)pageNames {
    if(_pageNames == nil) {
        _pageNames = [[NSMutableDictionary alloc] init];
    }
    return _pageNames;
}

- (NSMutableDictionary*)pageImages {
    if(_pageImages == nil) {
        _pageImages = [[NSMutableDictionary alloc] init];
    }
    return _pageImages;
}

- (NSMutableDictionary*)currentPageImages {
    if(_currentPageImages == nil) {
        _currentPageImages = [[NSMutableDictionary alloc] init];
    }
    return _currentPageImages;
}

- (NSMutableDictionary*)pageImageMasks {
    if(_pageImageMasks == nil) {
        _pageImageMasks = [[NSMutableDictionary alloc] init];
    }
    return _pageImageMasks;
}

- (NSMutableDictionary*)cgImageMasks {
    if(_cgImageMasks == nil) {
        _cgImageMasks = [[NSMutableDictionary alloc] init];
    }
    return _cgImageMasks;
}

#pragma mark - Public override

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setNeedsDisplay];
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize sizeThatFits = [self sizeForNumberOfPages:_numberOfPages];
    sizeThatFits.height = MAX(sizeThatFits.height, _minHeight);
    return sizeThatFits;
}

- (CGSize)intrinsicContentSize {
    if((_numberOfPages < 1) || ((_numberOfPages < 2) && (_hidesForSinglePage == YES))) {
        return CGSizeMake(UIViewNoIntrinsicMetric, 0.0);
    }
    return CGSizeMake(UIViewNoIntrinsicMetric, MAX(_measuredIndicatorHeight, _minHeight));
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
    NSMutableArray* pageRects = [NSMutableArray arrayWithCapacity:_numberOfPages];
    if((_hidesForSinglePage == NO) && (_numberOfPages >= 2)) {
        CGFloat left = [self _leftOffset];
        CGFloat xOffset = left;
        CGFloat yOffset = 0.0;
        UIColor *fillColor = nil;
        UIImage *image = nil;
        CGImageRef maskingImage = nil;
        CGSize maskSize = CGSizeZero;
        for(NSUInteger i = 0; i < _numberOfPages; i++) {
            NSNumber* indexNumber = @(i);
            if(i == _displayedPage) {
                fillColor = _currentPageIndicatorTintColor ? _currentPageIndicatorTintColor : [UIColor whiteColor];
                image = _currentPageImages[indexNumber];
                if(image == nil) {
                    image = _currentPageIndicatorImage;
                }
            } else {
                fillColor = _pageIndicatorTintColor ? _pageIndicatorTintColor : [[UIColor whiteColor] colorWithAlphaComponent:0.3f];
                image = _pageImages[indexNumber];
                if(image == nil) {
                    image = _pageIndicatorImage;
                }
            }
            if(image == nil) {
                maskingImage = (__bridge CGImageRef)_cgImageMasks[indexNumber];
                UIImage* originalImage = _pageImageMasks[indexNumber];
                maskSize = originalImage.size;
                if(maskingImage == nil) {
                    maskingImage = _pageImageMask;
                    maskSize = _pageIndicatorMaskImage.size;
                }
            }
            [fillColor set];
            CGRect indicatorRect;
            if(image != nil) {
                yOffset = [self _topOffsetForHeight:image.size.height rect:rect];
                CGFloat centeredXOffset = xOffset + floorf((_measuredIndicatorWidth - image.size.width) / 2);
                [image drawAtPoint:CGPointMake(centeredXOffset, yOffset)];
                indicatorRect = CGRectMake(centeredXOffset, yOffset, image.size.width, image.size.height);
            } else if(maskingImage != nil) {
                yOffset = [self _topOffsetForHeight:maskSize.height rect:rect];
                CGFloat centeredXOffset = xOffset + floorf((_measuredIndicatorWidth - maskSize.width) / 2);
                indicatorRect = CGRectMake(centeredXOffset, yOffset, maskSize.width, maskSize.height);
                CGContextDrawImage(context, indicatorRect, maskingImage);
            } else {
                yOffset = [self _topOffsetForHeight:_indicatorDiameter rect:rect];
                CGFloat centeredXOffset = xOffset + floorf((_measuredIndicatorWidth - _indicatorDiameter) / 2);
                indicatorRect = CGRectMake(centeredXOffset, yOffset, _indicatorDiameter, _indicatorDiameter);
                CGContextFillEllipseInRect(context, indicatorRect);
            }
            [pageRects addObject:[NSValue valueWithCGRect:indicatorRect]];
            maskingImage = NULL;
            xOffset += _measuredIndicatorWidth + _indicatorMargin;
        }
        _pageRects = pageRects;
    }
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if(_tapBehavior == GLBPageControlTapBehaviorJump) {
        __block NSUInteger tappedIndicatorIndex = NSNotFound;
        [_pageRects enumerateObjectsUsingBlock:^(NSValue *value, NSUInteger index, BOOL *stop) {
            CGRect indicatorRect = [value CGRectValue];
            if(CGRectContainsPoint(indicatorRect, point)) {
                tappedIndicatorIndex = index;
                *stop = YES;
            }
        }];
        if(tappedIndicatorIndex != NSNotFound) {
            [self _setCurrentPage:tappedIndicatorIndex sendAction:YES canDefer:YES];
            return;
        }
    }
    CGSize size = [self sizeForNumberOfPages:_numberOfPages];
    CGFloat left = [self _leftOffset];
    CGFloat middle = left + (size.width / 2);
    if(point.x < middle) {
        [self _setCurrentPage:_currentPage - 1 sendAction:YES canDefer:YES];
    } else {
        [self _setCurrentPage:_currentPage + 1 sendAction:YES canDefer:YES];
    }
}

#pragma mark - Private

- (void)_setCurrentPage:(NSUInteger)currentPage sendAction:(BOOL)sendAction canDefer:(BOOL)defer {
    currentPage = MIN(currentPage, _numberOfPages - 1);
    if(_currentPage != currentPage) {
        _currentPage = currentPage;
        _accessibilityPageControl.currentPage = (NSInteger)_currentPage;
        [self updateAccessibilityValue];
        if((_defersCurrentPageDisplay == NO) || (defer == NO)) {
            _displayedPage = _currentPage;
            [self setNeedsDisplay];
        }
        if(sendAction == YES) {
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
    }
}

- (CGFloat)_leftOffset {
	CGRect rect = self.bounds;
	CGSize size = [self sizeForNumberOfPages:_numberOfPages];
	CGFloat left = 0.0;
	switch(_alignment) {
		case GLBPageControlAlignmentCenter: left = ceilf(CGRectGetMidX(rect) - (size.width / 2)); break;
		case GLBPageControlAlignmentRight: left = CGRectGetMaxX(rect) - size.width; break;
		default: break;
	}
	return left;
}

- (CGFloat)_topOffsetForHeight:(CGFloat)height rect:(CGRect)rect {
	CGFloat top = 0.0;
	switch(_verticalAlignment) {
		case GLBPageControlVerticalAlignmentMiddle: top = CGRectGetMidY(rect) - (height / 2); break;
		case GLBPageControlVerticalAlignmentBottom: top = CGRectGetMaxY(rect) - height; break;
		default: break;
	}
	return top;
}

- (void)_setImage:(UIImage*)image forPage:(NSUInteger)pageIndex type:(GLBPageControlImageType)type {
    if(pageIndex < _numberOfPages) {
        NSMutableDictionary* dictionary = nil;
        switch(type) {
            case GLBPageControlImageTypeCurrent: dictionary = _currentPageImages; break;
            case GLBPageControlImageTypeNormal: dictionary = _pageImages; break;
            case GLBPageControlImageTypeMask: dictionary = _pageImageMasks; break;
            default: break;
        }
        if(image != nil) {
            dictionary[@(pageIndex)] = image;
        } else {
            [dictionary removeObjectForKey:@(pageIndex)];
        }
    }
}

- (id)_imageForPage:(NSUInteger)pageIndex type:(GLBPageControlImageType)type {
    if(pageIndex < _numberOfPages) {
        NSDictionary* dictionary = nil;
        switch(type) {
            case GLBPageControlImageTypeCurrent: dictionary = _currentPageImages; break;
            case GLBPageControlImageTypeNormal: dictionary = _pageImages; break;
            case GLBPageControlImageTypeMask: dictionary = _pageImageMasks; break;
            default: break;
        }
        return dictionary[@(pageIndex)];
    }
    return nil;
}

- (CGImageRef)_createMaskForImage:(UIImage*)image CF_RETURNS_RETAINED {
    CGImageRef maskImage = NULL;
    size_t pixelsWide = (size_t)(image.size.width * image.scale);
    size_t pixelsHigh = (size_t)(image.size.height * image.scale);
    size_t bitmapBytesPerRow = (pixelsWide * 1);
    CGContextRef context = CGBitmapContextCreate(NULL, pixelsWide, pixelsHigh, CGImageGetBitsPerComponent(image.CGImage), bitmapBytesPerRow, NULL, (CGBitmapInfo)kCGImageAlphaOnly);
    if(context != nil) {
        CGContextTranslateCTM(context, 0.f, pixelsHigh);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextDrawImage(context, CGRectMake(0, 0, pixelsWide, pixelsHigh), image.CGImage);
        maskImage = CGBitmapContextCreateImage(context);
        CGContextRelease(context);
    }
    return maskImage;
}

- (void)_updateMeasuredIndicatorSizeWithSize:(CGSize)size {
    _measuredIndicatorWidth = MAX(_measuredIndicatorWidth, size.width);
    _measuredIndicatorHeight = MAX(_measuredIndicatorHeight, size.height);
}

- (void)_updateMeasuredIndicatorSizes {
    _measuredIndicatorWidth = _indicatorDiameter;
    _measuredIndicatorHeight = _indicatorDiameter;
    if(((_pageIndicatorImage != nil) || (_pageIndicatorMaskImage != nil)) && (_currentPageIndicatorImage != nil)) {
        _measuredIndicatorWidth = 0;
        _measuredIndicatorHeight = 0;
    }
    if(_pageIndicatorImage != nil) {
        [self _updateMeasuredIndicatorSizeWithSize:_pageIndicatorImage.size];
    }
    if(_currentPageIndicatorImage != nil) {
        [self _updateMeasuredIndicatorSizeWithSize:_currentPageIndicatorImage.size];
    }
    if(_pageIndicatorMaskImage != nil) {
        [self _updateMeasuredIndicatorSizeWithSize:_pageIndicatorMaskImage.size];
    }
    if([self respondsToSelector:@selector(invalidateIntrinsicContentSize)] == YES) {
        [self invalidateIntrinsicContentSize];
    }
}

#pragma mark - Public

- (void)updateCurrentPageDisplay {
	_displayedPage = _currentPage;
	[self setNeedsDisplay];
}

- (CGRect)rectForPageIndicator:(NSUInteger)pageIndex {
    if(pageIndex < _numberOfPages) {
        CGFloat left = [self _leftOffset];
        CGSize size = [self sizeForNumberOfPages:pageIndex + 1];
        return CGRectMake(left + size.width - _measuredIndicatorWidth, 0, _measuredIndicatorWidth, _measuredIndicatorWidth);
    }
    return CGRectZero;
}

- (CGSize)sizeForNumberOfPages:(NSUInteger)pageCount {
	CGFloat marginSpace = (pageCount - 1) * _indicatorMargin;
	CGFloat indicatorSpace = pageCount * _measuredIndicatorWidth;
	CGSize size = CGSizeMake(marginSpace + indicatorSpace, _measuredIndicatorHeight);
	return size;
}

- (void)setImage:(UIImage*)image forPage:(NSUInteger)pageIndex {
    [self _setImage:image forPage:pageIndex type:GLBPageControlImageTypeNormal];
	[self _updateMeasuredIndicatorSizes];
}

- (UIImage*)imageForPage:(NSUInteger)pageIndex {
    return [self _imageForPage:pageIndex type:GLBPageControlImageTypeNormal];
}

- (void)setCurrentImage:(UIImage*)image forPage:(NSUInteger)pageIndex {
	[self _setImage:image forPage:pageIndex type:GLBPageControlImageTypeCurrent];;
	[self _updateMeasuredIndicatorSizes];
}

- (UIImage*)currentImageForPage:(NSUInteger)pageIndex {
    return [self _imageForPage:pageIndex type:GLBPageControlImageTypeCurrent];
}

- (void)setImageMask:(UIImage*)image forPage:(NSUInteger)pageIndex {
	[self _setImage:image forPage:pageIndex type:GLBPageControlImageTypeMask];
	if(image != nil) {
        CGImageRef maskImage = [self _createMaskForImage:image];
        if(maskImage != nil) {
            _cgImageMasks[@(pageIndex)] = (__bridge id)maskImage;
            CGImageRelease(maskImage);
            [self _updateMeasuredIndicatorSizeWithSize:image.size];
            [self setNeedsDisplay];
        }
    } else {
		[_cgImageMasks removeObjectForKey:@(pageIndex)];
	}
}

- (UIImage*)imageMaskForPage:(NSUInteger)pageIndex {
	return [self _imageForPage:pageIndex type:GLBPageControlImageTypeMask];
}

- (void)setScrollViewContentOffsetForCurrentPage:(UIScrollView*)scrollView animated:(BOOL)animated {
    CGPoint offset = scrollView.contentOffset;
    offset.x = scrollView.bounds.size.width * _currentPage;
    [scrollView setContentOffset:offset animated:animated];
}

- (void)updatePageNumberForScrollView:(UIScrollView*)scrollView {
    CGSize boundsSize = scrollView.bounds.size;
    self.numberOfPages = (NSUInteger)floorf(scrollView.contentSize.width / boundsSize.width);
    NSUInteger currentPage = (NSUInteger)floorf(scrollView.contentOffset.x / boundsSize.width);
    [self _setCurrentPage:currentPage sendAction:YES canDefer:NO];
}

#pragma mark - UIAccessibility

- (void)setName:(NSString*)name forPage:(NSUInteger)pageIndex {
    if(pageIndex < _numberOfPages) {
        _pageNames[@(pageIndex)] = name;
	}
}

- (NSString*)nameForPage:(NSUInteger)pageIndex {
    if(pageIndex < _numberOfPages) {
        return _pageNames[@(pageIndex)];
    }
    return nil;
}

- (void)updateAccessibilityValue {
	NSString* pageName = [self nameForPage:_currentPage];
	NSString* accessibilityValue = _accessibilityPageControl.accessibilityValue;
	if(pageName != nil) {
		self.accessibilityValue = [NSString stringWithFormat:@"%@ - %@", pageName, accessibilityValue];
	} else {
		self.accessibilityValue = accessibilityValue;
	}
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
