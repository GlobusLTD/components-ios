/*--------------------------------------------------*/

#import "GLBDataViewItemsContainer.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

typedef NS_ENUM(NSUInteger, GLBDataViewItemsListContainerMode) {
    GLBDataViewItemsListContainerModeBegin,
    GLBDataViewItemsListContainerModeCenter,
    GLBDataViewItemsListContainerModeEnd
};

/*--------------------------------------------------*/

@interface GLBDataViewItemsListContainer : GLBDataViewItemsContainer

@property(nonatomic) GLBDataContainerOrientation orientation;
@property(nonatomic) GLBDataViewItemsListContainerMode mode;
@property(nonatomic) BOOL reverse;
@property(nonatomic) UIEdgeInsets margin;
@property(nonatomic) UIOffset spacing;
@property(nonatomic) CGSize defaultSize;
@property(nonatomic) CGFloat defaultWidth;
@property(nonatomic) CGFloat defaultHeight;
@property(nonatomic) NSUInteger defaultOrder;
@property(nonatomic, strong) __kindof GLBDataViewItem* header;
@property(nonatomic, strong) __kindof GLBDataViewItem* footer;
@property(nonatomic, readonly, strong) NSArray< __kindof GLBDataViewItem* >* items;

+ (instancetype)containerWithOrientation:(GLBDataContainerOrientation)orientation;

- (instancetype)initWithOrientation:(GLBDataContainerOrientation)orientation;

- (__kindof GLBDataViewItem*)prependIdentifier:(NSString*)identifier byData:(id)data;
- (__kindof GLBDataViewItem*)prependIdentifier:(NSString*)identifier byData:(id)data configure:(GLBDataContainerConfigureItemBlock)configure;
- (__kindof GLBDataViewItem*)prependIdentifier:(NSString*)identifier byData:(id)data order:(NSUInteger)order;
- (__kindof GLBDataViewItem*)prependIdentifier:(NSString*)identifier byData:(id)data order:(NSUInteger)order configure:(GLBDataContainerConfigureItemBlock)configure;
- (void)prependItem:(GLBDataViewItem*)item;
- (void)prependItems:(NSArray*)items;

- (__kindof GLBDataViewItem*)appendIdentifier:(NSString*)identifier byData:(id)data;
- (__kindof GLBDataViewItem*)appendIdentifier:(NSString*)identifier byData:(id)data configure:(GLBDataContainerConfigureItemBlock)configure;
- (__kindof GLBDataViewItem*)appendIdentifier:(NSString*)identifier byData:(id)data order:(NSUInteger)order;
- (__kindof GLBDataViewItem*)appendIdentifier:(NSString*)identifier byData:(id)data order:(NSUInteger)order configure:(GLBDataContainerConfigureItemBlock)configure;
- (void)appendItem:(GLBDataViewItem*)item;
- (void)appendItems:(NSArray*)items;

- (__kindof GLBDataViewItem*)insertIdentifier:(NSString*)identifier atIndex:(NSUInteger)index byData:(id)data;
- (__kindof GLBDataViewItem*)insertIdentifier:(NSString*)identifier atIndex:(NSUInteger)index byData:(id)data configure:(GLBDataContainerConfigureItemBlock)configure;
- (__kindof GLBDataViewItem*)insertIdentifier:(NSString*)identifier atIndex:(NSUInteger)index byData:(id)data order:(NSUInteger)order;
- (__kindof GLBDataViewItem*)insertIdentifier:(NSString*)identifier atIndex:(NSUInteger)index byData:(id)data order:(NSUInteger)order configure:(GLBDataContainerConfigureItemBlock)configure;
- (void)insertItem:(GLBDataViewItem*)item atIndex:(NSUInteger)index;
- (void)insertItems:(NSArray*)items atIndex:(NSUInteger)index;
- (void)insertItem:(GLBDataViewItem*)item aboveItem:(GLBDataViewItem*)aboveItem;
- (void)insertItems:(NSArray*)items aboveItem:(GLBDataViewItem*)aboveItem;
- (void)insertItem:(GLBDataViewItem*)item belowItem:(GLBDataViewItem*)belowItem;
- (void)insertItems:(NSArray*)items belowItem:(GLBDataViewItem*)belowItem;

- (void)replaceOriginItem:(GLBDataViewItem*)originItem withItem:(GLBDataViewItem*)item;
- (void)replaceOriginItems:(NSArray*)originItems withItems:(NSArray*)items;

- (void)deleteItem:(GLBDataViewItem*)item;
- (void)deleteItems:(NSArray*)items;
- (void)deleteAllItems;

@end

/*--------------------------------------------------*/
/* Legacy                                           */
/*--------------------------------------------------*/

@interface GLBDataContainerItemsList : GLBDataViewItemsListContainer
@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
