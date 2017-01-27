/*--------------------------------------------------*/

#import "GLBDataViewController.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBDataViewController

#pragma mark - Synthesize

@synthesize dataView = _dataView;

#pragma mark - Init / Free

+ (BOOL)useNibForInstantiate {
    return NO;
}

+ (instancetype)instantiate {
    if([self useNibForInstantiate] == YES) {
        return [super instantiate];
    }
    return [self new];
}

+ (instancetype)instantiateWithOptions:(NSDictionary*)options {
    if([self useNibForInstantiate] == YES) {
        return [super instantiateWithOptions:options];
    }
    return [self new];
}

- (void)setup {
    [super setup];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    if(_dataView == nil) {
        self.dataView = [[GLBDataView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    } else {
        if(_dataView.superview == nil) {
            [self.view addSubview:_dataView];
        } else {
            for(NSLayoutConstraint* constraint in self.view.constraints) {
                NSLayoutAttribute attribute = NSLayoutAttributeNotAnAttribute;
                if(constraint.firstItem == _dataView) {
                    attribute = constraint.firstAttribute;
                } else if(constraint.secondItem == _dataView) {
                    attribute = constraint.secondAttribute;
                }
                if(attribute != NSLayoutAttributeNotAnAttribute) {
                    switch(constraint.firstAttribute) {
                        case NSLayoutAttributeTop:
                            _constraintDataViewTop = constraint;
                            break;
                        case NSLayoutAttributeLeft:
                        case NSLayoutAttributeLeading:
                            _constraintDataViewLeft = constraint;
                            break;
                        case NSLayoutAttributeRight:
                        case NSLayoutAttributeTrailing:
                            _constraintDataViewRight = constraint;
                            break;
                        case NSLayoutAttributeBottom:
                            _constraintDataViewBottom = constraint;
                            break;
                        default:
                            break;
                    }
                }
            }
        }
        [self prepareDataView];
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"

- (void)viewDidUnload {
    self.dataView = nil;
    
    [super viewDidUnload];
}

#pragma clang diagnostic pop

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    [self updateConstraintsDataView];
}

#pragma mark - Property override

- (void)setEdgesForExtendedLayout:(UIRectEdge)edgesForExtendedLayout {
    [super setEdgesForExtendedLayout:edgesForExtendedLayout];
    if(self.isViewLoaded == YES) {
        self.constraintDataViewTop = nil;
        self.constraintDataViewBottom = nil;
        [self.view setNeedsUpdateConstraints];
    }
}

- (void)setAutomaticallyAdjustsScrollViewInsets:(BOOL)automaticallyAdjustsScrollViewInsets {
    [super setAutomaticallyAdjustsScrollViewInsets:automaticallyAdjustsScrollViewInsets];
    if(self.isViewLoaded == YES) {
        self.constraintDataViewTop = nil;
        self.constraintDataViewBottom = nil;
        [self.view setNeedsUpdateConstraints];
    }
}

#pragma mark - Property

- (void)setDataView:(GLBDataView*)dataView {
    if(_dataView != dataView) {
        if(_dataView != nil) {
            [self cleanupDataView];
            [_dataView removeFromSuperview];
        }
        _dataView = dataView;
        if(_dataView != nil) {
            _dataView.translatesAutoresizingMaskIntoConstraints = NO;
            
            if(self.isViewLoaded == YES) {
                [self.view addSubview:_dataView];
                [self prepareDataView];
            }
        }
    }
}

- (GLBDataView*)dataView {
    if(_dataView == nil) {
        self.dataView = [[GLBDataView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    }
    return _dataView;
}

- (void)setConstraintDataViewTop:(NSLayoutConstraint*)constraintDataViewTop {
    if(_constraintDataViewTop != constraintDataViewTop) {
        BOOL isLoaded = self.isViewLoaded;
        if((_constraintDataViewTop != nil) && (isLoaded == YES)) {
            [self.view removeConstraint:_constraintDataViewTop];
        }
        _constraintDataViewTop = constraintDataViewTop;
        if(_constraintDataViewTop != nil) {
            if(isLoaded == YES) {
                [self.view addConstraint:_constraintDataViewTop];
            }
        }
    }
}

- (void)setConstraintDataViewLeft:(NSLayoutConstraint*)constraintDataViewLeft {
    if(_constraintDataViewLeft != constraintDataViewLeft) {
        BOOL isLoaded = self.isViewLoaded;
        if((_constraintDataViewLeft != nil) && (isLoaded == YES)) {
            [self.view removeConstraint:_constraintDataViewLeft];
        }
        _constraintDataViewLeft = constraintDataViewLeft;
        if(_constraintDataViewLeft != nil) {
            if(isLoaded == YES) {
                [self.view addConstraint:_constraintDataViewLeft];
            }
        }
    }
}

- (void)setConstraintDataViewRight:(NSLayoutConstraint*)constraintDataViewRight {
    if(_constraintDataViewRight != constraintDataViewRight) {
        BOOL isLoaded = self.isViewLoaded;
        if((_constraintDataViewRight != nil) && (isLoaded == YES)) {
            [self.view removeConstraint:_constraintDataViewRight];
        }
        _constraintDataViewRight = constraintDataViewRight;
        if(_constraintDataViewRight != nil) {
            if(isLoaded == YES) {
                [self.view addConstraint:_constraintDataViewRight];
            }
        }
    }
}

- (void)setConstraintDataViewBottom:(NSLayoutConstraint*)constraintDataViewBottom {
    if(_constraintDataViewBottom != constraintDataViewBottom) {
        BOOL isLoaded = self.isViewLoaded;
        if((_constraintDataViewBottom != nil) && (isLoaded == YES)) {
            [self.view removeConstraint:_constraintDataViewBottom];
        }
        _constraintDataViewBottom = constraintDataViewBottom;
        if(_constraintDataViewBottom != nil) {
            if(isLoaded == YES) {
                [self.view addConstraint:_constraintDataViewBottom];
            }
        }
    }
}

#pragma mark - Public

- (void)prepareDataView {
}

- (void)cleanupDataView {
}

- (void)updateConstraintsDataView {
    if(_constraintDataViewTop == nil) {
        if(((self.edgesForExtendedLayout & UIRectEdgeTop) != 0) && (self.automaticallyAdjustsScrollViewInsets == NO) && (self.topLayoutGuide != nil)) {
            self.constraintDataViewTop = [NSLayoutConstraint constraintWithItem:_dataView
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.topLayoutGuide
                                                                      attribute:NSLayoutAttributeBottom
                                                                     multiplier:1.0f
                                                                       constant:0.0f];
        } else {
            self.constraintDataViewTop = [NSLayoutConstraint constraintWithItem:_dataView
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.view
                                                                      attribute:NSLayoutAttributeTop
                                                                     multiplier:1.0f
                                                                       constant:0.0f];
        }
    }
    if(_constraintDataViewLeft == nil) {
        self.constraintDataViewLeft = [NSLayoutConstraint constraintWithItem:_dataView
                                                                   attribute:NSLayoutAttributeLeft
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeLeft
                                                                  multiplier:1.0f
                                                                    constant:0.0f];
    }
    if(_constraintDataViewRight == nil) {
        self.constraintDataViewRight = [NSLayoutConstraint constraintWithItem:_dataView
                                                                    attribute:NSLayoutAttributeRight
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.view
                                                                    attribute:NSLayoutAttributeRight
                                                                   multiplier:1.0f
                                                                     constant:0.0f];
    }
    if(_constraintDataViewBottom == nil) {
        if(((self.edgesForExtendedLayout & UIRectEdgeBottom) != 0) && (self.automaticallyAdjustsScrollViewInsets == NO) && (self.bottomLayoutGuide != nil)) {
            self.constraintDataViewBottom = [NSLayoutConstraint constraintWithItem:_dataView
                                                                         attribute:NSLayoutAttributeBottom
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.bottomLayoutGuide
                                                                         attribute:NSLayoutAttributeTop
                                                                        multiplier:1.0f
                                                                          constant:0.0f];
        } else {
            self.constraintDataViewBottom = [NSLayoutConstraint constraintWithItem:_dataView
                                                                         attribute:NSLayoutAttributeBottom
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.view
                                                                         attribute:NSLayoutAttributeBottom
                                                                        multiplier:1.0f
                                                                          constant:0.0f];
        }
    }
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
