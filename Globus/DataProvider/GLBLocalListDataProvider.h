/*--------------------------------------------------*/

#import "GLBListDataProvider.h"

/*--------------------------------------------------*/

@interface GLBLocalListDataProvider : NSObject< GLBListDataProvider >

@property(nonatomic, nonnull, readonly, strong) NSString* baseFileName;

@property(nonatomic) BOOL canReload;
@property(nonatomic) BOOL canSearch;

- (nonnull instancetype)init NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithBaseFileName:(nonnull NSString*)baseFileName NS_DESIGNATED_INITIALIZER;

- (void)setup NS_REQUIRES_SUPER;

- (nullable id< GLBListDataProviderModel >)modelWithJson:(nonnull id)json;

@end

/*--------------------------------------------------*/
