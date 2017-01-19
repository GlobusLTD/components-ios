/*--------------------------------------------------*/

#import "GLBImageCropViewController.h"
#import "GLBTouchView.h"

/*--------------------------------------------------*/

#import "UIDevice+GLBUI.h"
#import "UIButton+GLBUI.h"
#import "UIImage+GLBUI.h"

/*--------------------------------------------------*/

#include "GLBLineSegment.h"
#include "GLBPoint.h"
#include "GLBRect.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBImageScrollView : UIScrollView {
    CGSize _imageSize;
    CGPoint _pointToCenterAfterResize;
    CGFloat _scaleToRestoreAfterResize;
}

@property(nonatomic, readwrite, strong) UIImageView* zoomView;
@property(nonatomic, readwrite, assign) BOOL aspectFill;

- (void)__displayImage:(UIImage*)image;
- (void)__centerZoomView;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface GLBImageCropViewController () < UIScrollViewDelegate, UIGestureRecognizerDelegate >

@property(nonatomic, readwrite, strong) GLBImageScrollView* scrollView;
@property(nonatomic, readwrite, strong) GLBTouchView* overlayView;
@property(nonatomic, readwrite, strong) CAShapeLayer* maskLayer;

@property(nonatomic, readwrite, strong) UITapGestureRecognizer* doubleTapGestureRecognizer;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

static const CGFloat GLBImageCropController_PortraitCircleInsets = 15.0f;
static const CGFloat GLBImageCropController_PortraitSquareInsets = 20.0f;
static const CGFloat GLBImageCropController_PortraitTitleLabelVerticalMargin = 64.0f;
static const CGFloat GLBImageCropController_PortraitButtonsHorizontalMargin = 13.0f;
static const CGFloat GLBImageCropController_PortraitButtonsVerticalMargin = 21.0f;

static const CGFloat GLBImageCropController_LandscapeCircleInsets = 45.0f;
static const CGFloat GLBImageCropController_LandscapeSquareInsets = 45.0f;
static const CGFloat GLBImageCropController_LandscapeTitleLabelVerticalMargin = 12.0f;
static const CGFloat GLBImageCropController_LandscapeButtonsHorizontalMargin = 13.0f;
static const CGFloat GLBImageCropController_LandscapeButtonsVerticalMargin = 12.0f;

static const CGFloat GLBImageCropController_ResetDuration = 0.4f;
static const CGFloat GLBImageCropController_ScrollDuration = 0.25f;

/*--------------------------------------------------*/

@implementation GLBImageCropViewController

#pragma mark Synthesize

@synthesize titleLabel = _titleLabel;
@synthesize choiceButton = _choiceButton;
@synthesize cancelButton = _cancelButton;

#pragma mark - Not designated initializer

GLB_IMPLEMENTATION_NOT_DESIGNATED_INITIALIZER(init)

#pragma mark Init / Free

- (instancetype)initWithImage:(UIImage*)image {
    return [self initWithImage:image cropMode:GLBImageCropModeCircle];
}

- (instancetype)initWithImage:(UIImage*)image cropMode:(GLBImageCropMode)cropMode {
    self = [super init];
    if(self != nil) {
        _image = image;
        _cropMode = cropMode;
    }
    return self;
}

- (void)setup {
    [super setup];
    
    self.statusBarStyle = UIStatusBarStyleLightContent;
    
    _maskColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.7f];
    _avoidEmptySpaceAroundImage = YES;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.blackColor;
    self.view.clipsToBounds = YES;
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.overlayView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.cancelButton];
    [self.view addSubview:self.choiceButton];
    
    [self.view addGestureRecognizer:self.doubleTapGestureRecognizer];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self __updateMask];
    [self __layoutImageScrollView];
    [self __layoutOverlayView];
    
    CGRect bounds = self.view.bounds;
    BOOL isPortrait = [self __isPortrait];
    CGFloat titleLabelVerticalMargin = (isPortrait == YES) ? GLBImageCropController_PortraitTitleLabelVerticalMargin : GLBImageCropController_LandscapeTitleLabelVerticalMargin;
    CGFloat buttonsHorizontalMargin = (isPortrait == YES) ? GLBImageCropController_PortraitButtonsHorizontalMargin : GLBImageCropController_LandscapeButtonsHorizontalMargin;
    CGFloat buttonsVerticalMargin = (isPortrait == YES) ? GLBImageCropController_PortraitButtonsVerticalMargin : GLBImageCropController_LandscapeButtonsVerticalMargin;
    
    _titleLabel.glb_framePosition = CGPointMake((bounds.origin.x + (bounds.size.width * 0.5f)) - (_titleLabel.glb_frameWidth * 0.5f), bounds.origin.y + titleLabelVerticalMargin);
    _cancelButton.glb_framePosition = CGPointMake(bounds.origin.x + buttonsHorizontalMargin, (bounds.origin.y + bounds.size.height) - (_cancelButton.glb_frameHeight + buttonsVerticalMargin));
    _choiceButton.glb_framePosition = CGPointMake((bounds.origin.x + bounds.size.width) - (_choiceButton.glb_frameWidth + buttonsHorizontalMargin), (bounds.origin.y + bounds.size.height) - (_cancelButton.glb_frameHeight + buttonsVerticalMargin));
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if(_scrollView.zoomView == nil) {
        [self __displayImage];
    }
}

#pragma mark - Property

- (CGRect)cropRect {
    CGFloat zoom = 1.0f / _scrollView.zoomScale;
    CGPoint offset = _scrollView.contentOffset;
    CGSize boundsSize = _scrollView.glb_boundsSize;
    CGFloat x = GLB_ROUND(offset.x * zoom);
    CGFloat y = GLB_ROUND(offset.y * zoom);
    CGFloat w = GLB_CEIL(boundsSize.width * zoom);
    CGFloat h = GLB_CEIL(boundsSize.height * zoom);
    return CGRectIntegral(CGRectMake(x, y, w, h));
}

- (CGFloat)angle {
    CGAffineTransform transform = _scrollView.transform;
    return GLB_ATAN2(transform.b, transform.a);
}

- (CGFloat)scale {
    return _scrollView.zoomScale;
}

- (void)setAvoidEmptySpaceAroundImage:(BOOL)avoidEmptySpaceAroundImage {
    if(_avoidEmptySpaceAroundImage != avoidEmptySpaceAroundImage) {
        _avoidEmptySpaceAroundImage = avoidEmptySpaceAroundImage;
        if(_scrollView != nil) {
            _scrollView.aspectFill = _avoidEmptySpaceAroundImage;
        }
    }
}

- (void)setImage:(UIImage*)image {
    if([_image isEqual:image] == NO) {
        _image = image;
        if(self.isViewLoaded == YES) {
            [self __displayImage];
        }
    }
}

- (GLBImageScrollView*)scrollView {
    if(_scrollView == nil) {
        _scrollView = [[GLBImageScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.aspectFill = _avoidEmptySpaceAroundImage;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (GLBTouchView*)overlayView {
    if(_overlayView == nil) {
        _overlayView = [[GLBTouchView alloc] initWithFrame:self.view.bounds];
        _overlayView.receiver = _scrollView;
        [_overlayView.layer addSublayer:self.maskLayer];
    }
    return _overlayView;
}

- (CAShapeLayer*)maskLayer {
    if(_maskLayer == nil) {
        _maskLayer = [CAShapeLayer layer];
        _maskLayer.fillRule = kCAFillRuleEvenOdd;
        _maskLayer.fillColor = _maskColor.CGColor;
    }
    return _maskLayer;
}

- (GLBLabel*)titleLabel {
    if(_titleLabel == nil) {
        _titleLabel = [GLBLabel new];
        _titleLabel.backgroundColor = UIColor.clearColor;
        _titleLabel.text = NSLocalizedString(@"Move and Scale", @"Move and Scale label");
        _titleLabel.textColor = UIColor.whiteColor;
        _titleLabel.opaque = NO;
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (GLBButton*)cancelButton {
    if(_cancelButton == nil) {
        _cancelButton = [GLBButton new];
        _cancelButton.glb_normalTitle = NSLocalizedString(@"Cancel", @"Cancel button");
        _cancelButton.glb_normalTitleColor = UIColor.whiteColor;
        _cancelButton.opaque = NO;
        
        [_cancelButton addTarget:self action:@selector(__pressedCancel:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton sizeToFit];
    }
    return _cancelButton;
}

- (GLBButton*)choiceButton {
    if(_choiceButton == nil) {
        _choiceButton = [GLBButton new];
        _choiceButton.glb_normalTitle = NSLocalizedString(@"Choice", @"Choice button");
        _choiceButton.glb_normalTitleColor = UIColor.whiteColor;
        _choiceButton.opaque = NO;
        
        [_choiceButton addTarget:self action:@selector(__pressedChoice:) forControlEvents:UIControlEventTouchUpInside];
        [_choiceButton sizeToFit];
    }
    return _choiceButton;
}

- (UITapGestureRecognizer*)doubleTapGestureRecognizer {
    if(_doubleTapGestureRecognizer == nil) {
        _doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handleDoubleTap:)];
        _doubleTapGestureRecognizer.numberOfTapsRequired = 2;
        _doubleTapGestureRecognizer.delaysTouchesEnded = NO;
        _doubleTapGestureRecognizer.delegate = self;
    }
    return _doubleTapGestureRecognizer;
}

#pragma mark - Actions

- (void)__pressedCancel:(id)sender {
    [self __cancelCrop];
}

- (void)__pressedChoice:(id)sender {
    [self __cropImage];
}

- (void)__handleDoubleTap:(id)gestureRecognizer {
    [self __reset:YES];
}

- (void)__handleRotation:(UIRotationGestureRecognizer*)gestureRecognizer {
    [self __applyAngle:([self angle] + gestureRecognizer.rotation)];
    gestureRecognizer.rotation = 0;
    
    if(gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:GLBImageCropController_ScrollDuration delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            [self __layoutImageScrollView];
        } completion:nil];
    }
}

#pragma mark - Private

- (BOOL)__isPortrait {
    if([UIDevice glb_compareSystemVersion:@"8.0"] != NSOrderedAscending) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return UIInterfaceOrientationIsPortrait(self.interfaceOrientation);
#pragma clang diagnostic pop
    }
    return UIInterfaceOrientationIsPortrait(UIApplication.sharedApplication.statusBarOrientation);
}

- (void)__reset:(BOOL)animated {
    if(animated == YES) {
        [UIView beginAnimations:@"reset" context:NULL];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:GLBImageCropController_ResetDuration];
        [UIView setAnimationBeginsFromCurrentState:YES];
    }
    [self __resetRotation];
    [self __resetFrame];
    [self __resetZoomScale];
    [self __resetContentOffset];
    if(animated == YES) {
        [UIView commitAnimations];
    }
}

- (void)__resetContentOffset {
    CGSize boundsSize = _scrollView.bounds.size;
    CGRect zoomFrame = _scrollView.zoomView.frame;
    CGPoint contentOffset;
    if(zoomFrame.size.width > boundsSize.width) {
        contentOffset.x = (zoomFrame.size.width - boundsSize.width) * 0.5f;
    } else {
        contentOffset.x = 0.0f;
    }
    if(zoomFrame.size.height > boundsSize.height) {
        contentOffset.y = (zoomFrame.size.height - boundsSize.height) * 0.5f;
    } else {
        contentOffset.y = 0.0f;
    }
    _scrollView.contentOffset = contentOffset;
}

- (void)__resetFrame {
    [self __layoutImageScrollView];
}

- (void)__resetRotation {
    [self __applyAngle:0.0];
}

- (void)__resetZoomScale {
    CGSize boundsSize = self.view.bounds.size;
    CGSize imageSize = _image.size;
    CGFloat zoomScale;
    if(boundsSize.width > boundsSize.height) {
        zoomScale = boundsSize.height / imageSize.height;
    } else {
        zoomScale = boundsSize.width / imageSize.width;
    }
    _scrollView.zoomScale = zoomScale;
}

- (void)__applyAngle:(CGFloat)angle {
    _scrollView.transform = CGAffineTransformRotate(_scrollView.transform, (angle - [self angle]));
}

- (NSArray*)__intersectionPointsOfLineSegment:(GLBLineSegment)lineSegment withRect:(CGRect)rect {
    CGPoint tl = GLBRectGetTopLeftPoint(rect);
    CGPoint tr = GLBRectGetTopRightPoint(rect);
    CGPoint bl = GLBRectGetBottomLeftPoint(rect);
    CGPoint br = GLBRectGetBottomRightPoint(rect);
    GLBLineSegment ts = GLBLineSegmentMake(tl, tr);
    GLBLineSegment rs = GLBLineSegmentMake(tr, br);
    GLBLineSegment bs = GLBLineSegmentMake(br, bl);
    GLBLineSegment ls = GLBLineSegmentMake(bl, tl);
    CGPoint p0 = GLBLineSegmentIntersection(ts, lineSegment);
    CGPoint p1 = GLBLineSegmentIntersection(rs, lineSegment);
    CGPoint p2 = GLBLineSegmentIntersection(bs, lineSegment);
    CGPoint p3 = GLBLineSegmentIntersection(ls, lineSegment);
    NSMutableArray* intersectionPoints = [NSMutableArray array];
    if(GLBPointIsInfinity(p0) == NO) {
        [intersectionPoints addObject:[NSValue valueWithCGPoint:p0]];
    }
    if(GLBPointIsInfinity(p1) == NO) {
        [intersectionPoints addObject:[NSValue valueWithCGPoint:p1]];
    }
    if(GLBPointIsInfinity(p2) == NO) {
        [intersectionPoints addObject:[NSValue valueWithCGPoint:p2]];
    }
    if(GLBPointIsInfinity(p3) == NO) {
        [intersectionPoints addObject:[NSValue valueWithCGPoint:p3]];
    }
    return intersectionPoints;
}

- (void)__displayImage {
    if(_image != nil) {
        [_scrollView __displayImage:_image];
        [self __reset:NO];
    }
}

- (void)__layoutImageScrollView {
    CGRect frame = CGRectZero;
    switch(_cropMode) {
        case GLBImageCropModeSquare: {
            CGFloat angle = [self angle];
            if(angle == 0.0f) {
                frame = _maskRect;
            } else {
                CGFloat rotation = GLB_FABS(angle);
                CGRect initialRect = _maskRect;
                CGPoint leftTopPoint = CGPointMake(initialRect.origin.x, initialRect.origin.y);
                CGPoint leftBottomPoint = CGPointMake(initialRect.origin.x, initialRect.origin.y + initialRect.size.height);
                CGPoint pivot = GLBRectGetCenterPoint(initialRect);
                GLBLineSegment leftLineSegment = GLBLineSegmentMake(leftTopPoint, leftBottomPoint);
                GLBLineSegment rotatedLeftLineSegment = GLBLineSegmentRotateAroundPoint(leftLineSegment, pivot, rotation);
                NSArray* points = [self __intersectionPointsOfLineSegment:rotatedLeftLineSegment withRect:initialRect];
                if(points.count > 1) {
                    if((rotation > M_PI_2) && (rotation < M_PI)) {
                        rotation = rotation - M_PI_2;
                    } else if((rotation > (M_PI + M_PI_2)) && (rotation < (M_PI + M_PI))) {
                        rotation = rotation - (M_PI + M_PI_2);
                    }
                    CGFloat sinAlpha = GLB_SIN(rotation);
                    CGFloat cosAlpha = GLB_COS(rotation);
                    CGFloat hypotenuse = GLBPointDistance([points[0] CGPointValue], [points[1] CGPointValue]);
                    CGFloat altitude = hypotenuse * sinAlpha * cosAlpha;
                    CGFloat initialWidth = initialRect.size.width;
                    CGFloat targetWidth = initialWidth + altitude * 2.0f;
                    CGFloat scale = targetWidth / initialWidth;
                    CGPoint center = GLBRectGetCenterPoint(initialRect);
                    frame = GLBRectScaleAroundPoint(initialRect, center, scale, scale);
                    frame.origin.x = round(CGRectGetMinX(frame));
                    frame.origin.y = round(CGRectGetMinY(frame));
                    frame = CGRectIntegral(frame);
                } else {
                    frame = initialRect;
                }
            }
            break;
        }
        case GLBImageCropModeCircle: {
            frame = _maskRect;
            break;
        }
    }
    
    CGAffineTransform transform = _scrollView.transform;
    _scrollView.transform = CGAffineTransformIdentity;
    _scrollView.frame = frame;
    _scrollView.transform = transform;
}

- (void)__layoutOverlayView {
    CGSize boundsSize = self.view.bounds.size;
    _overlayView.frame = CGRectMake(0, 0, boundsSize.width * 2.0f, boundsSize.height * 2.0f);
}

- (void)__updateMask {
    CGSize boundsSize = self.view.bounds.size;
    switch(_cropMode) {
        case GLBImageCropModeCircle: {
            CGFloat diameter;
            if([self __isPortrait] == YES) {
                diameter = MIN(boundsSize.width, boundsSize.height) - GLBImageCropController_PortraitCircleInsets * 2;
            } else {
                diameter = MIN(boundsSize.width, boundsSize.height) - GLBImageCropController_LandscapeCircleInsets * 2;
            }
            _maskRect = CGRectMake((boundsSize.width - diameter) * 0.5f, (boundsSize.height - diameter) * 0.5f, diameter, diameter);
            _maskPath = [UIBezierPath bezierPathWithOvalInRect:_maskRect];
            break;
        }
        case GLBImageCropModeSquare: {
            CGFloat length;
            if([self __isPortrait] == YES) {
                length = MIN(boundsSize.width, boundsSize.height) - GLBImageCropController_PortraitSquareInsets * 2;
            } else {
                length = MIN(boundsSize.width, boundsSize.height) - GLBImageCropController_LandscapeSquareInsets * 2;
            }
            _maskRect = CGRectMake((boundsSize.width - length) * 0.5f, (boundsSize.height - length) * 0.5f, length, length);
            _maskPath = [UIBezierPath bezierPathWithRect:_maskRect];
            break;
        }
    }
    UIBezierPath* clipPath = [UIBezierPath bezierPathWithRect:_overlayView.frame];
    clipPath.usesEvenOddFillRule = YES;
    [clipPath appendPath:_maskPath];
    
    CABasicAnimation* pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.timingFunction = [CATransaction animationTimingFunction];
    pathAnimation.duration = [CATransaction animationDuration];
    [_maskLayer addAnimation:pathAnimation forKey:@"path"];
    
    _maskLayer.path = [clipPath CGPath];
}

- (void)__cropImage {
    UIImage* image = _image;
    GLBImageCropMode cropMode = _cropMode;
    CGRect cropRect = [self cropRect];
    CGFloat zoom = _scrollView.zoomScale;
    UIBezierPath* maskPath = _maskPath;
    GLBImageCropViewControllerChoiceBlock choiceBlock = [_choiceBlock copy];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage* croppedImage = [self.class __croppedImage:image cropMode:cropMode cropRect:cropRect zoom:zoom maskPath:maskPath];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(choiceBlock != nil) {
                choiceBlock(self, croppedImage);
            }
        });
    });
}

- (void)__cancelCrop {
    if(_cancelBlock != nil) {
        _cancelBlock(self);
    }
}

+ (UIImage*)__croppedImage:(UIImage*)image cropMode:(GLBImageCropMode)cropMode cropRect:(CGRect)cropRect zoom:(CGFloat)zoom maskPath:(UIBezierPath*)maskPath {
    CGSize imageSize = image.size;
    CGFloat x = CGRectGetMinX(cropRect);
    CGFloat y = CGRectGetMinY(cropRect);
    CGFloat width = CGRectGetWidth(cropRect);
    CGFloat height = CGRectGetHeight(cropRect);
    UIImageOrientation imageOrientation = image.imageOrientation;
    if(imageOrientation == UIImageOrientationRight || imageOrientation == UIImageOrientationRightMirrored) {
        cropRect.origin.x = y;
        cropRect.origin.y = round(imageSize.width - CGRectGetWidth(cropRect) - x);
        cropRect.size.width = height;
        cropRect.size.height = width;
    } else if(imageOrientation == UIImageOrientationLeft || imageOrientation == UIImageOrientationLeftMirrored) {
        cropRect.origin.x = round(imageSize.height - CGRectGetHeight(cropRect) - y);
        cropRect.origin.y = x;
        cropRect.size.width = height;
        cropRect.size.height = width;
    } else if(imageOrientation == UIImageOrientationDown || imageOrientation == UIImageOrientationDownMirrored) {
        cropRect.origin.x = round(imageSize.width - CGRectGetWidth(cropRect) - x);
        cropRect.origin.y = round(imageSize.height - CGRectGetHeight(cropRect) - y);
    }
    CGFloat imageScale = image.scale;
    cropRect = CGRectApplyAffineTransform(cropRect, CGAffineTransformMakeScale(imageScale, imageScale));
    CGImageRef croppedCGImage = CGImageCreateWithImageInRect(image.CGImage, cropRect);
    UIImage* croppedImage = [UIImage imageWithCGImage:croppedCGImage scale:imageScale orientation:imageOrientation];
    CGImageRelease(croppedCGImage);
    return [croppedImage glb_unrotate];
}

#pragma mark UIScrollViewDelegate

- (UIView*)viewForZoomingInScrollView:(__unused UIScrollView*)scrollView {
    return _scrollView.zoomView;
}

- (void)scrollViewDidZoom:(__unused UIScrollView*)scrollView {
    [_scrollView __centerZoomView];
}

#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer*)otherGestureRecognizer {
    return YES;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBImageScrollView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self != nil) {
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.alwaysBounceHorizontal = YES;
        self.alwaysBounceVertical = YES;
        self.bouncesZoom = YES;
        self.clipsToBounds = NO;
        self.scrollsToTop = NO;
    }
    return self;
}

- (void)didAddSubview:(UIView*)subview {
    [super didAddSubview:subview];
    [self __centerZoomView];
}

- (void)setFrame:(CGRect)frame {
    BOOL sizeChanging = CGSizeEqualToSize(self.glb_frameSize, frame.size);
    if(sizeChanging == NO) {
        [self __prepareToResize];
    }
    [super setFrame:frame];
    if(sizeChanging == NO) {
        [self __recoverFromResizing];
        [self __centerZoomView];
    }
}

#pragma mark Private

- (void)__centerZoomView {
    CGSize boundsSize = self.bounds.size;
    CGSize contentSize = self.contentSize;
    if((boundsSize.width > GLB_EPSILON) && (boundsSize.height > GLB_EPSILON) && (contentSize.width > GLB_EPSILON) && (contentSize.height > GLB_EPSILON)) {
        if(_aspectFill == YES) {
            CGFloat top = 0.0f;
            CGFloat left = 0.0f;
            if(contentSize.height < boundsSize.height) {
                top = (boundsSize.height - contentSize.height) * 0.5f;
            }
            if(contentSize.width < boundsSize.width) {
                left = (boundsSize.width - contentSize.width) * 0.5f;
            }
            self.contentInset = UIEdgeInsetsMake(top, left, top, left);
        } else {
            CGRect frameToCenter = _zoomView.frame;
            if(frameToCenter.size.width < boundsSize.width) {
                frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) * 0.5f;
            } else {
                frameToCenter.origin.x = 0.0f;
            }
            if(CGRectGetHeight(frameToCenter) < contentSize.height) {
                frameToCenter.origin.y = (contentSize.height - frameToCenter.size.height) * 0.5f;
            } else {
                frameToCenter.origin.y = 0.0f;
            }
            _zoomView.frame = frameToCenter;
        }
    }
}

- (void)__displayImage:(UIImage*)image {
    [_zoomView removeFromSuperview];
    _zoomView = nil;
    self.zoomScale = 1.0;
    _zoomView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:_zoomView];
    [self __configureForImageSize:image.size];
}

- (void)__configureForImageSize:(CGSize)imageSize {
    _imageSize = imageSize;
    self.contentSize = imageSize;
    [self __setMaxMinZoomScalesForCurrentBounds];
    [self __setInitialZoomScale];
    [self __setInitialContentOffset];
    self.contentInset = UIEdgeInsetsZero;
}

- (void)__setMaxMinZoomScalesForCurrentBounds {
    CGSize boundsSize = self.bounds.size;
    if((boundsSize.width > GLB_EPSILON) && (boundsSize.height > GLB_EPSILON) && (_imageSize.width > GLB_EPSILON) && (_imageSize.height > GLB_EPSILON)) {
        CGFloat xScale = boundsSize.width  / _imageSize.width;
        CGFloat yScale = boundsSize.height / _imageSize.height;
        CGFloat minScale;
        if(self.aspectFill == YES) {
            minScale = MAX(xScale, yScale);
        } else {
            minScale = MIN(xScale, yScale);
        }
        CGFloat maxScale = MAX(xScale, yScale);
        CGFloat xImageScale = maxScale * _imageSize.width / boundsSize.width;
        CGFloat yImageScale = maxScale * _imageSize.height / boundsSize.width;
        CGFloat maxImageScale = MAX(xImageScale, yImageScale);
        maxImageScale = MAX(minScale, maxImageScale);
        maxScale = MAX(maxScale, maxImageScale);
        if(minScale > maxScale) {
            minScale = maxScale;
        }
        self.minimumZoomScale = minScale;
        self.maximumZoomScale = maxScale;
    } else {
        self.minimumZoomScale = 1.0f;
        self.maximumZoomScale = 1.0f;
    }
}

- (void)__setInitialZoomScale {
    CGSize boundsSize = self.bounds.size;
    if((boundsSize.width > GLB_EPSILON) && (boundsSize.height > GLB_EPSILON) && (_imageSize.width > GLB_EPSILON) && (_imageSize.height > GLB_EPSILON)) {
        CGFloat xScale = boundsSize.width / _imageSize.width;
        CGFloat yScale = boundsSize.height / _imageSize.height;
        CGFloat scale = MAX(xScale, yScale);
        self.zoomScale = scale;
    } else {
        self.zoomScale = 1.0f;
    }
}

- (void)__setInitialContentOffset {
    CGSize boundsSize = self.bounds.size;
    CGSize zoomSize = _zoomView.glb_frameSize;
    if((boundsSize.width > GLB_EPSILON) && (boundsSize.height > GLB_EPSILON) && (zoomSize.width > GLB_EPSILON) && (zoomSize.height > GLB_EPSILON)) {
        CGPoint contentOffset = CGPointZero;
        if(zoomSize.width > boundsSize.width) {
            contentOffset.x = (zoomSize.width - boundsSize.width) * 0.5f;
        }
        if(zoomSize.height > boundsSize.height) {
            contentOffset.y = (zoomSize.height - boundsSize.height) * 0.5f;
        }
        self.contentOffset = contentOffset;
    }
}

- (void)__prepareToResize {
    CGRect bounds = self.bounds;
    _pointToCenterAfterResize = [self convertPoint:GLBRectGetCenterPoint(bounds) toView:self.zoomView];
    _scaleToRestoreAfterResize = self.zoomScale;
    if(_scaleToRestoreAfterResize <= self.minimumZoomScale + GLB_EPSILON) {
        _scaleToRestoreAfterResize = 0;
    }
}

- (void)__recoverFromResizing {
    [self __setMaxMinZoomScalesForCurrentBounds];
    self.zoomScale = MIN(self.maximumZoomScale, MAX(_scaleToRestoreAfterResize, self.minimumZoomScale));
    CGPoint boundsCenter = [self convertPoint:_pointToCenterAfterResize fromView:self.zoomView];
    CGPoint offset = CGPointMake(boundsCenter.x - self.bounds.size.width * 0.5f, boundsCenter.y - self.bounds.size.height * 0.5f);
    CGPoint maxOffset = [self __maximumContentOffset];
    CGPoint minOffset = [self __minimumContentOffset];
    offset.x = MAX(minOffset.x, MIN(maxOffset.x, offset.x));
    offset.y = MAX(minOffset.y, MIN(maxOffset.y, offset.y));
    self.contentOffset = offset;
}

- (CGPoint)__maximumContentOffset {
    CGSize contentSize = self.contentSize;
    CGSize boundsSize = self.glb_boundsSize;
    return CGPointMake(contentSize.width - boundsSize.width, contentSize.height - boundsSize.height);
}

- (CGPoint)__minimumContentOffset {
    return CGPointZero;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
