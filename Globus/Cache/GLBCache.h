/*--------------------------------------------------*/

#import "NSString+GLBNS.h"
#import "NSDate+GLBNS.h"
#import "NSFileManager+GLBNS.h"

/*--------------------------------------------------*/

typedef void (^GLBCacheDataForKey)(NSData* _Nullable data);
typedef void (^GLBCacheComplete)();

/*--------------------------------------------------*/

@interface GLBCache : NSObject

@property(nonatomic, nonnull, readonly, copy) NSString* name;
@property(nonatomic) NSUInteger capacity;
@property(nonatomic, readonly) NSTimeInterval storageInterval;
@property(nonatomic, readonly) NSUInteger currentUsage;

+ (nullable instancetype)shared;

- (nullable instancetype)initWithName:(nonnull NSString*)name;
- (nullable instancetype)initWithName:(nonnull NSString*)name capacity:(NSUInteger)capacity;
- (nullable instancetype)initWithName:(nonnull NSString*)name capacity:(NSUInteger)capacity storageInterval:(NSTimeInterval)storageInterval NS_DESIGNATED_INITIALIZER;

- (void)setup NS_REQUIRES_SUPER;

- (BOOL)existDataForKey:(nonnull NSString*)key;

- (void)setData:(nonnull NSData*)data forKey:(nonnull NSString*)key;
- (void)setData:(nonnull NSData*)data forKey:(nonnull NSString*)key complete:(nullable GLBCacheComplete)complete;
- (nullable NSData*)dataForKey:(nonnull NSString*)key;
- (void)dataForKey:(nonnull NSString*)key complete:(nullable GLBCacheDataForKey)complete;

- (void)removeDataForKey:(nonnull NSString*)key;
- (void)removeDataForKey:(nonnull NSString*)key complete:(nullable GLBCacheComplete)complete;
- (void)removeAllData;
- (void)removeAllDataComplete:(nullable GLBCacheComplete)complete;

@end

/*--------------------------------------------------*/
