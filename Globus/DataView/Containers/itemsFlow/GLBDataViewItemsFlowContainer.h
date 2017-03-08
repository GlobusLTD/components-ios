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
@property(nonatomic, nullable, strong) __kindof GLBDataViewItem* headerItem;
@property(nonatomic, nullable, strong) __kindof GLBDataViewItem* footerItem;
@property(nonatomic, nonnull, readonly, strong) NSArray* contentItems;

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
#endif
/*--------------------------------------------------*/
