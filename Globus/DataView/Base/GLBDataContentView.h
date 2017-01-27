/*--------------------------------------------------*/

#import "GLBDataViewTypes.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBDataView;
@class GLBDataViewItem;
@class GLBDataViewCell;
@class GLBDataContentLayerView;

/*--------------------------------------------------*/

@interface GLBDataContentView : UIView

@property(nonatomic, readwrite, weak, nullable) GLBDataView* dataView;

- (void)setup NS_REQUIRES_SUPER;

- (void)registerIdentifier:(nonnull NSString*)identifier withViewClass:(nonnull Class)viewClass;
- (void)unregisterIdentifier:(nonnull NSString*)identifier;
- (void)unregisterAllIdentifiers;

- (nullable Class)cellClassWithItem:(nullable GLBDataViewItem*)item;
- (nullable Class)cellClassWithIdentifier:(nonnull NSString*)identifier;

- (nullable GLBDataContentLayerView*)layerWithItem:(nonnull GLBDataViewItem*)item;

- (nullable __kindof GLBDataViewCell*)dequeueCellWithItem:(nonnull GLBDataViewItem*)item;
- (void)enqueueCell:(nonnull GLBDataViewCell*)cell item:(nonnull GLBDataViewItem*)item;

- (void)receiveMemoryWarning;

@end

/*--------------------------------------------------*/

@interface GLBDataContentLayerView : UIView

@property(nonatomic, readwrite, weak, nullable) GLBDataContentView* contentView;
@property(nonatomic, readonly) NSUInteger order;

- (nullable instancetype)initWithContentView:(nonnull GLBDataContentView*)contentView order:(NSUInteger)order;

- (void)setup NS_REQUIRES_SUPER;

- (nullable __kindof GLBDataViewCell*)dequeueCellWithIdentifier:(nonnull NSString*)identifier;
- (void)enqueueCell:(nonnull GLBDataViewCell*)cell identifier:(nonnull NSString*)identifier;

- (void)receiveMemoryWarning;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
