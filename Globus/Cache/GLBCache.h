/*--------------------------------------------------*/

#import "NSString+GLBNS.h"
#import "NSDate+GLBNS.h"
#import "NSFileManager+GLBNS.h"

/*--------------------------------------------------*/

typedef void (^GLBCacheDataForKey)(NSData* data);
typedef void (^GLBCacheComplete)();

/*--------------------------------------------------*/

@interface GLBCache : NSObject

@property(nonatomic, readonly, copy) NSString* name;
@property(nonatomic) NSUInteger capacity;
@property(nonatomic, readonly, assign) NSTimeInterval storageInterval;
@property(nonatomic, readonly, assign) NSUInteger currentUsage;

+ (instancetype)shared;

- (instancetype)initWithName:(NSString*)name;
- (instancetype)initWithName:(NSString*)name capacity:(NSUInteger)capacity;
- (instancetype)initWithName:(NSString*)name capacity:(NSUInteger)capacity storageInterval:(NSTimeInterval)storageInterval;

- (void)setup NS_REQUIRES_SUPER;

- (BOOL)existDataForKey:(NSString*)key;

- (void)setData:(NSData*)data forKey:(NSString*)key;
- (void)setData:(NSData*)data forKey:(NSString*)key complete:(GLBCacheComplete)complete;
- (NSData*)dataForKey:(NSString*)key;
- (void)dataForKey:(NSString*)key complete:(GLBCacheDataForKey)complete;

- (void)removeDataForKey:(NSString*)key;
- (void)removeDataForKey:(NSString*)key complete:(GLBCacheComplete)complete;
- (void)removeAllData;
- (void)removeAllDataComplete:(GLBCacheComplete)complete;

@end

/*--------------------------------------------------*/
