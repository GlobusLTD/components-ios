//
//  Globus
//

#import "ListDataViewCell.h"
#import "ListDataViewModel.h"

@interface ListDataViewCell ()

@property(nonatomic, weak) IBOutlet UILabel* displayLabel;

@end

@implementation ListDataViewCell

- (CGSize)sizeForAvailableSize:(CGSize)size {
    return CGSizeMake(size.width, 88.0f);
}

- (void)setup {
    [super setup];
    
    _displayLabel.textColor = UIColor.darkGrayColor;
}

- (void)willShow {
    ListDataViewModel* viewModel = self.item.data;
    _displayLabel.text = viewModel.title;
}

@end
