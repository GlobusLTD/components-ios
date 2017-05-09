/*--------------------------------------------------*/

#import "NSObject+GLBNS.h"

/*--------------------------------------------------*/

@protocol GLBListDataProviderDelegate;

/*--------------------------------------------------*/

@protocol GLBListDataProvider

@property(nonatomic, nullable, weak) id< GLBListDataProviderDelegate > delegate;
@property(nonatomic, nullable, readonly, strong) id error;

@property(nonatomic, nonnull, readonly, strong) NSArray* models;

- (void)load;
- (void)cancel;

@property(nonatomic, readonly) BOOL canLoadMore;

@property(nonatomic, readonly) BOOL canCache;
@property(nonatomic, nonnull, readonly, strong) NSArray* cacheModels;

@property(nonatomic, readonly) BOOL canReload;
- (void)reload;

@property(nonatomic, readonly) BOOL canSearch;
@property(nonatomic, readonly) BOOL isSearching;
@property(nonatomic, nullable, strong) NSString* searchText;
@property(nonatomic, nonnull, readonly, strong) NSArray* searchModels;

- (void)beginSearch;
- (void)endSearch;

@end

/*--------------------------------------------------*/

@protocol GLBListDataProviderDelegate

- (void)startLoadingForDataProvider:(nonnull id< GLBListDataProvider >)dataProvider;
- (void)finishLoadingForDataProvider:(nonnull id< GLBListDataProvider >)dataProvider error:(nullable id)error;
- (void)finishLoadingForDataProvider:(nonnull id< GLBListDataProvider >)dataProvider models:(nonnull NSArray*)models first:(BOOL)first;

@end

/*--------------------------------------------------*/
