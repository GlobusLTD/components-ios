/*--------------------------------------------------*/

#import "NSDictionary+GLBNS.h"
#import "NSArray+GLBNS.h"

/*--------------------------------------------------*/

@interface GLBAppGroupNotificationCenter : NSObject

@property(nonatomic, nonnull, readonly, copy) NSString* identifier;
@property(nonatomic, nonnull, readonly, copy) NSString* directory;

+ (BOOL)isSupported;

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithIdentifier:(nonnull NSString*)identifier directory:(nonnull NSString*)directory NS_DESIGNATED_INITIALIZER;

- (void)setup NS_REQUIRES_SUPER;

- (void)postNotificationName:(nonnull NSString*)name object:(nullable id< NSCoding >)object;

- (void)addObserver:(nonnull id)observer selector:(nonnull SEL)selector name:(nonnull NSString*)name;
- (void)removeObserver:(nonnull id)observer name:(nonnull NSString*)name;
- (void)removeObserver:(nonnull id)observer;

@end

/*--------------------------------------------------*/
