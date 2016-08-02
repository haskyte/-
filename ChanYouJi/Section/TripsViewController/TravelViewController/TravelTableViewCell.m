//
//  TravelTableViewCell.m


#import "TravelTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ZoneViewController.h"
#import "Helper.h"
#define SCREENWIDE [UIScreen mainScreen].bounds.size.width
#define HEIGHT ([UIScreen mainScreen].bounds.size.height -100) / 2.5
@implementation TravelTableViewCell

// 懒加载
- (UIImageView *)photoView{
    if (_photoView == nil) {
        self.photoView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDE, HEIGHT)]autorelease];
        _photoView.layer.borderWidth = 1;
        _photoView.layer.borderColor = [UIColor whiteColor].CGColor;
        _photoView.layer.cornerRadius = 4;
        _photoView.layer.masksToBounds = YES;
    }
    return _photoView;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        self.nameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREENWIDE - 20, HEIGHT/6)]autorelease];
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}

- (UILabel *)dateLabel{
    if (_dateLabel == nil) {
        self.dateLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT/6 , SCREENWIDE / 2, HEIGHT / 12)]autorelease];
        _dateLabel.textColor = [UIColor whiteColor];
        _dateLabel.font = [UIFont systemFontOfSize:12];
    }
    return _dateLabel;
}

- (UIImageView *)userImage{
    if (_userImage == nil) {
        self.userImage = [[[UIImageView alloc] initWithFrame:CGRectMake(10, HEIGHT - 40, 30, 30)]autorelease];
        _userImage.layer.cornerRadius = 15;
        _userImage.layer.masksToBounds = YES;
        _userImage.layer.borderWidth = 1;
        _userImage.layer.borderColor = [UIColor whiteColor].CGColor;
        
        _userImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapUserImage:)];
        [_userImage addGestureRecognizer:tap];
    }
    return _userImage;
}

// 单机用户头像 跳转用户界面
- (void)tapUserImage:(UITapGestureRecognizer *)tap {
    ZoneViewController *zoneVC = [[ZoneViewController alloc]init];
    
    // 隐藏标签栏
    zoneVC.userID = self.travelModel.userID;
    zoneVC.hidesBottomBarWhenPushed = YES;
    [[Helper shareWithHelper].tripsNavigaitionController pushViewController:zoneVC animated:YES];
    [zoneVC release];
}

// 初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.photoView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.userImage];
    }
    return self;
}
// 重写set方法
- (void)setTravelModel:(TravelModel *)travelModel{
    if (_travelModel != travelModel) {
        [_travelModel release];
        _travelModel = [travelModel retain];
    }
    NSURL *photoURL = [NSURL URLWithString:travelModel.photoImage];
    [self.photoView sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    self.nameLabel.text = travelModel.name;
    self.dateLabel.text = [NSString stringWithFormat:@"%@/%@天/%@图",travelModel.startDate,travelModel.days,travelModel.photosCount];
    
    NSURL *userURL = [NSURL URLWithString:travelModel.userImage];
    [self.userImage sd_setImageWithURL:userURL];
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    self.travelModel = nil;
    self.photoView = nil;
    self.nameLabel = nil;
    self.dateLabel = nil;
    self.userImage = nil;
    [super dealloc];
}

@end
