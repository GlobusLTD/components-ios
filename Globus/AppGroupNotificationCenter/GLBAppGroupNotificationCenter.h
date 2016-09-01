/*--------------------------------------------------*/

#import "NSDictionary+GLBNS.h"
#import "NSArray+GLBNS.h"

/*--------------------------------------------------*/

@interface GLBAppGroupNotificationCenter : NSObject

@property(nonatomic, readonly, copy) NSString* identifier;
@property(nonatomic, readonly, copy) NSString* directory;

+ (BOOL)isSupported;

- (instancetype)initWithIdentifier:(NSString*)identifier directory:(NSString*)directory;

- (void)setup NS_REQUIRES_SUPER;

- (void)postNotificationName:(NSString*)name object:(id< NSCoding >)object;

- (void)addObserver:(id)observer selector:(SEL)selector name:(NSString*)name;
- (void)removeObserver:(id)observer name:(NSString*)name;
- (void)removeObserver:(id)observer;

@end

/*--------------------------------------------------*/
