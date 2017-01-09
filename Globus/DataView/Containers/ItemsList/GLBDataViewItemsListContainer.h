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

@property(nonatomic) GLBDataViewContainerOrientation orientation;
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

+ (instancetype)containerWithOrientation:(GLBDataViewContainerOrientation)orientation NS_SWIFT_UNAVAILABLE("Use init(orientation:)");

- (instancetype)initWithOrientation:(GLBDataViewContainerOrientation)orientation;

- (void)prependEntry:(GLBDataViewItem*)entry NS_UNAVAILABLE;
- (void)prependEntries:(NSArray*)entries NS_UNAVAILABLE;
- (void)appendEntry:(GLBDataViewItem*)entry NS_UNAVAILABLE;
- (void)appendEntries:(NSArray*)entries NS_UNAVAILABLE;
- (void)insertEntry:(GLBDataViewItem*)entry atIndex:(NSUInteger)index NS_UNAVAILABLE;
- (void)insertEntries:(NSArray*)entries atIndex:(NSUInteger)index NS_UNAVAILABLE;
- (void)insertEntry:(GLBDataViewItem*)entry aboveEntry:(GLBDataViewItem*)aboveEntry NS_UNAVAILABLE;
- (void)insertEntries:(NSArray*)entries aboveEntry:(GLBDataViewItem*)aboveEntry NS_UNAVAILABLE;
- (void)insertEntry:(GLBDataViewItem*)entry belowEntry:(GLBDataViewItem*)belowEntry NS_UNAVAILABLE;
- (void)insertEntries:(NSArray*)entries belowEntry:(GLBDataViewItem*)belowEntry NS_UNAVAILABLE;
- (void)replaceOriginEntry:(GLBDataViewItem*)originEntry withEntry:(GLBDataViewItem*)entry NS_UNAVAILABLE;
- (void)replaceOriginEntries:(NSArray*)originEntries withEntries:(NSArray*)entries NS_UNAVAILABLE;
- (void)deleteEntry:(GLBDataViewItem*)entry NS_UNAVAILABLE;
- (void)deleteEntries:(NSArray*)entries NS_UNAVAILABLE;
- (void)deleteAllEntries NS_UNAVAILABLE;

- (__kindof GLBDataViewItem*)prependIdentifier:(NSString*)identifier byData:(id)data;
- (__kindof GLBDataViewItem*)prependIdentifier:(NSString*)identifier byData:(id)data configure:(GLBDataViewContainerConfigureItemBlock)configure;
- (__kindof GLBDataViewItem*)prependIdentifier:(NSString*)identifier byData:(id)data order:(NSUInteger)order;
- (__kindof GLBDataViewItem*)prependIdentifier:(NSString*)identifier byData:(id)data order:(NSUInteger)order configure:(GLBDataViewContainerConfigureItemBlock)configure;
- (void)prependItem:(GLBDataViewItem*)item;
- (void)prependItems:(NSArray*)items;

- (__kindof GLBDataViewItem*)appendIdentifier:(NSString*)identifier byData:(id)data;
- (__kindof GLBDataViewItem*)appendIdentifier:(NSString*)identifier byData:(id)data configure:(GLBDataViewContainerConfigureItemBlock)configure;
- (__kindof GLBDataViewItem*)appendIdentifier:(NSString*)identifier byData:(id)data order:(NSUInteger)order;
- (__kindof GLBDataViewItem*)appendIdentifier:(NSString*)identifier byData:(id)data order:(NSUInteger)order configure:(GLBDataViewContainerConfigureItemBlock)configure;
- (void)appendItem:(GLBDataViewItem*)item;
- (void)appendItems:(NSArray*)items;

- (__kindof GLBDataViewItem*)insertIdentifier:(NSString*)identifier atIndex:(NSUInteger)index byData:(id)data;
- (__kindof GLBDataViewItem*)insertIdentifier:(NSString*)identifier atIndex:(NSUInteger)index byData:(id)data configure:(GLBDataViewContainerConfigureItemBlock)configure;
- (__kindof GLBDataViewItem*)insertIdentifier:(NSString*)identifier atIndex:(NSUInteger)index byData:(id)data order:(NSUInteger)order;
- (__kindof GLBDataViewItem*)insertIdentifier:(NSString*)identifier atIndex:(NSUInteger)index byData:(id)data order:(NSUInteger)order configure:(GLBDataViewContainerConfigureItemBlock)configure;
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
#endif
/*--------------------------------------------------*/
