/*--------------------------------------------------*/

#import "GLBApiResponse+Private.h"
#import "GLBApiRequest.h"

/*--------------------------------------------------*/

#import "NSString+GLBNS.h"

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
    return [self glb_debug];
}

#pragma mark - GLBObjectDebugProtocol

- (void)glb_debugString:(NSMutableString*)string indent:(NSUInteger)indent root:(BOOL)root {
    if(root == YES) {
        [string glb_appendString:@"\t" repeat:indent];
    }
    NSUInteger baseIndent = indent + 1;
    [string appendFormat:@"%@\n", self.glb_className];
    NSURLResponse* urlResponse = self.urlResponse;
    if(urlResponse != nil) {
        NSURL* url = urlResponse.URL;
        if(url != nil) {
            [string glb_appendString:@"\t" repeat:baseIndent];
            [string appendString:@"URL : "];
            [url glb_debugString:string indent:baseIndent root:NO];
            [string appendString:@"\n"];
        }
        NSString* mimetype = urlResponse.MIMEType;
        if(mimetype != nil) {
            [string glb_appendString:@"\t" repeat:baseIndent];
            [string appendString:@"MIMEType : "];
            [mimetype glb_debugString:string indent:baseIndent root:NO];
            [string appendString:@"\n"];
        }
        if([urlResponse isKindOfClass:NSHTTPURLResponse.class] == YES) {
            NSHTTPURLResponse* httpUrlResponse = (NSHTTPURLResponse*)urlResponse;
            
            [string glb_appendString:@"\t" repeat:baseIndent];
            [string appendFormat:@"StatusCode : %@ (%d)\n", [NSHTTPURLResponse localizedStringForStatusCode:httpUrlResponse.statusCode], (int)httpUrlResponse.statusCode];
            
            NSDictionary* headers = httpUrlResponse.allHeaderFields;
            if(headers != nil) {
                [string glb_appendString:@"\t" repeat:baseIndent];
                [string appendString:@"Headers : "];
                [headers glb_debugString:string indent:baseIndent root:NO];
                [string appendString:@"\n"];
            }
        }
    }
    NSData* body = self.data;
    if(body != nil) {
        id json = [NSJSONSerialization JSONObjectWithData:body options:0 error:nil];
        if(json != nil) {
            [string glb_appendString:@"\t" repeat:baseIndent];
            [string appendString:@"Body : "];
            [json glb_debugString:string indent:baseIndent root:NO];
            [string appendString:@"\n"];
        } else {
            NSString* bodyString = [NSString glb_stringWithData:body encoding:NSUTF8StringEncoding];
            if(bodyString != nil) {
                [string glb_appendString:@"\t" repeat:baseIndent];
                [string appendString:@"Body : "];
                [bodyString glb_debugString:string indent:baseIndent root:NO];
                [string appendString:@"\n"];
            } else {
                [string glb_appendString:@"\t" repeat:baseIndent];
                [string appendFormat:@"Body : %d bytes\n", (int)body.length];
            }
        }
    }
    if(_error != nil) {
        [string glb_appendString:@"\t" repeat:baseIndent];
        [string appendString:@"Error : "];
        [_error glb_debugString:string indent:baseIndent root:NO];
        [string appendString:@"\n"];
    }
}

@end

/*--------------------------------------------------*/
