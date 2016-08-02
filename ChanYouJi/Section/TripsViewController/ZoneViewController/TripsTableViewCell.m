//
//  TripsTableViewCell.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/20.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "TripsTableViewCell.h"
#import "UIImageView+WebCache.h"
#define SCREENWIDE [UIScreen mainScreen].bounds.size.width
#define HEIGHT ([UIScreen mainScreen].bounds.size.height - 64) / 3

@implementation TripsTableViewCell

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

// 初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.photoView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.dateLabel];
        
    }
    return self;
}
// 重写set方法
- (void)setTripsModel:(TripsModel *)tripsModel{
    if (_tripsModel != tripsModel) {
        [_tripsModel release];
        _tripsModel = [tripsModel retain];
    }
    self.nameLabel.text = tripsModel.nameLabel;
    self.dateLabel.text = [NSString stringWithFormat:@"%@/%@天/%@图",self.tripsModel.startDate,self.tripsModel.days,self.tripsModel.photoCount];
    NSURL *url = [NSURL URLWithString:self.tripsModel.photoImage];
    [self.photoView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
