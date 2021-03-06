/*--------------------------------------------------*/

#import "GLBApiRequest+Private.h"
#import "GLBApiResponse+Private.h"
#import "GLBApiProvider.h"

/*--------------------------------------------------*/

#import "NSDictionary+GLBNS.h"
#import "NSArray+GLBNS.h"
#import "NSOrderedSet+GLBNS.h"
#import "NSSet+GLBNS.h"
#import "NSString+GLBNS.h"
#import "NSData+GLBNS.h"
#import "NSURL+GLBNS.h"

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBApiRequest

#pragma mark - Init

@synthesize provider = _provider;
@synthesize uploadProgress = _uploadProgress;
@synthesize downloadProgress = _downloadProgress;
@synthesize urlRequest = _urlRequest;
@synthesize response = _response;

#pragma mark - Init / Free

- (instancetype)init {
    self = [super init];
    if(self != nil) {
        _urlParams = [NSMutableDictionary dictionary];
        _headers = [NSMutableDictionary dictionary];
        _bodyParams = [NSMutableDictionary dictionary];
        _includeArraySymbolsUrlParams = YES;
        _encodeUrlParams = YES;
        _encodeBodyParams = YES;
        _timeout = 30.0;
        _retries = 3.0;
        _delay = 0.5f;
        _cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return self;
}

#pragma mark - Property

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

- (NSProgress*)uploadProgress {
    if(_uploadProgress == nil) {
        _uploadProgress = [NSProgress new];
    }
    return _uploadProgress;
}

- (NSProgress*)downloadProgress {
    if(_downloadProgress == nil) {
        _downloadProgress = [NSProgress new];
    }
    return _downloadProgress;
}

- (NSURLRequest*)urlRequest {
    if(_urlRequest == nil) {
        NSURL* url = nil;
        NSMutableDictionary* urlParams = [NSMutableDictionary dictionary];
        NSMutableDictionary* headers = [NSMutableDictionary dictionary];
        NSMutableDictionary* bodyParams = [NSMutableDictionary dictionary];
        NSMutableData* bodyData = nil;
        
        if(_provider.url != nil) {
            if(_url.length > 0) {
                NSMutableString* mutableUrl = [NSMutableString stringWithString:_provider.url.absoluteString];
                if([mutableUrl characterAtIndex:mutableUrl.length - 1] != '/') {
                    [mutableUrl appendFormat:@"/%@", _url];
                } else {
                    [mutableUrl appendString:_url];
                }
                url = [NSURL URLWithString:mutableUrl];
            } else {
                url = _provider.url;
            }
        } else if(_url.length > 0) {
            url = [NSURL URLWithString:_url];
        }
        if(_provider.urlParams.count > 0) {
            [urlParams addEntriesFromDictionary:_provider.urlParams];
        }
        if(_urlParams.count > 0) {
            [urlParams addEntriesFromDictionary:_urlParams];
        }
        if((url != nil) && (urlParams.count > 0)) {
            NSURLComponents* urlComponents = [NSURLComponents componentsWithString:url.absoluteString];
            NSMutableDictionary* queryParams = NSMutableDictionary.dictionary;
            if(urlComponents.query.length > 0) {
                [queryParams addEntriesFromDictionary:urlComponents.query.glb_dictionaryFromQueryComponents];
            }
            [queryParams addEntriesFromDictionary:[self _formDataFromDictionary:urlParams]];
            NSMutableString* queryString = NSMutableString.string;
            NSRegularExpression* trimArraySymbolsRegexp = nil;
            if(_includeArraySymbolsUrlParams == NO) {
                trimArraySymbolsRegexp = [NSRegularExpression regularExpressionWithPattern:@"\\[[0-9]+\\]" options:(NSRegularExpressionOptions)0 error:nil];
            }
            [queryParams enumerateKeysAndObjectsUsingBlock:^(NSString* key, id< NSObject > value, BOOL* stop __unused) {
                if(queryString.length > 0) {
                    [queryString appendString:@"&"];
                }
                if(_includeArraySymbolsUrlParams == NO) {
                    key = [trimArraySymbolsRegexp stringByReplacingMatchesInString:key options:(NSMatchingOptions)0 range:NSMakeRange(0, key.length) withTemplate:@""];
                }
                NSString* tempKey = (_encodeBodyParams == YES) ? [key.description stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet] : key.description;
                NSString* tempValue = (_encodeUrlParams == YES) ? [value.description stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet] : value.description;
                if(key != nil) {
                    [queryString appendFormat:@"%@=%@", tempKey, tempValue];
                }
            }];
            urlComponents.percentEncodedQuery = queryString;
            url = urlComponents.URL;
        }
        if(_provider.headers.count > 0) {
            [headers addEntriesFromDictionary:_provider.headers];
        }
        if(_headers.count > 0) {
            [headers addEntriesFromDictionary:_headers];
        }
        if(_provider.bodyParams.count > 0) {
            [bodyParams addEntriesFromDictionary:_provider.bodyParams];
        }
        if(_bodyParams.count > 0) {
            [bodyParams addEntriesFromDictionary:_bodyParams];
        }
        if((bodyParams.count > 0) || (_uploadItems.count > 0)) {
            bodyData = [NSMutableData data];
            NSMutableString* bodyString = NSMutableString.string;
            NSDictionary* formData = [self _formDataFromDictionary:bodyParams];
            if(_uploadItems.count > 0) {
                NSString* bodyBoundary = nil;
                if(_bodyBoundary != nil) {
                    bodyBoundary = _bodyBoundary.glb_stringByEncodingURLFormat;
                } else {
                    bodyBoundary = NSUUID.UUID.UUIDString;
                }
                [formData glb_each:^(NSString* key, id< NSObject > value) {
                    NSString* tempKey = (_encodeBodyParams == YES) ? [key.description stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet] : key.description;
                    NSString* tempValue = (_encodeBodyParams == YES) ? [value.description stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet] : value.description;
                    [bodyData appendData:[[NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n", bodyBoundary, tempKey, tempValue] dataUsingEncoding:NSUTF8StringEncoding]];
                }];
                for(GLBApiRequestUploadItem* uploadItem in _uploadItems) {
                    NSData* uploadData = nil;
                    if(uploadItem.data.length > 0) {
                        uploadData = uploadItem.data;
                    } else if(uploadItem.localFilePath.length > 0) {
                        uploadData = [NSData dataWithContentsOfFile:uploadItem.localFilePath];
                    }
                    if(uploadData != nil) {
                        NSString* tempName = (_encodeBodyParams == YES) ? [uploadItem.name stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet] : uploadItem.name;
                        NSString* tempFilename = (_encodeBodyParams == YES) ? [uploadItem.filename stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet] : uploadItem.filename;
                        NSString* tempMimetype = uploadItem.mimetype;
                        [bodyData appendData:[[NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\nContent-Type: %@\r\n\r\n", bodyBoundary, tempName, tempFilename, tempMimetype] dataUsingEncoding:NSUTF8StringEncoding]];
                        [bodyData appendData:uploadData];
                        [bodyData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    }
                }
                [bodyData appendData:[[NSString stringWithFormat:@"--%@--\r\n", bodyBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
                headers[@"Content-Type"] = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", bodyBoundary];
            } else {
                [formData glb_each:^(NSString* key, id< NSObject > value) {
                    if(bodyString.length > 0) {
                        [bodyString appendString:@"&"];
                    }
                    NSString* tempKey = (_encodeBodyParams == YES) ? [key.description stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet] : key.description;
                    NSString* tempValue = (_encodeBodyParams == YES) ? [value.description stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet] : value.description;
                    [bodyString appendFormat:@"%@=%@", tempKey, tempValue];
                }];
                [bodyData appendData:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
                headers[@"Content-Type"] = @"application/x-www-form-urlencoded";
            }
            headers[@"Content-Length"] = [NSString stringWithFormat:@"%lu", (unsigned long)bodyData.length];
        } else if(_bodyData.length > 0) {
            bodyData = [NSMutableData dataWithData:_bodyData];
        }
        if(url != nil) {
            NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
            request.HTTPMethod = _method;
            request.allHTTPHeaderFields = headers;
            request.HTTPBody = bodyData;
            request.timeoutInterval = _timeout;
            request.cachePolicy = _cachePolicy;
            _urlRequest = request;
        }
    }
    return _urlRequest;
}

- (GLBApiResponse*)response {
    if(_response == nil) {
        _response = [[self.class responseClass] responseWithRequest:self];
    }
    return _response;
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

- (void)resume {
    if(_task != nil) {
        [_task resume];
    }
}

- (void)suspend {
    if(_task != nil) {
        [_task suspend];
    }
}

- (void)cancel {
    if(_task != nil) {
        [_task cancel];
    }
}

+ (Class)responseClass {
    return GLBApiResponse.class;
}

#pragma mark - Private

- (void)reset {
    _response = nil;
}

#pragma mark - Debug

- (NSString*)debugDescription {
    return [self glb_debug];
}

#pragma mark - GLBObjectDebugProtocol

- (void)glb_debugString:(NSMutableString*)string context:(NSPointerArray*)context indent:(NSUInteger)indent root:(BOOL)root {
    if(root == YES) {
        [string glb_appendString:@"\t" repeat:indent];
    }
    NSUInteger baseIndent = indent + 1;
    [string appendFormat:@"<%@\n", self.glb_className];
    NSURLRequest* urlRequest = self.urlRequest;
    if(urlRequest != nil) {
        NSURL* url = urlRequest.URL;
        if(url != nil) {
            [string glb_appendString:@"\t" repeat:baseIndent];
            [string appendString:@"URL : "];
            [url glb_debugString:string context:context indent:baseIndent root:NO];
            [string appendString:@"\n"];
        }
        NSString* method = urlRequest.HTTPMethod;
        if(method != nil) {
            [string glb_appendString:@"\t" repeat:baseIndent];
            [string appendString:@"Method : "];
            [method glb_debugString:string context:context indent:baseIndent root:NO];
            [string appendString:@"\n"];
        }
        NSDictionary* headers = urlRequest.allHTTPHeaderFields;
        if(headers != nil) {
            [string glb_appendString:@"\t" repeat:baseIndent];
            [string appendString:@"Headers : "];
            [headers glb_debugString:string context:context indent:baseIndent root:NO];
            [string appendString:@"\n"];
        }
        NSData* body = urlRequest.HTTPBody;
        if(body != nil) {
            id json = [NSJSONSerialization JSONObjectWithData:body options:(NSJSONReadingOptions)0 error:nil];
            if(json != nil) {
                [string glb_appendString:@"\t" repeat:baseIndent];
                [string appendString:@"Body : "];
                [json glb_debugString:string context:context indent:baseIndent root:NO];
                [string appendString:@"\n"];
            } else {
                NSString* bodyString = [NSString glb_stringWithData:body encoding:NSUTF8StringEncoding];
                if(bodyString != nil) {
                    [string glb_appendString:@"\t" repeat:baseIndent];
                    [string appendString:@"Body : "];
                    [bodyString glb_debugString:string context:context indent:baseIndent root:NO];
                    [string appendString:@"\n"];
                } else {
                    [string glb_appendString:@"\t" repeat:baseIndent];
                    [string appendFormat:@"Body : %d bytes\n", (int)body.length];
                }
            }
        }
    }
    [string glb_appendString:@"\t" repeat:indent];
    [string appendString:@">"];
}

#pragma mark - Private

- (NSDictionary*)_formDataFromDictionary:(NSDictionary*)dictionary {
    NSMutableDictionary* result = NSMutableDictionary.dictionary;
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id keyPath, id value, BOOL* stop __unused) {
        [self _formDataFromDictionary:result value:value keyPath:keyPath];
    }];
    return result;
}

- (void)_formDataFromDictionary:(NSMutableDictionary*)dictionary value:(id)value keyPath:(NSString*)keyPath {
    if([value isKindOfClass:NSDictionary.class] == YES) {
        NSDictionary* dict = value;
        [dict glb_each:^(id itemKey, id itemValue) {
            [self _formDataFromDictionary:dictionary value:itemValue keyPath:[NSString stringWithFormat:@"%@[%@]", keyPath, itemKey]];
        }];
    } else if([value isKindOfClass:NSArray.class] == YES) {
        NSArray* array = value;
        [array glb_eachWithIndex:^(id itemValue, NSUInteger index) {
            [self _formDataFromDictionary:dictionary value:itemValue keyPath:[NSString stringWithFormat:@"%@[%lu]", keyPath, (unsigned long)index]];
        }];
    } else if([value isKindOfClass:NSOrderedSet.class] == YES) {
        NSOrderedSet* orderedSet = value;
        [orderedSet glb_eachWithIndex:^(id itemValue, NSUInteger index) {
            [self _formDataFromDictionary:dictionary value:itemValue keyPath:[NSString stringWithFormat:@"%@[%lu]", keyPath, (unsigned long)index]];
        }];
    } else if([value isKindOfClass:NSSet.class] == YES) {
        NSSet* set = value;
        __block NSUInteger index = 0;
        [set glb_each:^(id itemValue) {
            [self _formDataFromDictionary:dictionary value:itemValue keyPath:[NSString stringWithFormat:@"%@[%lu]", keyPath, (unsigned long)index]];
            index++;
        }];
    } else {
        dictionary[keyPath] = value;
    }
}

@end

/*--------------------------------------------------*/

@implementation GLBApiRequestUploadItem

- (instancetype)initWithName:(NSString*)name
                    filename:(NSString*)filename
                    mimetype:(NSString*)mimetype
                        data:(NSData*)data {
    self = [super init];
    if(self != nil) {
        _name = name.copy;
        _filename = filename.copy;
        _mimetype = mimetype.copy;
        _data = data;
    }
    return self;
}

- (instancetype)initWithName:(NSString*)name
                    filename:(NSString*)filename
                    mimetype:(NSString*)mimetype
               localFilePath:(NSString*)localFilePath {
    self = [super init];
    if(self != nil) {
        _name = name.copy;
        _filename = filename.copy;
        _mimetype = mimetype.copy;
        _localFilePath = localFilePath.copy;
    }
    return self;
}

@end

/*--------------------------------------------------*/
