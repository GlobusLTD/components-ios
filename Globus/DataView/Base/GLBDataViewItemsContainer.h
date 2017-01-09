/*--------------------------------------------------*/

#import "GLBDataViewContainer.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewItemsContainer : GLBDataViewContainer

@property(nonatomic, readonly, strong) NSArray* entries;

- (void)prependEntry:(GLBDataViewItem*)entry;
- (void)prependEntries:(NSArray*)entries;
- (void)appendEntry:(GLBDataViewItem*)entry;
- (void)appendEntries:(NSArray*)entries;
- (void)insertEntry:(GLBDataViewItem*)entry atIndex:(NSUInteger)index;
- (void)insertEntries:(NSArray*)entries atIndex:(NSUInteger)index;
- (void)insertEntry:(GLBDataViewItem*)entry aboveEntry:(GLBDataViewItem*)aboveEntry;
- (void)insertEntries:(NSArray*)entries aboveEntry:(GLBDataViewItem*)aboveEntry;
- (void)insertEntry:(GLBDataViewItem*)entry belowEntry:(GLBDataViewItem*)belowEntry;
- (void)insertEntries:(NSArray*)entries belowEntry:(GLBDataViewItem*)belowEntry;
- (void)replaceOriginEntry:(GLBDataViewItem*)originEntry withEntry:(GLBDataViewItem*)entry;
- (void)replaceOriginEntries:(NSArray*)originEntries withEntries:(NSArray*)entries;
- (void)deleteEntry:(GLBDataViewItem*)entry;
- (void)deleteEntries:(NSArray*)entries;
- (void)deleteAllEntries;

- (CGRect)frameEntriesForAvailableFrame:(CGRect)frame;
- (void)layoutEntriesForFrame:(CGRect)frame;

- (void)willEntriesLayoutForBounds:(CGRect)bounds;
- (void)didEntriesLayoutForBounds:(CGRect)bounds;

- (NSArray*)updateAccessibilityEntries;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
