//
//  Globus
//

#import "GLBCocoaPods.h"

@interface ListDataProvider : GLBLocalListDataProvider

+ (nonnull instancetype)dataProvider;

@end

@class ListDataProviderModel;

@interface ListDataProviderGroupModel : GLBModel< GLBListDataProviderModel >

@property(nonatomic, nullable, strong) NSString* uid;
@property(nonatomic, nullable, strong) NSArray< ListDataProviderModel* >* childs;

@end

@interface ListDataProviderModel : GLBModel

@property(nonatomic, nullable, strong) NSString* uid;
@property(nonatomic, nullable, strong) NSString* title;

@end
