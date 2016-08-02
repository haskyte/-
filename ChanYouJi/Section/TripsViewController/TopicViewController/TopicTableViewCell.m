//
//  TopicTableViewCell.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/19.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "TopicTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "DetailTableViewController.h"
#import "Helper.h"
#define HEIGHT ([UIScreen mainScreen].bounds.size.height -100) / 2.5
#define WIDTH [UIScreen mainScreen].bounds.size.width

@implementation TopicTableViewCell

//懒加载
- (UIImageView *)photoImage{
    if (_photoImage == nil) {
        self.photoImage = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)]autorelease];
        _photoImage.backgroundColor = [UIColor redColor];
        _photoImage.layer.borderWidth = 1;
        _photoImage.layer.borderColor = [UIColor whiteColor].CGColor;
        _photoImage.layer.cornerRadius = 4;
        _photoImage.layer.masksToBounds = YES;
        _photoImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)];
        [_photoImage addGestureRecognizer:tap];
    }
    return _photoImage;
}

// 点击跳转界面
- (void)clickImage:(UITapGestureRecognizer *)tap{
    DetailTableViewController *detailVC = [[DetailTableViewController alloc] init];
    detailVC.hidesBottomBarWhenPushed = YES;
    [[Helper shareWithHelper].tripsNavigaitionController pushViewController:detailVC animated:YES];
    detailVC.topicModel = self.topicModel;
    detailVC.topicID = self.topicModel.topicID;
    [detailVC release];
}


- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        self.nameLabel = [[[UILabel alloc]initWithFrame:CGRectMake(10, HEIGHT - 50 , WIDTH - 20, 30)]autorelease];
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT - 30, WIDTH - 20, 20)]autorelease];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

// 初始化方法
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.photoImage];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

// 重写TopicModel set方法
- (void)setTopicModel:(TopicModel *)topicModel{
    if (_topicModel != topicModel) {
        [_topicModel release];
        _topicModel = [topicModel retain];
    }
    NSURL *url = [NSURL URLWithString:self.topicModel.imageURL];
    [self.photoImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    self.nameLabel.text = self.topicModel.name;
    self.titleLabel.text = self.topicModel.title;
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
    self.topicModel = nil;
    self.nameLabel = nil;
    self.photoImage = nil;
    self.titleLabel = nil;
    [super dealloc];
}

@end
