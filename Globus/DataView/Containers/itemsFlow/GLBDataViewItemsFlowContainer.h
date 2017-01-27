/*--------------------------------------------------*/

#import "GLBDataViewItemsContainer.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewItemsFlowContainer : GLBDataViewItemsContainer

@property(nonatomic) GLBDataViewContainerOrientation orientation;
@property(nonatomic) UIEdgeInsets margin;
@property(nonatomic) UIOffset spacing;
@property(nonatomic) CGSize defaultSize;
@property(nonatomic) CGFloat defaultWidth;
@property(nonatomic) CGFloat defaultHeight;
@property(nonatomic) NSUInteger defaultOrder;
@property(nonatomic, nullable, strong) __kindof GLBDataViewItem* header;
@property(nonatomic, nullable, strong) __kindof GLBDataViewItem* footer;
@property(nonatomic, nonnull, readonly, strong) NSArray* items;

+ (nonnull instancetype)containerWithOrientation:(GLBDataViewContainerOrientation)orientation NS_SWIFT_UNAVAILABLE("Use init(orientation:)");

- (nonnull instancetype)initWithOrientation:(GLBDataViewContainerOrientation)orientation;

- (nonnull __kindof GLBDataViewItem*)prependIdentifier:(nonnull NSString*)identifier byData:(nullable id)data;
- (nonnull __kindof GLBDataViewItem*)prependIdentifier:(nonnull NSString*)identifier byData:(nullable id)data configure:(nullable GLBDataViewContainerConfigureItemBlock)configure;
- (nonnull __kindof GLBDataViewItem*)prependIdentifier:(nonnull NSString*)identifier byData:(nullable id)data order:(NSUInteger)order;
- (nonnull __kindof GLBDataViewItem*)prependIdentifier:(nonnull NSString*)identifier byData:(nullable id)data order:(NSUInteger)order configure:(nullable GLBDataViewContainerConfigureItemBlock)configure;
- (void)prependItem:(nonnull GLBDataViewItem*)item;
- (void)prependItems:(nonnull NSArray*)items;

- (nonnull __kindof GLBDataViewItem*)appendIdentifier:(nonnull NSString*)identifier byData:(nullable id)data;
- (nonnull __kindof GLBDataViewItem*)appendIdentifier:(nonnull NSString*)identifier byData:(nullable id)data configure:(nullable GLBDataViewContainerConfigureItemBlock)configure;
- (nonnull __kindof GLBDataViewItem*)appendIdentifier:(nonnull NSString*)identifier byData:(nullable id)data order:(NSUInteger)order;
- (nonnull __kindof GLBDataViewItem*)appendIdentifier:(nonnull NSString*)identifier byData:(nullable id)data order:(NSUInteger)order configure:(nullable GLBDataViewContainerConfigureItemBlock)configure;
- (void)appendItem:(nonnull GLBDataViewItem*)item;
- (void)appendItems:(nonnull NSArray*)items;

- (nonnull __kindof GLBDataViewItem*)insertIdentifier:(nonnull NSString*)identifier atIndex:(NSUInteger)index byData:(nullable id)data;
- (nonnull __kindof GLBDataViewItem*)insertIdentifier:(nonnull NSString*)identifier atIndex:(NSUInteger)index byData:(nullable id)data configure:(nullable GLBDataViewContainerConfigureItemBlock)configure;
- (nonnull __kindof GLBDataViewItem*)insertIdentifier:(nonnull NSString*)identifier atIndex:(NSUInteger)index byData:(nullable id)data order:(NSUInteger)order;
- (nonnull __kindof GLBDataViewItem*)insertIdentifier:(nonnull NSString*)identifier atIndex:(NSUInteger)index byData:(nullable id)data order:(NSUInteger)order configure:(nullable GLBDataViewContainerConfigureItemBlock)configure;
- (void)insertItem:(nonnull GLBDataViewItem*)item atIndex:(NSUInteger)index;
- (void)insertItems:(nonnull NSArray*)items atIndex:(NSUInteger)index;
- (void)insertItem:(nonnull GLBDataViewItem*)item aboveItem:(nonnull GLBDataViewItem*)aboveItem;
- (void)insertItems:(nonnull NSArray*)items aboveItem:(nonnull GLBDataViewItem*)aboveItem;
- (void)insertItem:(nonnull GLBDataViewItem*)item belowItem:(nonnull GLBDataViewItem*)belowItem;
- (void)insertItems:(nonnull NSArray*)items belowItem:(nonnull GLBDataViewItem*)belowItem;

- (void)replaceOriginItem:(nonnull GLBDataViewItem*)originItem withItem:(nonnull GLBDataViewItem*)item;
- (void)replaceOriginItems:(nonnull NSArray*)originItems withItems:(nonnull NSArray*)items;

- (void)deleteItem:(nonnull GLBDataViewItem*)item;
- (void)deleteItems:(nonnull NSArray*)items;
- (void)deleteAllItems;

@end

/*--------------------------------------------------*/

@interface GLBDataViewItemsFlowContainer (Unavailable)

- (void)prependEntry:(nonnull GLBDataViewItem*)entry NS_UNAVAILABLE;
- (void)prependEntries:(nonnull NSArray*)entries NS_UNAVAILABLE;
- (void)appendEntry:(nonnull GLBDataViewItem*)entry NS_UNAVAILABLE;
- (void)appendEntries:(nonnull NSArray*)entries NS_UNAVAILABLE;
- (void)insertEntry:(nonnull GLBDataViewItem*)entry atIndex:(NSUInteger)index NS_UNAVAILABLE;
- (void)insertEntries:(nonnull NSArray*)entries atIndex:(NSUInteger)index NS_UNAVAILABLE;
- (void)insertEntry:(nonnull GLBDataViewItem*)entry aboveEntry:(nonnull GLBDataViewItem*)aboveEntry NS_UNAVAILABLE;
- (void)insertEntries:(nonnull NSArray*)entries aboveEntry:(nonnull GLBDataViewItem*)aboveEntry NS_UNAVAILABLE;
- (void)insertEntry:(nonnull GLBDataViewItem*)entry belowEntry:(nonnull GLBDataViewItem*)belowEntry NS_UNAVAILABLE;
- (void)insertEntries:(nonnull NSArray*)entries belowEntry:(nonnull GLBDataViewItem*)belowEntry NS_UNAVAILABLE;
- (void)replaceOriginEntry:(nonnull GLBDataViewItem*)originEntry withEntry:(nonnull GLBDataViewItem*)entry NS_UNAVAILABLE;
- (void)replaceOriginEntries:(nonnull NSArray*)originEntries withEntries:(nonnull NSArray*)entries NS_UNAVAILABLE;
- (void)deleteEntry:(nonnull GLBDataViewItem*)entry NS_UNAVAILABLE;
- (void)deleteEntries:(nonnull NSArray*)entries NS_UNAVAILABLE;
- (void)deleteAllEntries NS_UNAVAILABLE;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
