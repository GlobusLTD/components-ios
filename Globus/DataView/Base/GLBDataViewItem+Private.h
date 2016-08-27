/*--------------------------------------------------*/

#import "GLBDataViewItem.h"
#import "GLBDataView+Private.h"
#import "GLBDataContainer+Private.h"
#import "GLBDataViewCell+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewItem () {
@protected
    __weak GLBDataView* _view;
    __weak GLBDataContainer* _parent;
    NSString* _identifier;
    NSUInteger _order;
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
}

@property(nonatomic, weak) GLBDataView* view;
@property(nonatomic, weak) GLBDataContainer* parent;
@property(nonatomic, strong) NSString* identifier;
@property(nonatomic) BOOL needResize;
@property(nonatomic, getter=isMoving) BOOL moving;
@property(nonatomic, strong) GLBDataViewCell* cell;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
