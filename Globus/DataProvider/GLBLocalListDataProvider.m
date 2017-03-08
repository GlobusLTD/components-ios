/*--------------------------------------------------*/

#import "GLBLocalListDataProvider.h"
#import "GLBTimer.h"

/*--------------------------------------------------*/

@interface GLBLocalListDataProvider () {
    NSURL* _cacheFileUrl;
    
    NSUInteger _currentPageIndex;
    NSArray< NSURL* >* _fileUrls;
    NSMutableArray< id< GLBListDataProviderModel > >* _models;
    
    BOOL _isSearching;
    NSString* _searchText;
    NSUInteger _searchCurrentPageIndex;
    NSArray< NSURL* >* _searchFileUrls;
    NSMutableArray< id< GLBListDataProviderModel > >* _searchModels;
    
    GLBTimer* _loadTimer;
    GLBTimer* _reloadTimer;
}

@end

/*--------------------------------------------------*/

@implementation GLBLocalListDataProvider

#pragma mark - Synthesize

@synthesize delegate = _delegate;
@synthesize error = _error;

#pragma mark - Init / Free

- (instancetype)init {
    self = [super init];
    if(self != nil) {
        _baseFileName = self.glb_className;
        [self setup];
    }
    return self;
}

- (instancetype)initWithBaseFileName:(NSString*)baseFileName {
    self = [super init];
    if(self != nil) {
        _baseFileName = baseFileName;
        [self setup];
    }
    return self;
}

- (void)setup {
    _canReload = YES;
    _canSearch = NO;
    
    _cacheFileUrl = [self __fileUrlWithSuffix:@"Cache"];
    _fileUrls = [self __fileUrls];
    _models = [NSMutableArray array];
    
    _loadTimer = [GLBTimer timerWithInterval:0.2f];
    _loadTimer.actionFinished = [GLBAction actionWithTarget:self action:@selector(__load)];
    
    _reloadTimer = [GLBTimer timerWithInterval:0.2f];
    _reloadTimer.actionFinished = [GLBAction actionWithTarget:self action:@selector(__reload)];
}

#pragma mark - Public

- (id< GLBListDataProviderModel >)modelWithJson:(id)json {
    return nil;
}

#pragma mark - GLBListDataProvider

- (NSArray< id< GLBListDataProviderModel > >*)models {
    return _models;
}

- (void)load {
    [_reloadTimer stop];
    [_loadTimer start];
    
    [_delegate startLoadingForDataProvider:self];
}

- (void)cancel {
    [_reloadTimer stop];
    [_loadTimer stop];
    
    _searchCurrentPageIndex = 0;
    _currentPageIndex = 0;
}

- (BOOL)canLoadMore {
    if((_loadTimer.isStarted == NO) && (_reloadTimer.isStarted == NO)) {
        if(_isSearching == YES) {
            return (_searchCurrentPageIndex < _searchFileUrls.count);
        }
        return (_currentPageIndex < _fileUrls.count);
    }
    return NO;
}

- (BOOL)canCache {
    return (_cacheFileUrl != nil);
}

- (NSArray< id< GLBListDataProviderModel > >*)cacheModels {
    return [self __modelsWithFileUrl:_cacheFileUrl];
}

- (void)reload {
    [_loadTimer stop];
    [_reloadTimer start];
    
    [_delegate startLoadingForDataProvider:self];
}

- (BOOL)isSearching {
    return _isSearching;
}

- (void)setSearchText:(NSString*)searchText {
    if([_searchText isEqualToString:searchText] == NO) {
        [self cancel];
        _searchText = searchText;
        _searchFileUrls = [self __fileUrlsWithSuffix:searchText];
        [_searchModels removeAllObjects];
        [self load];
    }
}

- (NSString*)searchText {
    return _searchText;
}

- (NSArray< id< GLBListDataProviderModel > >*)searchModels {
    return _searchModels;
}

- (void)beginSearch {
    if(_isSearching == NO) {
        _isSearching = YES;
        _searchModels = [NSMutableArray array];
    }
}

- (void)endSearch {
    if(_isSearching == YES) {
        [_searchModels removeAllObjects];
        _searchFileUrls = nil;
        _isSearching = NO;
        
        [self reload];
    }
}

#pragma mark - Private

- (NSURL*)__fileUrlWithSuffix:(NSString*)suffix {
    return [self __fileUrlWithSuffix:suffix index:NSNotFound];
}

- (NSURL*)__fileUrlWithIndex:(NSUInteger)index {
    return [self __fileUrlWithSuffix:nil index:index];
}

- (NSURL*)__fileUrlWithSuffix:(NSString*)suffix index:(NSUInteger)index {
    NSMutableString* fileName = [NSMutableString stringWithString:_baseFileName];
    if(suffix != nil) {
        [fileName appendFormat:@"-%@", suffix];
    }
    if(index != NSNotFound) {
        [fileName appendFormat:@"-%d", (int)index];
    }
    return [NSBundle.mainBundle URLForResource:fileName withExtension:@"json"];
}

- (NSArray< NSURL* >*)__fileUrls {
    return [self __fileUrlsWithSuffix:nil];
}

- (NSArray< NSURL* >*)__fileUrlsWithSuffix:(NSString*)suffix {
    NSMutableArray< NSURL* >* result = [NSMutableArray array];
    NSUInteger page = 0;
    while(true) {
        NSURL* fileUrl = [self __fileUrlWithSuffix:suffix index:page];
        if(fileUrl == nil) {
            break;
        }
        [result addObject:fileUrl];
        page++;
    }
    return result;
}

- (NSArray< id< GLBListDataProviderModel > >*)__modelsWithFileUrl:(NSURL*)url {
    NSMutableArray< id< GLBListDataProviderModel > >* result = [NSMutableArray array];
    NSData* data = [NSData dataWithContentsOfURL:url];
    if(data != nil) {
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if([json glb_isArray] == YES) {
            for(id jsonItem in json) {
                id model = [self modelWithJson:jsonItem];
                if(model != nil) {
                    [result addObject:model];
                }
            }
        }
    }
    return result;
}

- (void)__load {
    [self __loadWithPageIndex:_currentPageIndex];
}

- (void)__reload {
    [self __loadWithPageIndex:0];
}

- (void)__loadWithPageIndex:(NSUInteger)pageIndex {
    NSArray< NSURL* >* fileUrls = (_isSearching == YES) ? _searchFileUrls : _fileUrls;
    if(pageIndex < fileUrls.count) {
        NSArray* models = [self __modelsWithFileUrl:fileUrls[pageIndex]];
        if(_isSearching == YES) {
            if(pageIndex == 0) {
                [_searchModels addObjectsFromArray:models];
            } else {
                [_searchModels setArray:models];
            }
            _searchCurrentPageIndex = pageIndex + 1;
        } else {
            if(pageIndex == 0) {
                [_models addObjectsFromArray:models];
            } else {
                [_models setArray:models];
            }
            _currentPageIndex = pageIndex + 1;
        }
        [_delegate finishLoadingForDataProvider:self models:models first:(pageIndex == 0)];
    } else {
        if(_isSearching == YES) {
            _searchCurrentPageIndex = pageIndex + 1;
        } else {
            _currentPageIndex = pageIndex + 1;
        }
        [_delegate finishLoadingForDataProvider:self models:@[] first:(pageIndex == 0)];
    }
}

@end

/*--------------------------------------------------*/
