/*--------------------------------------------------*/

#import "GLBDataViewTypes.h"
#import "GLBSearchBar.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBDataView;
@class GLBDataContainer;
@class GLBDataViewItem;
@class GLBDataViewCell;

/*--------------------------------------------------*/

typedef NS_ENUM(NSUInteger, GLBDataContainerOrientation) {
    GLBDataContainerOrientationVertical,
    GLBDataContainerOrientationHorizontal,
};

typedef NS_OPTIONS(NSUInteger, GLBDataContainerAlign) {
    GLBDataContainerAlignNone = GLBDataViewPositionNone,
    GLBDataContainerAlignTop = GLBDataViewPositionTop,
    GLBDataContainerAlignCenteredVertically = GLBDataViewPositionCenteredVertically,
    GLBDataContainerAlignBottom = GLBDataViewPositionBottom,
    GLBDataContainerAlignLeft = GLBDataViewPositionLeft,
    GLBDataContainerAlignCenteredHorizontally = GLBDataViewPositionCenteredHorizontally,
    GLBDataContainerAlignRight = GLBDataViewPositionRight,
    GLBDataContainerAlignCentered = GLBDataContainerAlignCenteredVertically | GLBDataContainerAlignCenteredHorizontally,
};

/*--------------------------------------------------*/

typedef void(^GLBDataContainerConfigureItemBlock)(__kindof GLBDataViewItem* item);

/*--------------------------------------------------*/

@interface GLBDataContainer : NSObject< GLBSearchBarDelegate >

@property(nonatomic, readonly, weak) __kindof GLBDataView* dataView;
@property(nonatomic, readonly, weak) __kindof GLBDataContainer* dataContainer;
@property(nonatomic, readonly, assign) CGRect frame;
@property(nonatomic, getter=isHidden) BOOL hidden;
@property(nonatomic, readonly, assign, getter=isHiddenInHierarchy) BOOL hiddenInHierarchy;
@property(nonatomic) BOOL allowAutoAlign;
@property(nonatomic) UIEdgeInsets alignInsets;
@property(nonatomic) GLBDataContainerAlign alignPosition;
@property(nonatomic) UIOffset alignThreshold;

- (void)setup NS_REQUIRES_SUPER;

- (void)setNeedResize;
- (void)setNeedReload;

- (NSArray*)allItems;

- (__kindof GLBDataViewItem*)itemForPoint:(CGPoint)point;
- (__kindof GLBDataViewItem*)itemForData:(id)data;
- (__kindof GLBDataViewCell*)cellForData:(id)data;

- (BOOL)containsActionForKey:(id)key;
- (BOOL)containsActionForIdentifier:(id)identifier forKey:(id)key;

- (void)performActionForKey:(id)key withArguments:(NSArray*)arguments;
- (void)performActionForIdentifier:(id)identifier forKey:(id)key withArguments:(NSArray*)arguments;

- (CGPoint)alignPoint;
- (void)align;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
