//
//  Globus
//

#import "SimpleDataProvider.h"

@implementation SimpleDataProvider

+ (instancetype)dataProvider {
    SimpleDataProvider* dataProvider = [self new];
    dataProvider.canReload = YES;
    return dataProvider;
}

- (id)modelWithJsonObject:(id)jsonObject {
    return [SimpleDataProviderModel modelWithJson:jsonObject];
}

@end

@implementation SimpleDataProviderModel

#pragma mark - GLBModel

+ (NSDictionary< NSString*, GLBModelJson* >*)jsonMap {
    return @{
        @"uid" : [GLBModelJsonString jsonWithPath:@"id"],
        @"url" : [GLBModelJsonUrl jsonWithPath:@"avatar"],
        @"firstName" : [GLBModelJsonString jsonWithPath:@"first_name"],
        @"lastName" : [GLBModelJsonString jsonWithPath:@"last_name"]
    };
}

@end
