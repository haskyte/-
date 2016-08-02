//
//  ThirdTravelViewCell.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/29.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "ThirdTravelViewCell.h"
#import "SecondThirdModel.h"
#import "ThirdThirdModel.h"
#import "FourthThirdModel.h"
#import "UIImageView+WebCache.h"
#import "NetWorkManager.h"

@implementation ThirdTravelViewCell
- (void)dealloc {
    self.imageScroll = nil;
    self.user_nameLabel = nil;
    self.layerImage = nil;
    self.user = nil;
    self.start_time = nil;
    self.nameLabel = nil;
    self.arrayImageUrl = nil;
    [super dealloc];

}
- (UIImageView *)layerImage {
    if (!_layerImage) {
        self.layerImage = [[UIImageView alloc] initWithFrame:CGRectMake(0 , 0, [UIScreen mainScreen].bounds.size.width, 200)];
    }
    return _layerImage;
}
- (NSMutableArray *)arrayImageUrl {
    if (!_arrayImageUrl) {
        self.arrayImageUrl = [NSMutableArray array];
    }
    return _arrayImageUrl;
}


- (UILabel *)nameLabel {
    if (!_nameLabel ) {
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
    }
    return _nameLabel;
}

- (UIScrollView *)imageScroll {
    if (!_imageScroll) {
        self.imageScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 50, [UIScreen mainScreen].bounds.size.width, 200)];
    }
    return _imageScroll;
}


- (UILabel *)user_nameLabel {
    if (!_user_nameLabel) {
        self.user_nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.imageScroll.bounds.origin.y + 10, self.frame.size.width, 100)];
    }
    return _user_nameLabel;
}

- (UILabel *)user {
    if (!_user) {
        self.user = [[UILabel alloc] initWithFrame:CGRectMake(0, 210, self.frame.size.width / 2, 100)];
    }
    return _user;
}

- (UILabel *)start_time {
    if (!_start_time) {
        self.start_time = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 2, 210, self.frame.size.width / 2, 100)];
    }
    return _start_time;
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.imageScroll];
        [self.contentView addSubview:self.user_nameLabel];
        [self.user_nameLabel addSubview:self.user];
        [self.user_nameLabel addSubview:self.start_time];
        [self.contentView addSubview:self.nameLabel];
        [self.imageScroll addSubview:self.layerImage];
    }
    return self;
}




- (void)setSecond:(SecondThirdModel *)second {
    if (_second != second) {
        [_second release];
        _second = [second retain];
    }
    
    self.nameLabel.text = second.descriptionTitle;
    
}


- (void)setThird:(ThirdThirdModel *)third {
    if (_third != third) {
        [_third release];
        _third = [third retain];
    }

    self.user.text = third.user_name;
    self.start_time.text = third.start_date;
}

- (void)setFourth:(FourthThirdModel *)fourth {
    if (_fourth != fourth) {
        [_fourth release];
        _fourth = [fourth retain];
    }
    
    [self.layerImage sd_setImageWithURL:[NSURL URLWithString:fourth.photo_url] placeholderImage:nil];
    
    self.imageScroll.contentSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width  )* self.fourth.countNumber, 0);
    
    
        for (int i = 0; i < fourth.array_photoUrl.count; i++) {
            self.layerImage = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width ) * i , 0, [UIScreen mainScreen].bounds.size.width - 20, 200)];
            [self.layerImage sd_setImageWithURL:[NSURL URLWithString:fourth.array_photoUrl[i]] placeholderImage:nil];
            [self.imageScroll addSubview:self.layerImage];
            
        }
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
