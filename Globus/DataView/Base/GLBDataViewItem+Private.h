/*--------------------------------------------------*/

#import "GLBDataViewItem.h"
#import "GLBDataView+Private.h"
#import "GLBDataViewContainer+Private.h"
#import "GLBDataViewCell+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewItemAccessibilityElement ()

@property(nonatomic, weak) __kindof GLBDataView* dataView;

+ (instancetype)accessibilityElementWithDataView:(GLBDataView*)dataView item:(GLBDataViewItem*)item;

- (instancetype)initWithDataView:(GLBDataView*)dataView item:(GLBDataViewItem*)item;

@end

/*--------------------------------------------------*/

@interface GLBDataViewItem () {
@protected
    __weak GLBDataView* _view;
    __weak GLBDataViewContainer* _parent;
    NSString* _identifier;
    NSUInteger _order;
    NSUInteger _accessibilityOrder;
    id _data;
    CGSize _size;
    BOOL _needResize;
    CGRect _originFrame;
    CGRect _updateFrame;
    CGRect _displayFrame;
    CGRect _frame;
    BOOL _hidden;
    BOOL _allowsAlign;
    BOOL _allowsPressed;
    BOOL _allowsLongPressed;
    BOOL _allowsSelection;
    BOOL _allowsHighlighting;
    BOOL _allowsEditing;
    BOOL _allowsMoving;
    BOOL _persistent;
    BOOL _selected;
    BOOL _highlighted;
    BOOL _editing;
    GLBDataViewCell* _cell;
    
    GLBDataViewItemAccessibilityElement* _accessibilityElement;
}

@property(nonatomic, weak) __kindof GLBDataView* dataView;
@property(nonatomic, weak) __kindof GLBDataViewContainer* container;
@property(nonatomic, strong) GLBDataViewCell* cell;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
