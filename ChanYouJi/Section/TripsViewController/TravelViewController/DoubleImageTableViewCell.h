//
//  DoubleImageTableViewCell.h


#import <UIKit/UIKit.h>
#import "DoubleImageModel.h"
@interface DoubleImageTableViewCell : UITableViewCell

@property (nonatomic, retain) UIImageView *photoImage1;
@property (nonatomic, retain) UIImageView *photoImage2;
@property (nonatomic, retain) DoubleImageModel *doubleImageModel;

@property (nonatomic, copy) NSString *position3;
@property (nonatomic, copy) NSString *position4;

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
