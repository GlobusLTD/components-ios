/*--------------------------------------------------*/

#import "GLBPressAndHoldGestureRecognizer.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import <UIKit/UIGestureRecognizerSubclass.h>

/*--------------------------------------------------*/

#import "GLBAction.h"
#import "NSArray+GLBNS.h"

/*--------------------------------------------------*/

@interface GLBPressAndHoldGestureRecognizer () {
@protected
    NSMutableArray* _actions;
    NSTimer* _repeatedlyReportTimer;
    CGPoint _beginLocation;
}

- (void)_invokeMethods;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBPressAndHoldGestureRecognizer

#pragma mark - Init / Free

- (id)initWithTarget:(id)target action:(SEL)action {
    self = [super initWithTarget:nil action:NULL];
    if(self) {
        _actions = [NSMutableArray new];
        if((target != nil) && (action != NULL)) {
            [_actions addObject:[GLBAction actionWithTarget:target action:action]];
        }
        _reportInterval = 0.5;
        _allowableMovementWhenRecognized = 3.0;
    }
    return self;
}

#pragma mark - Public override

- (void)setState:(UIGestureRecognizerState)state {
    if (state == UIGestureRecognizerStateBegan) {
        _repeatedlyReportTimer = [NSTimer scheduledTimerWithTimeInterval:_reportInterval target:self selector:@selector(_invokeMethods) userInfo:nil repeats:YES];
    }
    [super setState:state];
}

- (void)reset {
    if(_repeatedlyReportTimer != nil) {
        [_repeatedlyReportTimer invalidate];
        _repeatedlyReportTimer = nil;
    }
    [super reset];
    if((self.state == UIGestureRecognizerStateCancelled) || (self.state == UIGestureRecognizerStateEnded)) {
        [self _invokeMethods];
    }
}

- (void)addTarget:(id)target action:(SEL)action {
    if((target != nil) && (action != NULL)) {
        [_actions addObject:[GLBAction actionWithTarget:target action:action]];
    }
}

- (void)removeTarget:(id)target action:(SEL)action {
    [_actions glb_each:^(GLBAction* existAction) {
        if((existAction.target == target) && (existAction.action == action)) {
            [_actions removeObject:existAction];
        }
    }];
    [super removeTarget:target action:action];
}

#pragma mark - Public override

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    _beginLocation = [touches.anyObject locationInView:self.view];
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    if((self.state == UIGestureRecognizerStateBegan) || (self.state == UIGestureRecognizerStateChanged)) {
        CGPoint newLocation = [touches.anyObject locationInView:self.view];
        CGFloat dx = newLocation.x - _beginLocation.x;
        CGFloat dy = newLocation.y - _beginLocation.y;
        if(GLB_SQRT(dx * dx + dy * dy) > _allowableMovementWhenRecognized) {
            self.state = UIGestureRecognizerStateEnded;
        }
    }
    [super touchesMoved:touches withEvent:event];
}

- (void)_invokeMethods {
    [_actions glb_each:^(GLBAction* action) {
        [action performWithArguments:@[ self ]];
    }];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
