/*--------------------------------------------------*/

#import "PersonModel+Private.h"

/*--------------------------------------------------*/

@implementation PersonModel

#pragma mark GLBModel

+ (NSDictionary< NSString*, GLBModelJson* >*)jsonMap {
    return @{
        @"firstName" : [[GLBModelJsonString alloc] initWithPath:@"first_name"],
        @"lastName" : [[GLBModelJsonString alloc] initWithPath:@"last_name"],
    };
}

+ (NSDictionary< NSString*, NSDictionary< NSString*, GLBModelJson* >* >*)jsonShemeMap {
    return @{
        ModelCustomSheme : @{
            @"firstName" : [[GLBModelJsonString alloc] initWithPath:@"INFO.FIRST_NAME"],
            @"lastName" : [[GLBModelJsonString alloc] initWithPath:@"INFO.LAST_NAME"],
        }
    };
}

+ (NSDictionary< NSString*, GLBModelPack* >*)packMap {
    return @{
        @"firstName" : [GLBModelPackString new],
        @"lastName" : [GLBModelPackString new]
    };
}

+ (NSDictionary< NSString*, id >*)serializeMap {
    return @{
        @"firstName" : @"firstName",
        @"lastName" : @"lastName"
    };
}

+ (NSDictionary< NSString*, id >*)defaultsMap {
    return @{
        @"firstName" : @"Alex"
    };
}

#pragma mark - Init / Free

- (void)setup {
    [super setup];
    
    // Custom setup code
}

#pragma mark - Public
#pragma mark - Private

@end

/*--------------------------------------------------*/
