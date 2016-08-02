//
//  TravelTableViewCell.h


#import <UIKit/UIKit.h>
#import "TravelModel.h"
@interface TravelTableViewCell : UITableViewCell

@property (nonatomic, retain)UIImageView *photoView;
@property (nonatomic, retain)UILabel *nameLabel;
@property (nonatomic, retain)UILabel *dateLabel;
@property (nonatomic, retain)UIImageView *userImage;
@property (nonatomic, retain) TravelModel *travelModel;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
