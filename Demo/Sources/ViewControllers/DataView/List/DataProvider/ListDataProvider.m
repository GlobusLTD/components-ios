//
//  Globus
//

#import "ListDataProvider.h"

@implementation ListDataProvider

+ (instancetype)dataProvider {
    ListDataProvider* dataProvider = [self new];
    dataProvider.canReload = YES;
    dataProvider.canSearch = YES;
    return dataProvider;
}

- (id)modelWithJsonObject:(id)jsonObject {
    return [ListDataProviderModel modelWithJson:jsonObject];
}

@end

@implementation ListDataProviderModel

#pragma mark - GLBModel

+ (NSDictionary< NSString*, GLBModelJson* >*)jsonMap {
    return @{
        @"uid" : [GLBModelJsonString jsonWithPath:@"id"],
        @"title" : [GLBModelJsonString jsonWithPath:@"title"]
    };
}

@end
