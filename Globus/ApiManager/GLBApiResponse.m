/*--------------------------------------------------*/

#import "GLBApiResponse+Private.h"
#import "GLBApiRequest.h"

/*--------------------------------------------------*/

#import "NSObject+GLBNS.h"

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBApiResponse

#pragma mark Synthesize

@synthesize mutableData = _mutableData;

#pragma mark - Init / Free

+ (instancetype)responseWithRequest:(GLBApiRequest*)request {
    return [[self alloc] initWithRequest:request];
}

- (instancetype)initWithRequest:(GLBApiRequest*)request {
    self = [super init];
    if(self != nil) {
        _request = request;
        _valid = NO;
    }
    return self;
}

- (void)dealloc {
}

#pragma mark - Property

- (NSInteger)statusCode {
    if([_urlResponse isKindOfClass:NSHTTPURLResponse.class] == YES) {
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)_urlResponse;
        return httpResponse.statusCode;
    }
    return -1;
}

- (NSString*)mimetype {
    return _urlResponse.MIMEType;
}

- (NSString*)textEncoding {
    return _urlResponse.textEncodingName;
}

- (NSDictionary*)headers {
    if([_urlResponse isKindOfClass:NSHTTPURLResponse.class] == YES) {
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)_urlResponse;
        return httpResponse.allHeaderFields;
    }
    return nil;
}

- (NSData*)data {
    return _mutableData;
}

- (NSMutableData*)mutableData {
    if(_mutableData == nil) {
        _mutableData = [NSMutableData data];
    }
    return _mutableData;
}

#pragma mark - Public

+ (BOOL)allowsBackgroundThread {
    return YES;
}

- (void)parse {
    BOOL valid = NO;
    if(_error == nil) {
        NSData* data = self.data;
        if(data != nil) {
            NSString* mimetype = self.mimetype;
            if(([mimetype isEqualToString:@"application/json"] == YES) || ([mimetype isEqualToString:@"text/json"] == YES)) {
                NSError* parseError = nil;
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
                if(json != nil) {
                    valid = [self fromJson:json];
                } else if(parseError != nil) {
                    _error = parseError;
                }
            } else {
                valid = [self fromData:data mimetype:mimetype];
            }
        } else {
            valid = [self fromEmpty];
        }
    }
    _valid = valid;
}

- (BOOL)fromData:(NSData*)data mimetype:(NSString*)mimetype {
    return NO;
}

- (BOOL)fromJson:(id)json {
    return NO;
}

- (BOOL)fromEmpty {
    return NO;
}

#pragma mark - Debug

- (NSString*)debugDescription {
    NSMutableArray* lines = [NSMutableArray array];
    [lines addObject:[NSString stringWithFormat:@"- %@", self.glb_className]];
    NSURLResponse* urlResponse = self.urlResponse;
    if(urlResponse != nil) {
        [lines addObject:[NSString stringWithFormat:@"-- URL: %@", urlResponse.URL]];
        [lines addObject:[NSString stringWithFormat:@"-- MIMEType: %@", urlResponse.MIMEType]];
        if([urlResponse isKindOfClass:NSHTTPURLResponse.class] == YES) {
            NSHTTPURLResponse* httpUrlResponse = (NSHTTPURLResponse*)urlResponse;
            [lines addObject:[NSString stringWithFormat:@"-- StatusCode: %@ (%d)", [NSHTTPURLResponse localizedStringForStatusCode:httpUrlResponse.statusCode], (int)httpUrlResponse.statusCode]];
            [lines addObject:[NSString stringWithFormat:@"-- Headers: %@", httpUrlResponse.allHeaderFields]];
        }
    }
    if(self.data.length > 0) {
        [lines addObject:[NSString stringWithFormat:@"-- Body: %d bytes", (int)self.data.length]];
    }
    if(_error != nil) {
        [lines addObject:[NSString stringWithFormat:@"-- Error: %@", _error]];
    }
    return [NSString stringWithFormat:@"\n%@", [lines componentsJoinedByString:@"\n"]];
}

@end

/*--------------------------------------------------*/
