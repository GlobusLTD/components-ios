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

@property(nonatomic, readwrite, weak, nullable) GLBDataView* view;

- (void)setup NS_REQUIRES_SUPER;

- (void)registerIdentifier:(NSString* _Nonnull)identifier withViewClass:(_Nonnull Class)viewClass;
- (void)unregisterIdentifier:(NSString* _Nonnull)identifier;
- (void)unregisterAllIdentifiers;

- (_Nullable Class)cellClassWithItem:(GLBDataViewItem* _Nullable)item;
- (_Nullable Class)cellClassWithIdentifier:(NSString* _Nonnull)identifier;

- (GLBDataContentLayerView* _Nullable)layerWithItem:(GLBDataViewItem* _Nonnull)item;

- (__kindof GLBDataViewCell* _Nullable)dequeueCellWithItem:(GLBDataViewItem* _Nonnull)item;
- (void)enqueueCell:(GLBDataViewCell* _Nonnull)cell item:(GLBDataViewItem* _Nonnull)item;

@end

/*--------------------------------------------------*/

@interface GLBDataContentLayerView : UIView

@property(nonatomic, readwrite, weak, nullable) GLBDataContentView* contentView;
@property(nonatomic, readonly) NSUInteger order;

- (_Nullable instancetype)initWithContentView:(GLBDataContentView* _Nonnull)contentView order:(NSUInteger)order;

- (void)setup NS_REQUIRES_SUPER;

- (__kindof GLBDataViewCell* _Nullable)dequeueCellWithIdentifier:(NSString* _Nonnull)identifier;
- (void)enqueueCell:(GLBDataViewCell* _Nonnull)cell identifier:(NSString* _Nonnull)identifier;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
