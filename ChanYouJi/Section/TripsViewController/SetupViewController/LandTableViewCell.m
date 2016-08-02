//
//  LandTableViewCell.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/25.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "LandTableViewCell.h"

@implementation LandTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.bounds.size.height);
        [self.contentView addSubview:button];
        [button setTitle:@"登陆" forState:UIControlStateNormal];
        button.tintColor = [UIColor blueColor];
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        [button addTarget:self action:@selector(touchUpInsideButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)touchUpInsideButton:(UIButton *)button{
    NSLog(@"登陆");
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
