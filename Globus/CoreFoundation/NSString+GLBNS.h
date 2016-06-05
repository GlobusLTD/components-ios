/*--------------------------------------------------*/

#import "NSObject+GLBNS.h"

/*--------------------------------------------------*/

@interface NSString (GLB_NS) < GLBObjectDebugProtocol >

+ (instancetype _Nullable)glb_stringWithData:(NSData* _Nonnull)data encoding:(NSStringEncoding)encoding;

- (NSString* _Nullable)glb_stringByUppercaseFirstCharacterString;
- (NSString* _Nullable)glb_stringByLowercaseFirstCharacterString;

- (NSString* _Nullable)glb_stringByMD5;
- (NSString* _Nullable)glb_stringBySHA256;

- (NSString* _Nullable)glb_stringByDecodingURLFormat;
- (NSString* _Nullable)glb_stringByEncodingURLFormat;
- (NSDictionary* _Nullable)glb_dictionaryFromQueryComponents;

- (BOOL)glb_isEmail;

- (NSData* _Nullable)glb_dataHmacSha1WithKey:(NSString* _Nonnull)key;

- (BOOL)glb_bool;
- (NSNumber* _Nullable)glb_number;
- (NSDate* _Nullable)glb_dateWithFormat:(NSString* _Nonnull)format;

- (NSArray* _Nullable)glb_charactersArray;

- (UInt32)glb_crc32;

@end

/*--------------------------------------------------*/

@interface NSMutableString (GLB_NS)

+ (instancetype _Nullable)glb_stringWithString:(NSString* _Nonnull)string repeat:(NSUInteger)repeat;

- (void)glb_appendString:(NSString* _Nonnull)string repeat:(NSUInteger)repeat;

@end

/*--------------------------------------------------*/
