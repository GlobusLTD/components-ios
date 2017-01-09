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

+ (NSString* _Nullable)_filePathWithStoreName:(NSString* _Nonnull)storeName appGroupIdentifier:(NSString* _Nullable)appGroupIdentifier;

+ (NSDictionary< NSString*, GLBModelJson* >* _Nonnull)_buildJsonMap;
+ (NSDictionary< NSString*, NSDictionary< NSString*, GLBModelJson* >* >* _Nonnull)_buildJsonShemeMap;
+ (NSDictionary< NSString*, GLBModelPack* >* _Nonnull)_buildPackMap;
+ (NSDictionary< NSString*, id >* _Nonnull)_buildDefaultsMap;
+ (NSDictionary< NSString*, id >* _Nonnull)_buildSerializeMap;
+ (NSArray< NSString* >* _Nonnull)_buildPropertyMap;
+ (NSArray< NSString* >* _Nonnull)_buildCompareMap;
+ (NSArray< NSString* >* _Nonnull)_buildCopyMap;

- (NSString* _Nullable)_filePath;

@end

/*--------------------------------------------------*/

typedef id _Nullable(^GLBModelHelperConvertBlock)(id _Nullable value);

/*--------------------------------------------------*/

@interface GLBModelHelper : NSObject

+ (NSDictionary< id, NSDictionary* >* _Nonnull)multiDictionaryMap:(NSMutableDictionary* _Nonnull)cache withClass:(Class _Nonnull)aClass selector:(SEL _Nonnull)selector;
+ (NSDictionary< id, NSDictionary* >* _Nonnull)multiDictionaryMap:(NSMutableDictionary* _Nonnull)cache withClass:(Class _Nonnull)aClass selector:(SEL _Nonnull)selector convert:(_Nullable GLBModelHelperConvertBlock)convert;
+ (NSDictionary* _Nonnull)dictionaryMap:(NSMutableDictionary* _Nonnull)cache withClass:(Class _Nonnull)aClass selector:(SEL _Nonnull)selector;
+ (NSDictionary* _Nonnull)dictionaryMap:(NSMutableDictionary* _Nonnull)cache withClass:(Class _Nonnull)aClass selector:(SEL _Nonnull)selector convert:(_Nullable GLBModelHelperConvertBlock)convert;
+ (NSArray* _Nonnull)arrayMap:(NSMutableDictionary* _Nonnull)cache withClass:(Class _Nonnull)aClass selector:(SEL _Nonnull)selector;
+ (NSArray* _Nonnull)arrayMap:(NSMutableDictionary* _Nonnull)cache withClass:(Class _Nonnull)aClass selector:(SEL _Nonnull)selector convert:(_Nullable GLBModelHelperConvertBlock)convert;

@end

/*--------------------------------------------------*/
