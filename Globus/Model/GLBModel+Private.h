/*--------------------------------------------------*/

#import "GLBModel.h"
#import "GLBModelJson.h"
#import "GLBModelPack.h"

/*--------------------------------------------------*/

@interface GLBModel ()

@property(nonatomic, readonly, nonnull, strong) NSDictionary* jsonMap;
@property(nonatomic, readonly, nonnull, strong) NSDictionary* packMap;
@property(nonatomic, readonly, nonnull, strong) NSArray* compareMap;
@property(nonatomic, readonly, nonnull, strong) NSArray* serializeMap;
@property(nonatomic, readonly, nonnull, strong) NSArray* copyMap;

+ (NSDictionary* _Nonnull)_buildJsonMap;
+ (NSDictionary* _Nonnull)_buildPackMap;
+ (NSArray* _Nonnull)_buildCompareMap;
+ (NSArray* _Nonnull)_buildSerializeMap;
+ (NSArray* _Nonnull)_buildCopyMap;

@end

/*--------------------------------------------------*/

@interface GLBManagedModel ()

@property(nonatomic, readonly, nonnull, strong) NSDictionary* jsonMap;
@property(nonatomic, readonly, nonnull, strong) NSDictionary* packMap;

+ (NSDictionary* _Nonnull)_buildJsonMap;
+ (NSDictionary* _Nonnull)_buildPackMap;

@end

/*--------------------------------------------------*/

@interface GLBManagedManager ()

@property(nonatomic, readonly, strong, nullable) NSURL* containerUrl;
@property(nonatomic, strong, nullable) NSURL* existStoreUrl;
@property(nonatomic, readonly, strong, nullable) NSURL* storeUrl;

@end

/*--------------------------------------------------*/

@interface GLBManagedMap : NSObject

+ (NSArray* _Nonnull)arrayMap:(NSMutableDictionary* _Nonnull)cache class:(_Nonnull Class)class selector:(_Nonnull SEL)selector;
+ (NSDictionary* _Nonnull)dictionaryMap:(NSMutableDictionary* _Nonnull)cache class:(_Nonnull Class)class selector:(_Nonnull SEL)selector;

@end

/*--------------------------------------------------*/
