/*--------------------------------------------------*/

#import "GLBModel.h"
#import "GLBModelJson.h"
#import "GLBModelPack.h"

/*--------------------------------------------------*/

@interface GLBModel ()

@property(nonatomic, nonnull, readonly, strong) NSDictionary< NSString*, GLBModelJson* >* jsonMap;
@property(nonatomic, nonnull, readonly, strong) NSDictionary< NSString*, NSDictionary< NSString*, GLBModelJson* >* >* jsonShemeMap;
@property(nonatomic, nonnull, readonly, strong) NSDictionary< NSString*, GLBModelPack* >* packMap;
@property(nonatomic, nonnull, readonly, strong) NSDictionary< NSString*, id >* defaultsMap;
@property(nonatomic, nonnull, readonly, strong) NSDictionary< NSString*, NSString* >* serializeMap;
@property(nonatomic, nonnull, readonly, strong) NSArray< NSString* >* propertyMap;
@property(nonatomic, nonnull, readonly, strong) NSArray< NSString* >* compareMap;
@property(nonatomic, nonnull, readonly, strong) NSArray< NSString* >* copyMap;

+ (nullable NSString*)_filePathWithStoreName:(nonnull NSString*)storeName appGroupIdentifier:(nullable NSString*)appGroupIdentifier;

+ (nonnull NSDictionary< NSString*, GLBModelJson* >*)_buildJsonMap;
+ (nonnull NSDictionary< NSString*, NSDictionary< NSString*, GLBModelJson* >* >*)_buildJsonShemeMap;
+ (nonnull NSDictionary< NSString*, GLBModelPack* >*)_buildPackMap;
+ (nonnull NSDictionary< NSString*, id >*)_buildDefaultsMap;
+ (nonnull NSDictionary< NSString*, id >*)_buildSerializeMap;
+ (nonnull NSArray< NSString* >*)_buildPropertyMap;
+ (nonnull NSArray< NSString* >*)_buildCompareMap;
+ (nonnull NSArray< NSString* >*)_buildCopyMap;

- (nullable NSString*)_filePath;

@end

/*--------------------------------------------------*/

typedef id _Nullable(^GLBModelHelperConvertBlock)(id _Nullable value);

/*--------------------------------------------------*/

@interface GLBModelHelper : NSObject

+ (nonnull NSDictionary< id, NSDictionary* >*)multiDictionaryMap:(nonnull NSMutableDictionary*)cache withClass:(nonnull Class)aClass selector:(nonnull SEL)selector;
+ (nonnull NSDictionary< id, NSDictionary* >*)multiDictionaryMap:(nonnull NSMutableDictionary*)cache withClass:(nonnull Class)aClass selector:(nonnull SEL)selector convert:(nullable GLBModelHelperConvertBlock)convert;
+ (nonnull NSDictionary*)dictionaryMap:(nonnull NSMutableDictionary*)cache withClass:(nonnull Class)aClass selector:(nonnull SEL)selector;
+ (nonnull NSDictionary*)dictionaryMap:(nonnull NSMutableDictionary*)cache withClass:(nonnull Class)aClass selector:(nonnull SEL)selector convert:(nullable GLBModelHelperConvertBlock)convert;
+ (nonnull NSArray*)arrayMap:(nonnull NSMutableDictionary*)cache withClass:(nonnull Class)aClass selector:(nonnull SEL)selector;
+ (nonnull NSArray*)arrayMap:(nonnull NSMutableDictionary*)cache withClass:(nonnull Class)aClass selector:(nonnull SEL)selector convert:(nullable GLBModelHelperConvertBlock)convert;

@end

/*--------------------------------------------------*/
