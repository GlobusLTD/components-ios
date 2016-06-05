/*--------------------------------------------------*/

#import "GLBApiProvider.h"
#import "GLBApiManager.h"
#import "GLBApiRequest+Private.h"
#import "GLBApiResponse+Private.h"

/*--------------------------------------------------*/

#import "NSURL+GLBNS.h"
#import "NSString+GLBNS.h"
#import "NSArray+GLBNS.h"
#import "NSDictionary+GLBNS.h"
#import "NSData+GLBNS.h"
#import "NSError+GLBNS.h"

/*--------------------------------------------------*/

@class GLBApiProviderQuery;

/*--------------------------------------------------*/

@interface GLBApiProvider () < NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate, NSURLSessionDownloadDelegate > {
    NSMutableDictionary* _urlParams;
    NSMutableDictionary* _headers;
    NSMutableDictionary* _bodyParams;
}

@property(nonatomic, readonly, strong) NSURLSession* session;
@property(nonatomic, readonly, strong) NSURLSessionConfiguration* configuration;
@property(nonatomic, readonly, strong) NSOperationQueue* queue;
@property(nonatomic, readonly, strong) NSLock* lock;
@property(nonatomic, readonly, strong) NSMutableDictionary* tasks;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@interface GLBApiProviderQuery : NSObject

@property(nonatomic, readonly, strong) GLBApiProvider* provider;
@property(nonatomic, readonly, assign) NSTimeInterval createTime;
@property(nonatomic, readonly, strong) GLBApiRequest* request;
@property(nonatomic, readonly, weak) id target;
@property(nonatomic, readonly, copy) GLBApiProviderProgressBlock uploadBlock;
@property(nonatomic, readonly, copy) GLBApiProviderProgressBlock downloadBlock;
@property(nonatomic, readonly, copy) GLBApiProviderCompleteBlock completeBlock;

- (instancetype)initWithProvider:(GLBApiProvider*)provider
                         request:(GLBApiRequest*)request
                          target:(id)target
                   completeBlock:(GLBApiProviderCompleteBlock)completeBlock;

- (instancetype)initWithProvider:(GLBApiProvider*)provider
                         request:(GLBApiRequest*)request
                          target:(id)target
                   downloadBlock:(GLBApiProviderProgressBlock)downloadBlock
                   completeBlock:(GLBApiProviderCompleteBlock)completeBlock;

- (instancetype)initWithProvider:(GLBApiProvider*)provider
                         request:(GLBApiRequest*)request
                          target:(id)target
                     uploadBlock:(GLBApiProviderProgressBlock)uploadBlock
                   completeBlock:(GLBApiProviderCompleteBlock)completeBlock;

- (void)_didUploadBytes:(int64_t)uploadBytes totalBytes:(int64_t)totalBytes;
- (void)_didDownloadBytes:(int64_t)downloadBytes totalBytes:(int64_t)totalBytes;
- (void)_didResumeDownloadAtOffset:(int64_t)offset totalBytes:(int64_t)totalBytes;
- (void)_didReceiveResponse:(NSURLResponse*)response;
- (void)_didBecomeDownloadTask:(NSURLSessionDownloadTask*)downloadTask;
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_9_0
- (void)_didBecomeStreamTask:(NSURLSessionStreamTask*)streamTask;
#endif
- (void)_didReceiveData:(NSData*)data;
- (void)_didDownloadToURL:(NSURL*)location;
- (void)_didCompleteWithError:(NSError*)error;

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBApiProvider

#pragma mark - Init

@synthesize session = _session;
@synthesize configuration = _configuration;
@synthesize queue = _queue;
@synthesize lock = _lock;
@synthesize tasks = _tasks;

#pragma mark - Init / Free

- (instancetype)initWithName:(NSString*)name {
    return [self initWithName:name url:nil headers:nil];
}

- (instancetype)initWithName:(NSString*)name url:(NSURL*)url {
    return [self initWithName:name url:url headers:nil];
}

- (instancetype)initWithName:(NSString*)name url:(NSURL*)url headers:(NSDictionary*)headers {
    self = [super init];
    if(self != nil) {
        _name = name.copy;
        if(url != nil) {
            _url = url.copy;
        }
        if(headers != nil) {
            _headers = [NSMutableDictionary dictionaryWithDictionary:headers];
        }
        [self setup];
    }
    return self;
}

- (void)setup {
    if(_urlParams == nil) {
        _urlParams = [NSMutableDictionary dictionary];
    }
    if(_headers == nil) {
        _headers = [NSMutableDictionary dictionary];
    }
    if(_bodyParams == nil) {
        _bodyParams = [NSMutableDictionary dictionary];
    }
    
    _timeoutIntervalForRequest = 30.0f;
    _timeoutIntervalForResource = 60.0f;
    _networkServiceType = NSURLNetworkServiceTypeDefault;
    _allowsCellularAccess = YES;
    _minimumTLSProtocol = kSSLProtocolUnknown;
    _maximumTLSProtocol = kSSLProtocolUnknown;
    _shouldPipelining = YES;
    _shouldCookies = YES;
    _cookieAcceptPolicy = NSHTTPCookieAcceptPolicyNever;
    _maximumConnectionsPerHost = 1;
    _cachePolicy = NSURLRequestUseProtocolCachePolicy;
}

#pragma mark - Property

- (NSURLSession*)session {
    if(_session == nil) {
        _session = [NSURLSession sessionWithConfiguration:self.configuration
                                                 delegate:self
                                            delegateQueue:self.queue];
    }
    return _session;
}

- (NSURLSessionConfiguration*)configuration {
    if(_configuration == nil) {
        _configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _configuration.timeoutIntervalForRequest = _timeoutIntervalForRequest;
        _configuration.timeoutIntervalForResource = _timeoutIntervalForResource;
        _configuration.networkServiceType = _networkServiceType;
        _configuration.allowsCellularAccess = _allowsCellularAccess;
        if(_minimumTLSProtocol != kSSLProtocolUnknown) {
            _configuration.TLSMinimumSupportedProtocol = _minimumTLSProtocol;
        }
        if(_maximumTLSProtocol != kSSLProtocolUnknown) {
            _configuration.TLSMaximumSupportedProtocol = _maximumTLSProtocol;
        }
        _configuration.HTTPShouldUsePipelining = _shouldPipelining;
        _configuration.HTTPShouldSetCookies = _shouldCookies;
        _configuration.HTTPCookieAcceptPolicy = _cookieAcceptPolicy;
        _configuration.HTTPMaximumConnectionsPerHost = _maximumConnectionsPerHost;
        _configuration.requestCachePolicy = _cachePolicy;
    }
    return _configuration;
}

- (NSOperationQueue*)queue {
    if(_queue == nil) {
        _queue = [NSOperationQueue new];
        _queue.maxConcurrentOperationCount = 1;
    }
    return _queue;
}

- (NSLock*)lock {
    if(_lock == nil) {
        _lock = [NSLock new];
    }
    return _lock;
}

- (NSMutableDictionary*)tasks {
    if(_tasks == nil) {
        _tasks = [NSMutableDictionary dictionary];
    }
    return _tasks;
}

- (void)setManager:(GLBApiManager*)manager {
    if(_manager != manager) {
        if(_manager != nil) {
            [_manager unregisterProvider:self];
        }
        _manager = manager;
        if(_manager != nil) {
            [_manager registerProvider:self];
        }
    }
}

- (void)setUrlParams:(NSDictionary*)urlParams {
    if([_urlParams isEqualToDictionary:urlParams] == NO) {
        [_urlParams setDictionary:urlParams];
    }
}

- (NSDictionary*)urlParams {
    return _urlParams.copy;
}

- (void)setHeaders:(NSDictionary*)headers {
    if([_headers isEqualToDictionary:headers] == NO) {
        [_headers setDictionary:headers];
    }
}

- (NSDictionary*)headers {
    return _headers.copy;
}

- (void)setBodyParams:(NSDictionary*)bodyParams {
    if([_bodyParams isEqualToDictionary:bodyParams] == NO) {
        [_bodyParams setDictionary:bodyParams];
    }
}

- (NSDictionary*)bodyParams {
    return _bodyParams.copy;
}

#pragma mark - Public

- (void)setUrlParam:(NSString*)urlParam value:(NSString*)value {
    if(value != nil) {
        _urlParams[urlParam] = value;
    } else {
        [_urlParams removeObjectForKey:urlParam];
    }
}

- (void)setHeader:(NSString*)header value:(NSString*)value {
    if(value != nil) {
        _headers[header] = value;
    } else {
        [_headers removeObjectForKey:header];
    }
}

- (void)setBodyParam:(NSString*)bodyParam value:(NSString*)value {
    if(value != nil) {
        _bodyParams[bodyParam] = value;
    } else {
        [_bodyParams removeObjectForKey:bodyParam];
    }
}

- (void)sendRequest:(GLBApiRequest*)request
           byTarget:(id)target
      completeBlock:(GLBApiProviderCompleteBlock)completeBlock {
    if(request.provider != nil) {
        @throw [NSException exceptionWithName:@"GLBApiProvider" reason:@"This request is already sent" userInfo:nil];
    }
    GLBApiProviderQuery* query = [[GLBApiProviderQuery alloc] initWithProvider:self
                                                                       request:request
                                                                        target:target
                                                                 completeBlock:completeBlock];
    if(query != nil) {
        [self _sendQuery:query];
    }
}

- (void)sendRequest:(GLBApiRequest*)request
           byTarget:(id)target
      downloadBlock:(GLBApiProviderProgressBlock)downloadBlock
      completeBlock:(GLBApiProviderCompleteBlock)completeBlock {
    if(request.provider != nil) {
        @throw [NSException exceptionWithName:@"GLBApiProvider" reason:@"This request is already sent" userInfo:nil];
    }
    GLBApiProviderQuery* query = [[GLBApiProviderQuery alloc] initWithProvider:self
                                                                       request:request
                                                                        target:target
                                                                 downloadBlock:downloadBlock
                                                                 completeBlock:completeBlock];
    if(query != nil) {
        [self _sendQuery:query];
    }
}

- (void)sendRequest:(GLBApiRequest*)request
           byTarget:(id)target
        uploadBlock:(GLBApiProviderProgressBlock)uploadBlock
      completeBlock:(GLBApiProviderCompleteBlock)completeBlock {
    if(request.provider != nil) {
        @throw [NSException exceptionWithName:@"GLBApiProvider" reason:@"This request is already sent" userInfo:nil];
    }
    GLBApiProviderQuery* query = [[GLBApiProviderQuery alloc] initWithProvider:self
                                                                       request:request
                                                                        target:target
                                                                   uploadBlock:uploadBlock
                                                                 completeBlock:completeBlock];
    if(query != nil) {
        [self _sendQuery:query];
    }
}

- (void)cancelRequest:(GLBApiRequest*)request {
    [_tasks glb_each:^(NSNumber* taskIdentifier, GLBApiProviderQuery* query) {
        if(query.request == request) {
            [query.request cancel];
        }
    }];
}

- (void)cancelAllRequestsByTarget:(id)target {
    [_tasks glb_each:^(NSNumber* taskIdentifier, GLBApiProviderQuery* query) {
        if(query.target == target) {
            [query.request cancel];
        }
    }];
}

#pragma mark - NSURLSessionDelegate

- (void)URLSession:(NSURLSession*)session didBecomeInvalidWithError:(NSError*)error {
    if(_tasks != nil) {
        [self.lock lock];
        [_tasks removeAllObjects];
        [self.lock unlock];
    }
}

- (void)URLSession:(NSURLSession*)session didReceiveChallenge:(NSURLAuthenticationChallenge*)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential* __credential))completionHandler {
    [self _receiveChallenge:challenge completionHandler:completionHandler];
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession*)session {
}

#pragma mark - NSURLSessionTaskDelegate

- (void)URLSession:(NSURLSession*)session task:(NSURLSessionTask*)task willPerformHTTPRedirection:(NSHTTPURLResponse*)response newRequest:(NSURLRequest*)request completionHandler:(void (^)(NSURLRequest* __nullable))completionHandler {
    if(completionHandler != nil) {
        completionHandler(request);
    }
}

- (void)URLSession:(NSURLSession*)session task:(NSURLSessionTask*)task didReceiveChallenge:(NSURLAuthenticationChallenge*)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential* __credential))completionHandler {
    [self _receiveChallenge:challenge completionHandler:completionHandler];
}

- (void)URLSession:(NSURLSession*)session task:(NSURLSessionTask*)task needNewBodyStream:(void (^)(NSInputStream* __bodyStream))completionHandler {
    NSInputStream* inputStream = nil;
    NSInputStream* originalInputStream = task.originalRequest.HTTPBodyStream;
    if([originalInputStream conformsToProtocol:@protocol(NSCopying)] == YES) {
        inputStream = originalInputStream.copy;
    }
    if(completionHandler != nil) {
        completionHandler(inputStream);
    }
}

- (void)URLSession:(NSURLSession*)session task:(NSURLSessionTask*)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {
    GLBApiProviderQuery* query = self.tasks[@(task.taskIdentifier)];
    if(query != nil) {
        if(totalBytesExpectedToSend == NSURLSessionTransferSizeUnknown) {
            NSString* contentLength = [task.originalRequest valueForHTTPHeaderField:@"Content-Length"];
            if(contentLength != nil) {
                totalBytesExpectedToSend = (int64_t)contentLength.longLongValue;
            }
        }
        [query _didUploadBytes:totalBytesSent totalBytes:totalBytesExpectedToSend];
    }
}

- (void)URLSession:(NSURLSession*)session task:(NSURLSessionTask*)task didCompleteWithError:(NSError*)error {
    GLBApiProviderQuery* query = self.tasks[@(task.taskIdentifier)];
    [self.lock lock];
    [self.tasks removeObjectForKey:@(task.taskIdentifier)];
    [self.lock unlock];
    if(query != nil) {
        [query _didCompleteWithError:error];
    }
}

#pragma mark - NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession*)session dataTask:(NSURLSessionDataTask*)dataTask didReceiveResponse:(NSURLResponse*)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    NSURLSessionResponseDisposition disposition = NSURLSessionResponseAllow;
    GLBApiProviderQuery* query = self.tasks[@(dataTask.taskIdentifier)];
    if(query != nil) {
        [query _didReceiveResponse:response];
    }
    if(completionHandler != nil) {
        completionHandler(disposition);
    }
}

- (void)URLSession:(NSURLSession*)session dataTask:(NSURLSessionDataTask*)dataTask didBecomeDownloadTask:(NSURLSessionDownloadTask*)downloadTask {
    GLBApiProviderQuery* query = self.tasks[@(dataTask.taskIdentifier)];
    [self.lock lock];
    [self.tasks removeObjectForKey:@(dataTask.taskIdentifier)];
    if(query != nil) {
        self.tasks[@(downloadTask.taskIdentifier)] = query;
        [query _didBecomeDownloadTask:downloadTask];
    }
    [self.lock unlock];
}

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_9_0
- (void)URLSession:(NSURLSession*)session dataTask:(NSURLSessionDataTask*)dataTask didBecomeStreamTask:(NSURLSessionStreamTask*)streamTask {
    GLBApiProviderQuery* query = self.tasks[@(dataTask.taskIdentifier)];
    [self.lock lock];
    [self.tasks removeObjectForKey:@(dataTask.taskIdentifier)];
    if(query != nil) {
        self.tasks[@(streamTask.taskIdentifier)] = query;
        [query _didBecomeStreamTask:streamTask];
    }
    [self.lock unlock];
}
#endif

- (void)URLSession:(NSURLSession*)session dataTask:(NSURLSessionDataTask*)dataTask didReceiveData:(NSData*)data {
    GLBApiProviderQuery* query = self.tasks[@(dataTask.taskIdentifier)];
    if(query != nil) {
        [query _didReceiveData:data];
    }
}

- (void)URLSession:(NSURLSession*)session dataTask:(NSURLSessionDataTask*)dataTask willCacheResponse:(NSCachedURLResponse*)proposedResponse completionHandler:(void (^)(NSCachedURLResponse* cachedResponse))completionHandler {
    if(completionHandler != nil) {
        completionHandler(nil);
    }
}

#pragma mark - NSURLSessionDownloadDelegate

- (void)URLSession:(NSURLSession*)session downloadTask:(NSURLSessionDownloadTask*)downloadTask didFinishDownloadingToURL:(NSURL*)location {
    GLBApiProviderQuery* query = self.tasks[@(downloadTask.taskIdentifier)];
    if(query != nil) {
        [query _didDownloadToURL:location];
    }
}

- (void)URLSession:(NSURLSession*)session downloadTask:(NSURLSessionDownloadTask*)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    GLBApiProviderQuery* query = self.tasks[@(downloadTask.taskIdentifier)];
    if(query != nil) {
        [query _didDownloadBytes:totalBytesWritten totalBytes:totalBytesExpectedToWrite];
    }
}

- (void)URLSession:(NSURLSession*)session downloadTask:(NSURLSessionDownloadTask*)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    GLBApiProviderQuery* query = self.tasks[@(downloadTask.taskIdentifier)];
    if(query != nil) {
        [query _didResumeDownloadAtOffset:fileOffset totalBytes:expectedTotalBytes];
    }
}

#pragma mark - Private

- (void)_sendQuery:(GLBApiProviderQuery*)query {
    NSURLSessionTask* task = nil;
    query.request.provider = self;
    if(query.downloadBlock != nil) {
        task = [self.session downloadTaskWithRequest:query.request.urlRequest];
    } else if(query.uploadBlock != nil) {
        task = [self.session uploadTaskWithStreamedRequest:query.request.urlRequest];
    } else {
        task = [self.session dataTaskWithRequest:query.request.urlRequest];
    }
    if(task != nil) {
        query.request.task = task;
        
        [self.lock lock];
        self.tasks[@(task.taskIdentifier)] = query;
        [self.lock unlock];
        
        if(_logging == YES) {
            NSLog(@"\n%@\n", query.request.glb_debug);
        }
        
        [task resume];
    } else {
        query.request.provider = nil;
    }
}

- (void)_receiveChallenge:(NSURLAuthenticationChallenge*)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential* __credential))completionHandler {
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    NSURLCredential* credential = nil;
    
    SecTrustRef serverTrust = challenge.protectionSpace.serverTrust;
    
    if(_certificateFilename != nil) {
        SecCertificateRef localCertificate = NULL;
        SecTrustResultType serverTrustResult = kSecTrustResultOtherError;
        NSString* path = [NSBundle.mainBundle pathForResource:_certificateFilename ofType:@"der"];
        if(path != nil) {
            NSData* data = [NSData dataWithContentsOfFile:path];
            if(data != nil) {
                CFDataRef cfData = (__bridge_retained CFDataRef)data;
                localCertificate = SecCertificateCreateWithData(NULL, cfData);
                if(localCertificate != NULL) {
                    CFArrayRef cfCertArray = CFArrayCreate(NULL, (void*)&localCertificate, 1, NULL);
                    if(cfCertArray != NULL) {
                        SecTrustSetAnchorCertificates(serverTrust, cfCertArray);
                        SecTrustEvaluate(serverTrust, &serverTrustResult);
                        if(serverTrustResult == kSecTrustResultRecoverableTrustFailure) {
                            CFDataRef cfErrorData = SecTrustCopyExceptions(serverTrust);
                            SecTrustSetExceptions(serverTrust, cfErrorData);
                            SecTrustEvaluate(serverTrust, &serverTrustResult);
                            CFRelease(cfErrorData);
                        }
                        CFRelease(cfCertArray);
                    }
                }
                CFRelease(cfData);
            }
        }
        if((serverTrustResult == kSecTrustResultUnspecified) || (serverTrustResult == kSecTrustResultProceed)) {
            SecCertificateRef serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0);
            if(serverCertificate != NULL) {
                NSString* serverHash = nil;
                NSData* serverCertificateData = (__bridge_transfer NSData*)SecCertificateCopyData(serverCertificate);
                if(serverCertificateData != nil) {
                    serverHash = serverCertificateData.glb_base64String.glb_stringBySHA256;
                }
                NSString* localHash = nil;
                NSData* localCertificateData = (__bridge_transfer NSData*)SecCertificateCopyData(localCertificate);
                if(localCertificateData != nil) {
                    localHash = localCertificateData.glb_base64String.glb_stringBySHA256;
                }
                if([serverHash isEqualToString:localHash] == YES) {
                    credential = [NSURLCredential credentialForTrust:serverTrust];
                } else {
                    disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
                }
            } else {
                disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
            }
        } else {
            disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
        }
        if(localCertificate != NULL) {
            CFRelease(localCertificate);
        }
    } else if(_allowInvalidCertificates == NO) {
        credential = [NSURLCredential credentialForTrust:serverTrust];
    } else {
        disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    }
    if(credential != nil) {
        disposition = NSURLSessionAuthChallengeUseCredential;
    }
    if(completionHandler != nil) {
        completionHandler(disposition, credential);
    }
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBApiProviderQuery

#pragma mark - Init / Free

- (instancetype)initWithProvider:(GLBApiProvider*)provider
                         request:(GLBApiRequest*)request
                          target:(id)target
                   completeBlock:(GLBApiProviderCompleteBlock)completeBlock {
    self = [super init];
    if(self != nil) {
        _provider = provider;
        _createTime = NSDate.date.timeIntervalSince1970;
        _request = request;
        _target = target;
        _completeBlock = completeBlock;
    }
    return self;
}

- (instancetype)initWithProvider:(GLBApiProvider*)provider
                         request:(GLBApiRequest*)request
                          target:(id)target
                   downloadBlock:(GLBApiProviderProgressBlock)downloadBlock
                   completeBlock:(GLBApiProviderCompleteBlock)completeBlock {
    self = [super init];
    if(self != nil) {
        _provider = provider;
        _createTime = NSDate.date.timeIntervalSince1970;
        _request = request;
        _target = target;
        _downloadBlock = downloadBlock;
        _completeBlock = completeBlock;
    }
    return self;
}

- (instancetype)initWithProvider:(GLBApiProvider*)provider
                         request:(GLBApiRequest*)request
                          target:(id)target
                     uploadBlock:(GLBApiProviderProgressBlock)uploadBlock
                   completeBlock:(GLBApiProviderCompleteBlock)completeBlock {
    self = [super init];
    if(self != nil) {
        _provider = provider;
        _createTime = NSDate.date.timeIntervalSince1970;
        _request = request;
        _target = target;
        _uploadBlock = uploadBlock;
        _completeBlock = completeBlock;
    }
    return self;
}

#pragma mark - Private

- (void)_didUploadBytes:(int64_t)uploadBytes totalBytes:(int64_t)totalBytes {
    _request.uploadProgress.totalUnitCount = totalBytes;
    _request.uploadProgress.completedUnitCount = uploadBytes;
    if(_uploadBlock != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _uploadBlock(_request.uploadProgress);
        });
    }
}

- (void)_didDownloadBytes:(int64_t)downloadBytes totalBytes:(int64_t)totalBytes {
    _request.downloadProgress.totalUnitCount = totalBytes;
    _request.downloadProgress.completedUnitCount = downloadBytes;
    if(_downloadBlock != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _downloadBlock(_request.downloadProgress);
        });
    }
}

- (void)_didResumeDownloadAtOffset:(int64_t)offset totalBytes:(int64_t)totalBytes {
    _request.downloadProgress.totalUnitCount = totalBytes;
    _request.downloadProgress.completedUnitCount = offset;
    if(_downloadBlock != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _downloadBlock(_request.downloadProgress);
        });
    }
}

- (void)_didReceiveResponse:(NSURLResponse*)response {
    _request.response.urlResponse = response;
}

- (void)_didBecomeDownloadTask:(NSURLSessionDownloadTask*)downloadTask {
    _request.task = downloadTask;
}

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_9_0

- (void)_didBecomeStreamTask:(NSURLSessionStreamTask*)streamTask {
    _request.task = streamTask;
}

#endif

- (void)_didReceiveData:(NSData*)data {
    [_request.response.mutableData appendData:data];
}

- (void)_didDownloadToURL:(NSURL*)location {
    [_request.response.mutableData setData:[NSData dataWithContentsOfURL:location]];
}

- (void)_didCompleteWithError:(NSError*)error {
    _request.provider = nil;
    _request.task = nil;
    if(error.glb_URLErrorCancelled == NO) {
        _request.response.error = error;
        if([_request.response.class allowsBackgroundThread] == YES) {
            [_request.response parse];
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [_request.response parse];
            });
        }
        if(_request.response.isValid == NO) {
            NSTimeInterval now = NSDate.date.timeIntervalSince1970;
            if((now - _createTime) <= _request.retries) {
                [_request reset];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, _request.delay * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [_provider _sendQuery:self];
                });
            } else {
                [self _didComplete];
            }
        } else {
            [self _didComplete];
        }
    }
}

- (void)_didComplete {
    if(_provider.logging == YES) {
        NSLog(@"\n%@\n", _request.response.glb_debug);
    }
    if(_completeBlock != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _completeBlock(_request, _request.response);
        });
    }
}

@end

/*--------------------------------------------------*/
