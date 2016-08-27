/*--------------------------------------------------*/

#import "GLBDataViewSectionsListContainer+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

#import "NSArray+GLBNS.h"

/*--------------------------------------------------*/

@implementation GLBDataViewSectionsListContainer

#pragma mark - Synthesize

@synthesize orientation = _orientation;
@synthesize margin = _margin;
@synthesize spacing = _spacing;
@synthesize pagingEnabled = _pagingEnabled;
@synthesize currentSection = _currentSection;

#pragma mark - Init / Free

+ (instancetype)containerWithOrientation:(GLBDataContainerOrientation)orientation {
    return [[self alloc] initWithOrientation:orientation];
}

- (instancetype)initWithOrientation:(GLBDataContainerOrientation)orientation {
    self = [super init];
    if(self != nil) {
        _orientation = orientation;
    }
    return self;
}

- (void)setup {
    [super setup];
    
    _margin = UIEdgeInsetsZero;
    _spacing = UIOffsetZero;
}

#pragma mark - Property

- (void)setAllowAutoAlign:(BOOL)allowAutoAlign {
    if(_allowAutoAlign != allowAutoAlign) {
        [super setAllowAutoAlign:allowAutoAlign];
        if(_pagingEnabled == YES) {
            self.pagingEnabled = NO;
        }
    }
}

- (void)setOrientation:(GLBDataContainerOrientation)orientation {
    if(_orientation != orientation) {
        _orientation = orientation;
        if(_view != nil) {
            [_view setNeedValidateLayout];
        }
    }
}

- (void)setMargin:(UIEdgeInsets)margin {
    if(UIEdgeInsetsEqualToEdgeInsets(_margin, margin) == NO) {
        _margin = margin;
        if(_view != nil) {
            [_view setNeedValidateLayout];
        }
    }
}

- (void)setSpacing:(UIOffset)spacing {
    if(UIOffsetEqualToOffset(_spacing, spacing) == NO) {
        _spacing = spacing;
        if(_view != nil) {
            [_view setNeedValidateLayout];
        }
    }
}

- (void)setPagingEnabled:(BOOL)pagingEnabled {
    if(_pagingEnabled != pagingEnabled) {
        if(_pagingEnabled == YES) {
            _currentSection = nil;
        }
        _pagingEnabled = pagingEnabled;
        _allowAutoAlign = _pagingEnabled;
        if(_pagingEnabled == YES) {
            [self align];
        }
    }
}

- (void)setCurrentSectionIndex:(NSUInteger)currentSectionIndex {
    [self setCurrentSection:_sections[currentSectionIndex] animated:NO];
}

- (void)setCurrentSectionIndex:(NSUInteger)currentSectionIndex animated:(BOOL)animated {
    [self setCurrentSection:_sections[currentSectionIndex] animated:animated];
}

- (NSUInteger)currentSectionIndex {
    return [_sections indexOfObjectIdenticalTo:_currentSection];
}

- (void)setCurrentSection:(GLBDataContainer*)currentSection {
    [self setCurrentSection:currentSection animated:NO];
}

- (void)setCurrentSection:(GLBDataContainer*)currentSection animated:(BOOL)animated {
    if(_currentSection != currentSection) {
        _currentSection = currentSection;
        if((_pagingEnabled == YES) && (_currentSection != nil)) {
            [self scrollToSection:_currentSection scrollPosition:(GLBDataViewPosition)_alignPosition animated:animated];
        }
    }
}

#pragma mark - Public override

- (void)replaceOriginSection:(GLBDataContainer*)originSection withSection:(GLBDataContainer*)section {
    if((_pagingEnabled == YES) && (_currentSection == originSection)) {
        _currentSection = section;
    }
    [super replaceOriginSection:originSection withSection:section];
}

- (void)deleteSection:(GLBDataContainer*)section {
    if((_pagingEnabled == YES) && (_currentSection == section)) {
        _currentSection = [_sections glb_nextObjectOfObject:_currentSection];
    }
    [super deleteSection:section];
}

- (void)deleteAllSections {
    if(_pagingEnabled == YES) {
        _currentSection = nil;
    }
    [super deleteAllSections];
}

#pragma mark - Private override

- (void)_didEndDraggingWillDecelerate:(BOOL __unused)decelerate {
    [super _didEndDraggingWillDecelerate:decelerate];
    
    if((_pagingEnabled == YES) && (decelerate == NO)) {
        CGPoint alignPoint = [self alignPoint];
        for(GLBDataContainer* section in _sections) {
            if(section.hidden == YES) {
                continue;
            }
            if(CGRectContainsPoint(section.frame, alignPoint) == YES) {
                _currentSection = section;
                [self performActionForKey:GLBDataContainerCurrentSectionChanged withArguments:@[ _currentSection ]];
                break;
            }
        }
    }
}

- (void)_didEndDecelerating {
    [super _didEndDecelerating];
    
    if(_pagingEnabled == YES) {
        CGPoint alignPoint = [self alignPoint];
        for(GLBDataContainer* section in _sections) {
            if(section.hidden == YES) {
                continue;
            }
            if(CGRectContainsPoint(section.frame, alignPoint) == YES) {
                _currentSection = section;
                [self performActionForKey:GLBDataContainerCurrentSectionChanged withArguments:@[ _currentSection ]];
                break;
            }
        }
    }
}

- (void)_endUpdateAnimated:(BOOL)animated {
    [super _endUpdateAnimated:animated];
    
    if((_pagingEnabled == YES) && (_currentSection != nil)) {
        [self scrollToSection:_currentSection scrollPosition:(GLBDataViewPosition)_alignPosition animated:animated];
    }
}

- (CGRect)_validateLayoutForAvailableFrame:(CGRect)frame {
    CGPoint offset = CGPointMake(frame.origin.x + _margin.left, frame.origin.y + _margin.top);
    CGSize restriction = CGSizeMake(frame.size.width - (_margin.left + _margin.right), frame.size.height - (_margin.left + _margin.right));
    CGSize cumulative = CGSizeZero;
    switch(_orientation) {
        case GLBDataContainerOrientationVertical: {
            for(GLBDataContainer* container in _sections) {
                if(container.hidden == YES) {
                    continue;
                }
                [container _validateLayoutForAvailableFrame:CGRectMake(offset.x, offset.y, restriction.width, restriction.height)];
                CGRect containerFrame = container.frame;
                cumulative.height += containerFrame.size.height + _spacing.vertical;
                cumulative.width = MAX(cumulative.width, containerFrame.size.width);
                offset.y = (containerFrame.origin.y + containerFrame.size.height) + _spacing.vertical;
            }
            break;
        }
        case GLBDataContainerOrientationHorizontal: {
            for(GLBDataContainer* container in _sections) {
                if(container.hidden == YES) {
                    continue;
                }
                [container _validateLayoutForAvailableFrame:CGRectMake(offset.x, offset.y, restriction.width, restriction.height)];
                CGRect containerFrame = container.frame;
                cumulative.width += containerFrame.size.width + _spacing.horizontal;
                cumulative.height = MAX(cumulative.height, containerFrame.size.height);
                offset.x = (containerFrame.origin.x + containerFrame.size.width) + _spacing.horizontal;
            }
            break;
        }
    }
    _frame = CGRectMake(frame.origin.x, frame.origin.y, _margin.left + cumulative.width + _margin.right, _margin.top + cumulative.height + _margin.bottom);
    return _frame;
}

- (CGRect)_frameSectionsForAvailableFrame:(CGRect)frame {
    CGPoint offset = CGPointMake(frame.origin.x + _margin.left, frame.origin.y + _margin.top);
    CGSize restriction = CGSizeMake(frame.size.width - (_margin.left + _margin.right), frame.size.height - (_margin.left + _margin.right));
    CGSize cumulative = CGSizeZero;
    switch(_orientation) {
        case GLBDataContainerOrientationVertical: {
            for(GLBDataContainer* container in _sections) {
                if(container.hidden == YES) {
                    continue;
                }
                CGRect containerFrame = [container _frameForAvailableFrame:CGRectMake(offset.x, offset.y, restriction.width, restriction.height)];
                cumulative.height += containerFrame.size.height + _spacing.vertical;
                cumulative.width = MAX(cumulative.width, containerFrame.size.width);
                offset.y = (containerFrame.origin.y + containerFrame.size.height) + _spacing.vertical;
            }
            cumulative.height -= _spacing.vertical;
            break;
        }
        case GLBDataContainerOrientationHorizontal: {
            for(GLBDataContainer* container in _sections) {
                if(container.hidden == YES) {
                    continue;
                }
                CGRect containerFrame = [container _frameForAvailableFrame:CGRectMake(offset.x, offset.y, restriction.width, restriction.height)];
                cumulative.width += containerFrame.size.width + _spacing.horizontal;
                cumulative.height = MAX(cumulative.height, containerFrame.size.height);
                offset.x = (containerFrame.origin.x + containerFrame.size.width) + _spacing.horizontal;
            }
            cumulative.width -= _spacing.horizontal;
            break;
        }
    }
    return CGRectMake(frame.origin.x, frame.origin.y, _margin.left + cumulative.width + _margin.right, _margin.top + cumulative.height + _margin.bottom);
}

- (void)_layoutSectionsForFrame:(CGRect)frame {
    CGPoint offset = CGPointMake(frame.origin.x + _margin.left, frame.origin.y + _margin.top);
    CGSize restriction = CGSizeMake(frame.size.width - (_margin.left + _margin.right), frame.size.height - (_margin.left + _margin.right));
    CGSize cumulative = CGSizeZero;
    switch(_orientation) {
        case GLBDataContainerOrientationVertical: {
            for(GLBDataContainer* container in _sections) {
                if(container.hidden == YES) {
                    continue;
                }
                CGRect containerFrame = CGRectMake(offset.x, offset.y, restriction.width, restriction.height);
                [container _layoutForAvailableFrame:containerFrame];
                cumulative.height += containerFrame.size.height + _spacing.vertical;
                cumulative.width = MAX(cumulative.width, containerFrame.size.width);
                offset.y = (containerFrame.origin.y + containerFrame.size.height) + _spacing.vertical;
            }
            cumulative.height -= _spacing.vertical;
            break;
        }
        case GLBDataContainerOrientationHorizontal: {
            for(GLBDataContainer* container in _sections) {
                if(container.hidden == YES) {
                    continue;
                }
                CGRect containerFrame = [container _frameForAvailableFrame:CGRectMake(offset.x, offset.y, restriction.width, restriction.height)];
                [container _layoutForAvailableFrame:containerFrame];
                cumulative.width += containerFrame.size.width + _spacing.horizontal;
                cumulative.height = MAX(cumulative.height, containerFrame.size.height);
                offset.x = (containerFrame.origin.x + containerFrame.size.width) + _spacing.horizontal;
            }
            cumulative.width -= _spacing.horizontal;
            break;
        }
    }
}

@end

/*--------------------------------------------------*/
/* Constants                                        */
/*--------------------------------------------------*/

NSString* GLBDataContainerCurrentSectionChanged = @"GLBDataContainerCurrentSectionChanged";

/*--------------------------------------------------*/
/* Legacy                                           */
/*--------------------------------------------------*/

@implementation GLBDataContainerSectionsList
@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
