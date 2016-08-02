//
//  DetailTableViewCell.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/23.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "DetailTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "DetailModel.h"
#import "NotesTableViewController.h"
#import "Helper.h"

#define SCREENWIDE [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define HEIGHT SCREENHEIGHT/3
@implementation DetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
// 懒加载

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        self.titleLabel = [[[UILabel alloc] init]autorelease];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.numberOfLines = 0;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _titleLabel;
}
- (UILabel *)descriptionLabel{
    if (_descriptionLabel == nil) {
        self.descriptionLabel = [[[UILabel alloc] init]autorelease];
        _descriptionLabel.font = [UIFont systemFontOfSize:12];
        _descriptionLabel.numberOfLines = 0;
        _descriptionLabel.lineBreakMode =NSLineBreakByWordWrapping;
    }
    return _descriptionLabel;
}

- (UIImageView *)photoImage{
    if(_photoImage == nil){
        self.photoImage = [[[UIImageView alloc] init]autorelease];
        _photoImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPhoto:)];
        [_photoImage addGestureRecognizer:tap];
    }
    return _photoImage;
}

- (void)clickPhoto:(UITapGestureRecognizer *)tap{
    NotesTableViewController *noteVC = [[NotesTableViewController alloc] init];
    noteVC.tripsID = [NSString stringWithFormat:@"%@",self.detailModel.tripId];
    [[Helper shareWithHelper].detailNavigaitonController pushViewController:noteVC animated:YES];
    [noteVC release];
}

- (UILabel *)tripNameLabel{
    if (_tripNameLabel == nil) {
        self.tripNameLabel = [[[UILabel alloc] init]autorelease];
        _tripNameLabel.font = [UIFont systemFontOfSize:12];
        _tripNameLabel.textColor = [UIColor whiteColor];
    }
    return _tripNameLabel;
}
- (UILabel *)userNameLabel{
    if (_userNameLabel == nil) {
        self.userNameLabel = [[[UILabel alloc] init] autorelease];
        _userNameLabel.textColor = [UIColor whiteColor];
        _userNameLabel.font = [UIFont systemFontOfSize:12];
    }
    return _userNameLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.descriptionLabel];
        [self.contentView addSubview:self.photoImage];
        [self.photoImage addSubview:self.userNameLabel];
        [self.photoImage addSubview:self.tripNameLabel];
        
    }
    return self;
}

// 重写set方法
- (void)setDetailModel:(DetailModel *)detailModel{
    if (_detailModel != detailModel) {
        [_detailModel release];
        _detailModel = [detailModel retain];
    }
    NSURL *url = [NSURL URLWithString:detailModel.imageUrl];
    [self.photoImage sd_setImageWithURL:url];
    
    self.descriptionLabel.text = detailModel.imageDescription;
    CGRect rect = [self.descriptionLabel.text boundingRectWithSize:CGSizeMake(300, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    
    self.titleLabel.text = detailModel.title;
    CGRect rect1 = [self.titleLabel.text boundingRectWithSize:CGSizeMake(300, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    self.titleLabel.frame = CGRectMake(10, 0, SCREENWIDE, rect1.size.height);
    
    CGFloat height = [self.detailModel.imageHeight floatValue];
    CGFloat width = [self.detailModel.imageWidth floatValue];
    CGFloat photoHeight = height * (SCREENWIDE - 20) / width;
    if (height == 0 ) {
//        self.photoImage.frame = CGRectMake(0, 0, 0, 0);
        if (self.titleLabel.text.length == 0) {
            self.descriptionLabel.frame = CGRectMake(10, 0, SCREENWIDE - 20, rect.size.height);
        }else{
            self.descriptionLabel.frame = CGRectMake(10, rect1.size.height, SCREENWIDE - 20, rect.size.height);
        }
    }else{
        if (self.titleLabel.text.length == 0) {
            self.photoImage.frame = CGRectMake(10, 10 , SCREENWIDE - 20, photoHeight);
            self.descriptionLabel.frame = CGRectMake(10, 10+ photoHeight, SCREENWIDE - 20, rect.size.height);
        }else{
        self.photoImage.frame = CGRectMake(10, rect1.size.height, SCREENWIDE - 20, photoHeight);
        self.descriptionLabel.frame = CGRectMake(10, rect1.size.height + photoHeight, SCREENWIDE - 20, rect.size.height);
        self.userNameLabel.frame = CGRectMake(10, photoHeight - 30 , SCREENWIDE, 15);
        self.tripNameLabel.frame = CGRectMake(10, photoHeight - 15, SCREENWIDE, 15);
        }
    }

    self.userNameLabel.text = detailModel.userName;
    self.tripNameLabel.text = detailModel.tripName;
    
}



- (void)dealloc
{
    self.titleLabel = nil;
    self.descriptionLabel = nil;
    self.photoImage = nil;
    self.tripNameLabel = nil;
    self.userNameLabel = nil;
    self.detailModel = nil;
    [super dealloc];
}

@end
