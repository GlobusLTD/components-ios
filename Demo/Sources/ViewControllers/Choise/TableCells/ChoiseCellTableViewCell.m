//
//  Globus
//

#import "ChoiseCellTableViewCell.h"
#import "ChoiseViewModel.h"

@interface ChoiseCellTableViewCell ()

@property(nonatomic, weak) IBOutlet UILabel* displayLabel;

@end

@implementation ChoiseCellTableViewCell

+ (NSString*)glb_reuseIdentifier {
    return @"ChoiseCellTableViewCell";
}

- (void)configureWithChoiseViewModel:(ChoiseViewModel*)choiseViewModel {
    _displayLabel.text = choiseViewModel.title;
    _displayLabel.textColor = UIColor.darkGrayColor;
}

@end
