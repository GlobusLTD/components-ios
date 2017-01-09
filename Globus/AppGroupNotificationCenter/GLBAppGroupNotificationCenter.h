/*--------------------------------------------------*/

#import "NSDictionary+GLBNS.h"
#import "NSArray+GLBNS.h"

/*--------------------------------------------------*/

@interface GLBAppGroupNotificationCenter : NSObject

@property(nonatomic, nonnull, readonly, copy) NSString* identifier;
@property(nonatomic, nonnull, readonly, copy) NSString* directory;

+ (BOOL)isSupported;

- (instancetype _Nonnull)init NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithIdentifier:(NSString* _Nonnull)identifier directory:(NSString* _Nonnull)directory NS_DESIGNATED_INITIALIZER;

- (void)setup NS_REQUIRES_SUPER;

- (void)postNotificationName:(NSString* _Nonnull)name object:(id< NSCoding > _Nullable)object;

- (void)addObserver:(id _Nonnull)observer selector:(SEL _Nonnull)selector name:(NSString* _Nonnull)name;
- (void)removeObserver:(id _Nonnull)observer name:(NSString* _Nonnull)name;
- (void)removeObserver:(id _Nonnull)observer;

@end

/*--------------------------------------------------*/
