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

- (id< GLBListDataProviderModel >)modelWithJson:(id)json {
    return [ListDataProviderGroupModel modelWithJson:json];
}

@end

@implementation ListDataProviderGroupModel

#pragma mark - GLBModel

@synthesize header = _header;
@synthesize footer = _footer;

#pragma mark - GLBModel

+ (NSDictionary< NSString*, GLBModelJson* >*)jsonMap {
    return @{
        @"uid" : [GLBModelJsonString jsonWithPath:@"id"],
        @"childs" : [GLBModelJsonArray jsonWithPath:@"childs" model:ListDataProviderModel.class]
    };
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
