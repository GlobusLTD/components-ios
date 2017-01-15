/*--------------------------------------------------*/

#import "GLBPopoverController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBPopoverController () < UIPopoverControllerDelegate >

@property(nonatomic, strong) UIViewController* viewController;
@property(nonatomic, strong) UIPopoverController* popover;
@property(nonatomic, strong) UIView* view;
@property(nonatomic, strong) UIView* arrowTargetView;
@property(nonatomic) UIPopoverArrowDirection arrowDirection;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBPopoverController

#pragma mark - Not designated initializer

GLB_IMPLEMENTATION_NOT_DESIGNATED_INITIALIZER(init)

#pragma mark - Init / Free

- (instancetype)initWithViewController:(UIViewController*)viewController
                              fromView:(UIView*)view
                       arrowTargetView:(UIView*)arrowTargetView
                        arrowDirection:(UIPopoverArrowDirection)arrowDirection {
    self = [super init];
    if(self != nil) {
        _viewController = viewController;
        _viewController.glb_popoverController = self;
        _view = view;
        _arrowTargetView = arrowTargetView;
        _arrowDirection = arrowDirection;
    }
    return self;
}

- (void)dealloc {
}

#pragma mark - Property

- (void)setController:(UIViewController*)controller {
    if(_viewController != controller) {
        if(_viewController != nil) {
            _viewController.glb_popoverController = nil;
        }
        _viewController = controller;
        if(_viewController != nil) {
            _viewController.glb_popoverController = self;
        }
    }
}

- (void)setPopover:(UIPopoverController*)popover {
    if(_popover != popover) {
        if(_popover != nil) {
            _popover.delegate = nil;
        }
        _popover = popover;
        if(_popover != nil) {
            _popover.delegate = self;
        }
    }
}

#pragma mark - Public static

+ (instancetype)presentViewController:(UIViewController*)viewController
                             fromView:(UIView*)view
                      arrowTargetView:(UIView*)arrowTargetView
                       arrowDirection:(UIPopoverArrowDirection)arrowDirection
                             animated:(BOOL)animated {
    GLBPopoverController* popoverController = [[GLBPopoverController alloc] initWithViewController:viewController
                                                                                      fromView:view
                                                                               arrowTargetView:arrowTargetView
                                                                                arrowDirection:arrowDirection];
    [popoverController presentAnimated:animated];
    return popoverController;
}

#pragma mark - Public

- (void)presentAnimated:(BOOL)animated {
    self.popover = [[UIPopoverController alloc] initWithContentViewController:_viewController];
    [self.popover presentPopoverFromRect:[_arrowTargetView convertRect:_arrowTargetView.bounds toView:_view]
                                  inView:_view
                permittedArrowDirections:_arrowDirection
                                animated:animated];
}

- (void)dismissAnimated:(BOOL)animated {
    [self.popover dismissPopoverAnimated:animated];
    self.controller = nil;
    self.popover = nil;
}

#pragma mark - UIPopoverControllerDelegate

- (void)popoverController:(UIPopoverController*)popoverController willRepositionPopoverToRect:(inout CGRect*)rect inView:(inout UIView* __autoreleasing *)view {
    *rect = [_arrowTargetView convertRect:_arrowTargetView.bounds toView:*view];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController*)popoverController {
    self.controller = nil;
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation UIViewController (GLBPopoverController)

- (void)setGlb_popoverController:(GLBPopoverController*)popoverController {
    objc_setAssociatedObject(self, @selector(glb_popoverController), popoverController, OBJC_ASSOCIATION_RETAIN);
}

- (GLBPopoverController*)glb_popoverController {
    GLBPopoverController* controller = objc_getAssociatedObject(self, @selector(glb_popoverController));
    if(controller == nil) {
        controller = self.parentViewController.glb_popoverController;
    }
    return controller;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
