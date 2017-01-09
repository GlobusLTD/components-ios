//
//  Globus
//

#import "ChoiseViewModel.h"

@implementation ChoiseViewModel

+ (instancetype)viewModelWithTitle:(NSString*)title viewController:(Class)viewController {
    ChoiseViewModel* viewModel = [ChoiseViewModel new];
    viewModel.title = title;
    viewModel.viewController = viewController;
    return viewModel;
}

- (GLBViewController*)instantiateViewController {
    return [_viewController instantiate];
}

@end
