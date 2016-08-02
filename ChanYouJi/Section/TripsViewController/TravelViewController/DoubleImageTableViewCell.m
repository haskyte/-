//
//  DoubleImageTableViewCell.m


#import "DoubleImageTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "Helper.h"
#import "DetailTableViewController.h"
#define SCREENWIDE [UIScreen mainScreen].bounds.size.width
#define HEIGHT ([UIScreen mainScreen].bounds.size.height -100) / 2.5
@implementation DoubleImageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIImageView *)photoImage1{
    if (_photoImage1 == nil) {
        self.photoImage1 = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDE/2, HEIGHT/2)]autorelease];
        _photoImage1.layer.borderWidth = 1;
        _photoImage1.layer.borderColor = [UIColor whiteColor].CGColor;
        _photoImage1.layer.cornerRadius = 4;
        _photoImage1.layer.masksToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage1:)];
        _photoImage1.userInteractionEnabled = YES;
        [_photoImage1 addGestureRecognizer:tap];
    }
    return _photoImage1;
}
- (UIImageView *)photoImage2{
    if (_photoImage2 == nil) {
        self.photoImage2 = [[[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDE/2 , 0, SCREENWIDE/2, HEIGHT/2)]autorelease];
        _photoImage2.layer.borderWidth = 1;
        _photoImage2.layer.borderColor = [UIColor whiteColor].CGColor;
        _photoImage2.layer.cornerRadius = 4;
        _photoImage2.layer.masksToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage2:)];
        _photoImage2.userInteractionEnabled = YES;
        [_photoImage2 addGestureRecognizer:tap];
    }
    return _photoImage2;
}
// 点击photo事件
- (void)clickImage1:(UITapGestureRecognizer *)tap{
    DetailTableViewController *detailVC = [[DetailTableViewController alloc]init];
    detailVC.topicID = self.position3;
    [[Helper shareWithHelper].tripsNavigaitionController pushViewController:detailVC animated:YES];
    [detailVC release];
}
- (void)clickImage2:(UITapGestureRecognizer *)tap{
    DetailTableViewController *detailVC = [[DetailTableViewController alloc]init];
    detailVC.topicID = self.position4;
    [[Helper shareWithHelper].tripsNavigaitionController pushViewController:detailVC animated:YES];
    [detailVC release];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.photoImage1];
        [self.contentView addSubview:self.photoImage2];
    }
    return self;
}

- (void)setDoubleImageModel:(DoubleImageModel *)doubleImageModel{
    if (_doubleImageModel != doubleImageModel) {
        [_doubleImageModel release];
        _doubleImageModel = [doubleImageModel retain];
    }
    CGFloat position = [doubleImageModel.position floatValue];
    NSURL *url = [NSURL URLWithString:doubleImageModel.image_url];
    if (position == 3) {
        [self.photoImage1 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeHolder"]];
        self.position3 = doubleImageModel.content;
        
    }else if (position == 4){
        [self.photoImage2 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeHolder"]];
        self.position4 = doubleImageModel.content;
    }
}

@end
