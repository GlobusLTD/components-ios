/*--------------------------------------------------*/

#import "GLBLocalSimpleDataProvider.h"
#import "GLBTimer.h"

/*--------------------------------------------------*/

@interface GLBLocalSimpleDataProvider () {
    NSURL* _cacheFileUrl;
    
    NSURL* _fileUrl;
    id _model;
    
    GLBTimer* _loadTimer;
    GLBTimer* _reloadTimer;
}

@end

/*--------------------------------------------------*/

@implementation GLBLocalSimpleDataProvider

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
    
    _cacheFileUrl = [self __fileUrlWithSuffix:@"Cache"];
    _fileUrl = [self __fileUrl];
    
    _loadTimer = [GLBTimer timerWithInterval:0.2f];
    _loadTimer.actionFinished = [GLBAction actionWithTarget:self action:@selector(__load)];
    
    _reloadTimer = [GLBTimer timerWithInterval:0.2f];
    _reloadTimer.actionFinished = [GLBAction actionWithTarget:self action:@selector(__load)];
}

#pragma mark - Public

- (id)modelWithJsonObject:(id)jsonObject {
    return nil;
}

#pragma mark - GLBSimpleDataProvider

- (id)model {
    return _model;
}

- (void)load {
    [_reloadTimer stop];
    [_loadTimer start];
    
    [_delegate startLoadingForDataProvider:self];
}

- (void)cancel {
    [_reloadTimer stop];
    [_loadTimer stop];
}

- (BOOL)canCache {
    return (_cacheFileUrl != nil);
}

- (id)cacheModel {
    return [self __modelWithFileUrl:_cacheFileUrl];
}

- (void)reload {
    [_loadTimer stop];
    [_reloadTimer start];
    
    [_delegate startLoadingForDataProvider:self];
}

#pragma mark - Private

- (NSURL*)__fileUrl {
    return [self __fileUrlWithSuffix:nil];
}

- (NSURL*)__fileUrlWithSuffix:(NSString*)suffix {
    NSMutableString* fileName = [NSMutableString stringWithString:_baseFileName];
    if(suffix != nil) {
        [fileName appendFormat:@"-%@", suffix];
    }
    return [NSBundle.mainBundle URLForResource:fileName withExtension:@"json"];
}

- (id)__modelWithFileUrl:(NSURL*)url {
    id result = nil;
    NSData* data = [NSData dataWithContentsOfURL:url];
    if(data != nil) {
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if(jsonObject != nil) {
            result = [self modelWithJsonObject:jsonObject];
        }
    }
    return result;
}

- (void)__load {
    _model = [self __modelWithFileUrl:_fileUrl];
    [_delegate finishLoadingForDataProvider:self model:_model];
}

@end

/*--------------------------------------------------*/
