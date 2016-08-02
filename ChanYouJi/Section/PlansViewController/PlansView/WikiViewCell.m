//
//  WikiViewCell.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "WikiViewCell.h"

@implementation WikiViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)dealloc {
    self.wiki = nil;
    [super dealloc];
}


- (UIButton *)Btn {
    if (!_Btn) {
        self.Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _Btn.frame = CGRectMake(10, 10, 100, 50);
    }
    return _Btn;
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.Btn];
    }
    return self;
}


- (void)setWiki:(WikiModel *)wiki {
    if (_wiki != wiki) {
        [_wiki release];
        _wiki = [wiki retain];
    }
    [self.Btn setTitle:wiki.title forState:UIControlStateNormal];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
