//
//  Globus
//

#import "GLBCocoaPods.h"

@interface SimpleDataProvider : GLBLocalSimpleDataProvider

+ (nonnull instancetype)dataProvider;

@end

@class SimpleDataProviderModel;

@interface SimpleDataProviderModel : GLBModel

@property(nonatomic, nullable, strong) NSString* uid;
@property(nonatomic, nullable, strong) NSURL* url;
@property(nonatomic, nullable, strong) NSString* firstName;
@property(nonatomic, nullable, strong) NSString* lastName;

@end
