/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

typedef void (^GLBCacheDataForKey)(NSData* data);
typedef void (^GLBCacheComplete)();

/*--------------------------------------------------*/

@interface GLBCache : NSObject

@property(nonatomic, readonly, copy) NSString* name;
@property(nonatomic) NSUInteger memoryCapacity;
@property(nonatomic, readonly, assign) NSTimeInterval memoryStorageInterval;
@property(nonatomic) NSUInteger discCapacity;
@property(nonatomic, readonly, assign) NSTimeInterval discStorageInterval;
@property(nonatomic, readonly, assign) NSUInteger currentMemoryUsage;
@property(nonatomic, readonly, assign) NSUInteger currentDiscUsage;

+ (instancetype)shared;

- (instancetype)initWithName:(NSString*)name;
- (instancetype)initWithName:(NSString*)name memoryCapacity:(NSUInteger)memoryCapacity discCapacity:(NSUInteger)discCapacity;
- (instancetype)initWithName:(NSString*)name memoryCapacity:(NSUInteger)memoryCapacity memoryStorageInterval:(NSTimeInterval)memoryStorageInterval discCapacity:(NSUInteger)discCapacity discStorageInterval:(NSTimeInterval)discStorageInterval;

- (void)setup NS_REQUIRES_SUPER;

- (void)setData:(NSData*)data forKey:(NSString*)key;
- (void)setData:(NSData*)data forKey:(NSString*)key complete:(GLBCacheComplete)complete;
- (void)setData:(NSData*)data forKey:(NSString*)key memoryStorageInterval:(NSTimeInterval)memoryStorageInterval;
- (void)setData:(NSData*)data forKey:(NSString*)key memoryStorageInterval:(NSTimeInterval)memoryStorageInterval complete:(GLBCacheComplete)complete;
- (void)setData:(NSData*)data forKey:(NSString*)key discStorageInterval:(NSTimeInterval)discStorageInterval;
- (void)setData:(NSData*)data forKey:(NSString*)key discStorageInterval:(NSTimeInterval)discStorageInterval complete:(GLBCacheComplete)complete;
- (void)setData:(NSData*)data forKey:(NSString*)key memoryStorageInterval:(NSTimeInterval)memoryStorageInterval discStorageInterval:(NSTimeInterval)discStorageInterval;
- (void)setData:(NSData*)data forKey:(NSString*)key memoryStorageInterval:(NSTimeInterval)memoryStorageInterval discStorageInterval:(NSTimeInterval)discStorageInterval complete:(GLBCacheComplete)complete;
- (NSData*)dataForKey:(NSString*)key;
- (void)dataForKey:(NSString*)key complete:(GLBCacheDataForKey)complete;

- (void)removeDataForKey:(NSString*)key;
- (void)removeDataForKey:(NSString*)key complete:(GLBCacheComplete)complete;
- (void)removeAllData;
- (void)removeAllDataComplete:(GLBCacheComplete)complete;

@end

/*--------------------------------------------------*/
