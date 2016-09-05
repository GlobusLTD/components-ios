/*--------------------------------------------------*/

#import "GLBPopoverController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBPopoverController () < UIPopoverControllerDelegate >

@property(nonatomic, strong) UIViewController* controller;
@property(nonatomic, strong) UIPopoverController* popover;
@property(nonatomic, strong) UIView* view;
@property(nonatomic, strong) UIView* arrowTargetView;
@property(nonatomic) UIPopoverArrowDirection arrowDirection;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBPopoverController

#pragma mark - Init / Free

- (instancetype)initWithController:(UIViewController*)controller
                          fromView:(UIView*)view
                   arrowTargetView:(UIView*)arrowTargetView
                    arrowDirection:(UIPopoverArrowDirection)arrowDirection {
    self = [super init];
    if(self != nil) {
        _controller = controller;
        _controller.glb_popoverController = self;
        _view = view;
        _arrowTargetView = arrowTargetView;
        _arrowDirection = arrowDirection;
        [self setup];
    }
    return self;
}

- (void)setup {
}

- (void)dealloc {
}

#pragma mark - Property

- (void)setController:(UIViewController*)controller {
    if(_controller != controller) {
        if(_controller != nil) {
            _controller.glb_popoverController = nil;
        }
        _controller = controller;
        if(_controller != nil) {
            _controller.glb_popoverController = self;
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

+ (instancetype)presentController:(UIViewController*)controller
                         fromView:(UIView*)view
                  arrowTargetView:(UIView*)arrowTargetView
                   arrowDirection:(UIPopoverArrowDirection)arrowDirection
                         animated:(BOOL)animated {
    GLBPopoverController* popoverController = [[GLBPopoverController alloc] initWithController:controller
                                                                                      fromView:view
                                                                               arrowTargetView:arrowTargetView
                                                                                arrowDirection:arrowDirection];
    [popoverController presentAnimated:animated];
    return popoverController;
}

#pragma mark - Public

- (void)presentAnimated:(BOOL)animated {
    self.popover = [[UIPopoverController alloc] initWithContentViewController:_controller];
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
