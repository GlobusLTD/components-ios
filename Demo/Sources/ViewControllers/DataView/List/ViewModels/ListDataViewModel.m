//
//  Globus
//

#import "ListDataViewModel.h"

@implementation ListDataViewModel

+ (instancetype)viewModelWithTitle:(NSString*)title {
    ListDataViewModel* viewModel = [ListDataViewModel new];
    viewModel.title = title;
    return viewModel;
}

@end
