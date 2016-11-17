/*--------------------------------------------------*/

#import "BaseModel+Private.h"

/*--------------------------------------------------*/

NSString* ModelCustomSheme = @"Custom";

/*--------------------------------------------------*/

@implementation BaseModel

#pragma mark GLBModel

+ (NSDictionary< NSString*, GLBModelJson* >*)jsonMap {
    return @{
        @"uid" : [[GLBModelJsonString alloc] initWithPath:@"id"]
    };
}

+ (NSDictionary< NSString*, NSDictionary< NSString*, GLBModelJson* >* >*)jsonShemeMap {
    return @{
        ModelCustomSheme : @{
            @"uid" : [[GLBModelJsonString alloc] initWithPath:@"ID"]
        }
    };
}

+ (NSDictionary< NSString*, GLBModelPack* >*)packMap {
    return @{
        @"uid" : [GLBModelPackString new]
    };
}

+ (NSDictionary< NSString*, id >*)serializeMap {
    return @{
        @"uid" : @"uid"
    };
}

+ (NSDictionary< NSString*, id >*)defaultsMap {
    return @{
        @"uid" : @"Unknown"
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
