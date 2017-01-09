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

- (void)registerIdentifier:(NSString* _Nonnull)identifier withViewClass:(Class _Nonnull)viewClass;
- (void)unregisterIdentifier:(NSString* _Nonnull)identifier;
- (void)unregisterAllIdentifiers;

- (Class _Nullable)cellClassWithItem:(GLBDataViewItem* _Nullable)item;
- (Class _Nullable)cellClassWithIdentifier:(NSString* _Nonnull)identifier;

- (GLBDataContentLayerView* _Nullable)layerWithItem:(GLBDataViewItem* _Nonnull)item;

- (__kindof GLBDataViewCell* _Nullable)dequeueCellWithItem:(GLBDataViewItem* _Nonnull)item;
- (void)enqueueCell:(GLBDataViewCell* _Nonnull)cell item:(GLBDataViewItem* _Nonnull)item;

- (void)receiveMemoryWarning;

@end

/*--------------------------------------------------*/

@interface GLBDataContentLayerView : UIView

@property(nonatomic, readwrite, weak, nullable) GLBDataContentView* contentView;
@property(nonatomic, readonly) NSUInteger order;

- (instancetype _Nullable)initWithContentView:(GLBDataContentView* _Nonnull)contentView order:(NSUInteger)order;

- (void)setup NS_REQUIRES_SUPER;

- (__kindof GLBDataViewCell* _Nullable)dequeueCellWithIdentifier:(NSString* _Nonnull)identifier;
- (void)enqueueCell:(GLBDataViewCell* _Nonnull)cell identifier:(NSString* _Nonnull)identifier;

- (void)receiveMemoryWarning;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
