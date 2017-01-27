/*--------------------------------------------------*/

#import "GLBDataViewContainer.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewItemsContainer : GLBDataViewContainer

@property(nonatomic, nonnull, readonly, strong) NSArray< __kindof GLBDataViewItem* >* entries;

- (void)prependEntry:(nonnull GLBDataViewItem*)entry;
- (void)prependEntries:(nonnull NSArray*)entries;
- (void)appendEntry:(nonnull GLBDataViewItem*)entry;
- (void)appendEntries:(nonnull NSArray*)entries;
- (void)insertEntry:(nonnull GLBDataViewItem*)entry atIndex:(NSUInteger)index;
- (void)insertEntries:(nonnull NSArray*)entries atIndex:(NSUInteger)index;
- (void)insertEntry:(nonnull GLBDataViewItem*)entry aboveEntry:(nonnull GLBDataViewItem*)aboveEntry;
- (void)insertEntries:(nonnull NSArray*)entries aboveEntry:(nonnull GLBDataViewItem*)aboveEntry;
- (void)insertEntry:(nonnull GLBDataViewItem*)entry belowEntry:(nonnull GLBDataViewItem*)belowEntry;
- (void)insertEntries:(nonnull NSArray*)entries belowEntry:(nonnull GLBDataViewItem*)belowEntry;
- (void)replaceOriginEntry:(nonnull GLBDataViewItem*)originEntry withEntry:(nonnull GLBDataViewItem*)entry;
- (void)replaceOriginEntries:(nonnull NSArray*)originEntries withEntries:(nonnull NSArray*)entries;
- (void)deleteEntry:(nonnull GLBDataViewItem*)entry;
- (void)deleteEntries:(nonnull NSArray*)entries;
- (void)deleteAllEntries;

- (CGRect)frameEntriesForAvailableFrame:(CGRect)frame;
- (void)layoutEntriesForFrame:(CGRect)frame;

- (void)willEntriesLayoutForBounds:(CGRect)bounds;
- (void)didEntriesLayoutForBounds:(CGRect)bounds;

- (nonnull NSArray*)updateAccessibilityEntries;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
