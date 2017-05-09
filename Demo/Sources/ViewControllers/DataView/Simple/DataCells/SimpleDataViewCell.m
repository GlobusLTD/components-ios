//
//  Globus
//

#import "SimpleDataViewCell.h"
#import "SimpleDataProvider.h"

@interface SimpleDataViewCell ()

@property(nonatomic, weak) IBOutlet GLBImageView* avatarView;
@property(nonatomic, weak) IBOutlet UILabel* nameLabel;

@end

@implementation SimpleDataViewCell

- (void)setup {
    [super setup];
    
    _nameLabel.textColor = UIColor.darkGrayColor;
}

- (void)willShow {
    SimpleDataProviderModel* viewModel = self.item.data;
    _avatarView.imageUrl = viewModel.url;
    _nameLabel.text = [NSString stringWithFormat:@"%@ %@", viewModel.firstName, viewModel.lastName];
}

@end
