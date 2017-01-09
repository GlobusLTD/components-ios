//
//  Globus
//

#import "GLBCocoaPods.h"

@interface ChoiseViewModel : NSObject

@property(nonatomic, strong) NSString* title;
@property(nonatomic, strong) Class viewController;

+ (instancetype)viewModelWithTitle:(NSString*)title viewController:(Class)viewController;

- (GLBViewController*)instantiateViewController;

@end
