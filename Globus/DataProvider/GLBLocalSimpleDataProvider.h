/*--------------------------------------------------*/

#import "GLBSimpleDataProvider.h"

/*--------------------------------------------------*/

@interface GLBLocalSimpleDataProvider : NSObject< GLBSimpleDataProvider >

@property(nonatomic, nonnull, readonly, strong) NSString* baseFileName;

@property(nonatomic) BOOL canReload;

- (nonnull instancetype)init NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithBaseFileName:(nonnull NSString*)baseFileName NS_DESIGNATED_INITIALIZER;

- (void)setup NS_REQUIRES_SUPER;

- (nullable id)modelWithJsonObject:(nonnull id)jsonObject;

@end

/*--------------------------------------------------*/
