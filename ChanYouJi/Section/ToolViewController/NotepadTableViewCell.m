//
//  NotepadTableViewCell.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/29.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "NotepadTableViewCell.h"

@implementation NotepadTableViewCell


- (UILabel *)name {
    if (_name == nil) {
        self.name =[[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 80, 40)]autorelease];
        _name.text = @"消费事项" ;
        
    }
    return _name;
}

- (UILabel *)nameDetails {
    if (_nameDetails == nil) {
        self.nameDetails = [[[UILabel alloc]initWithFrame:CGRectMake(120, 20, 100, 40)]autorelease];
        _nameDetails.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.5];
        _nameDetails.layer.cornerRadius = 10;
    }
    return _nameDetails;
}

- (UILabel *)money {
    if (_money == nil) {
        self.money =[[[UILabel alloc]initWithFrame:CGRectMake(20, 80, 80, 40)]autorelease];
        _money.text = @"花费金额" ;
    }
    return _money;
}

- (UILabel *)moneyDetails {
    if (_moneyDetails == nil) {
        self.moneyDetails =[[[UILabel alloc]initWithFrame:CGRectMake(120, 80, 100, 40)]autorelease];
        _moneyDetails.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.5];
        _moneyDetails.layer.cornerRadius = 20;
    }
    return _moneyDetails;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.nameDetails];
        [self.contentView addSubview:self.money];
        [self.contentView addSubview:self.moneyDetails];
    }
    return self;
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
