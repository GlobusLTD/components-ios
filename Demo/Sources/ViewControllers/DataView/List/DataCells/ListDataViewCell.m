//
//  Globus
//

#import "ListDataViewCell.h"
#import "ListDataProvider.h"

@interface ListDataViewCell ()

@property(nonatomic, weak) IBOutlet UILabel* displayLabel;

@end

@implementation ListDataViewCell

- (CGSize)sizeForAvailableSize:(CGSize)size {
    return CGSizeMake(size.width, 100.0f);
}

- (void)setup {
    [super setup];
    
    _displayLabel.textColor = UIColor.darkGrayColor;
}

- (void)willShow {
    ListDataProviderModel* viewModel = self.item.data;
    _displayLabel.text = viewModel.title;
}

@end
