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
@property(nonatomic, readonly, assign) NSTimeInterval storageInterval;
@property(nonatomic, readonly, assign) NSUInteger currentUsage;

+ (instancetype _Nullable)shared;

- (instancetype _Nullable)initWithName:(NSString* _Nonnull)name;
- (instancetype _Nullable)initWithName:(NSString* _Nonnull)name capacity:(NSUInteger)capacity;
- (instancetype _Nullable)initWithName:(NSString* _Nonnull)name capacity:(NSUInteger)capacity storageInterval:(NSTimeInterval)storageInterval NS_DESIGNATED_INITIALIZER;

- (void)setup NS_REQUIRES_SUPER;

- (BOOL)existDataForKey:(NSString* _Nonnull)key;

- (void)setData:(NSData* _Nonnull)data forKey:(NSString* _Nonnull)key;
- (void)setData:(NSData* _Nonnull)data forKey:(NSString* _Nonnull)key complete:(GLBCacheComplete _Nullable)complete;
- (NSData* _Nullable)dataForKey:(NSString* _Nonnull)key;
- (void)dataForKey:(NSString* _Nonnull)key complete:(GLBCacheDataForKey _Nullable)complete;

- (void)removeDataForKey:(NSString* _Nonnull)key;
- (void)removeDataForKey:(NSString* _Nonnull)key complete:(GLBCacheComplete _Nullable)complete;
- (void)removeAllData;
- (void)removeAllDataComplete:(GLBCacheComplete _Nullable)complete;

@end

/*--------------------------------------------------*/
