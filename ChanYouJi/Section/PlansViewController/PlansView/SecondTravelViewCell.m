//
//  SecondTravelViewCell.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "SecondTravelViewCell.h"
#import "FirstTravelModel.h"
#import "SecondTravelModel.h"
#import "ThirdTravelModel.h"
#import "UIImageView+WebCache.h"

@implementation SecondTravelViewCell
- (void)dealloc {
    self.first = nil;
    self.second = nil;
    self.third = nil;
    self.layerImage = nil;
    self.label = nil;
    self.accessLabel = nil;
    [super dealloc];
}

- (UILabel *)accessLabel {
    if (!_accessLabel) {
        self.accessLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
    }
    return _accessLabel;
}


- (UIImageView *)layerImage {
    if (!_layerImage) {
        self.layerImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, [UIScreen mainScreen].bounds.size.width - 20, 150)];
    }
    return _layerImage;
}

- (UILabel *)label {
    if (!_label) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 210, self.bounds.size.width, 145)];
        self.label.numberOfLines = 0;
    }
    return _label;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.layerImage];
        [self.contentView addSubview:self.label];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
////        [self.accessoryView addSubview:self.accessLabel];
        [self.contentView addSubview:self.accessLabel];
        
    }
    return self;
}


//- (void)setSecond:(SecondTravelModel *)second {
//    if (_second != second) {
//        [_second release];
//        _second = [second retain];
//    }
//
//    self.label.text = second.memo;
//}

- (void)setThird:(ThirdTravelModel *)third {
    if (_third != third) {
        [_third release];
        _third = [third retain];
    }
    self.label.text = third.tips;
    
    self.accessLabel.text = [NSString stringWithFormat:@"%@",third.entry_name];
    [self.layerImage sd_setImageWithURL:[NSURL URLWithString:third.image_url] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    
}








- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
