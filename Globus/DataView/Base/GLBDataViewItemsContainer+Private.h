/*--------------------------------------------------*/

#import "GLBDataViewItemsContainer.h"
#import "GLBDataViewContainer+Private.h"
#import "GLBDataViewItem+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewItemsContainer () {
@protected
    NSMutableArray< __kindof GLBDataViewItem* >* _entries;
}

- (void)_prependEntry:(GLBDataViewItem*)entry;
- (void)_prependEntries:(NSArray*)entries;
- (void)_appendEntry:(GLBDataViewItem*)entry;
- (void)_appendEntries:(NSArray*)entries;
- (void)_insertEntry:(GLBDataViewItem*)entry atIndex:(NSUInteger)index;
- (void)_insertEntries:(NSArray*)entries atIndex:(NSUInteger)index;
- (void)_insertEntry:(GLBDataViewItem*)entry aboveEntry:(GLBDataViewItem*)aboveEntry;
- (void)_insertEntries:(NSArray*)entries aboveEntry:(GLBDataViewItem*)aboveEntry;
- (void)_insertEntry:(GLBDataViewItem*)entry belowEntry:(GLBDataViewItem*)belowEntry;
- (void)_insertEntries:(NSArray*)entries belowEntry:(GLBDataViewItem*)belowEntry;
- (void)_replaceOriginEntry:(GLBDataViewItem*)originEntry withEntry:(GLBDataViewItem*)entry;
- (void)_replaceOriginEntries:(NSArray*)originEntries withEntries:(NSArray*)entries;
- (void)_deleteEntry:(GLBDataViewItem*)entry;
- (void)_deleteEntries:(NSArray*)entries;
- (void)_deleteAllEntries;

- (CGRect)_frameEntriesForAvailableFrame:(CGRect)frame;
- (void)_layoutEntriesForFrame:(CGRect)frame;

- (void)_willEntriesLayoutForBounds:(CGRect)bounds;
- (void)_didEntriesLayoutForBounds:(CGRect)bounds;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
