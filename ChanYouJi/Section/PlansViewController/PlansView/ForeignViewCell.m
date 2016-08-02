//
//  ForeignViewCell.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/25.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "ForeignViewCell.h"
#import "SecondModel.h"
#import "UIImageView+WebCache.h"

@implementation ForeignViewCell
- (void)dealloc {
    self.name_zh_cnLabel = nil;
    self.name_enLabel = nil;
    self.image = nil;
    [super dealloc];
}

//- (UIButton *)plansBtn {
//    if (!_plansBtn) {
//        
//        self.plansBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_plansBtn setTitle:@"攻略" forState:UIControlStateNormal];
//        _plansBtn.frame = CGRectMake(0, 210, self.frame.size.width / 4, 30);
//        
//    }
//    return _plansBtn;
//}




- (UIButton *)routeBtn {
    if (!_routeBtn) {
        self.routeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _routeBtn.frame = CGRectMake(0, 210, self.frame.size.width / 3, 30);
        [_routeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_routeBtn setTitle:@"行程" forState:UIControlStateNormal];
    }
    return _routeBtn;
}

- (UIButton *)travelBtn {
    if (!_travelBtn) {
        self.travelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_travelBtn setTitle:@"旅行地" forState:UIControlStateNormal];
        [_travelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _travelBtn.frame = CGRectMake(self.frame.size.width / 3, 210, self.frame.size.width / 3, 30);
    }
    return _travelBtn;
}

- (UIButton *)specialBtn {
    if (!_specialBtn) {
        self.specialBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_specialBtn setTitle:@"专题" forState:UIControlStateNormal];
        [_specialBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _specialBtn.frame = CGRectMake(self.frame.size.width / 3 * 2, 210, self.frame.size.width / 3, 30);
    }
    return _specialBtn;
}



- (UILabel *)name_zh_cnLabel {
    if (!_name_zh_cnLabel) {
        self.name_zh_cnLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 150, 30)];
    }
    return _name_zh_cnLabel;
}

- (UILabel *)name_enLabel {
    if (!_name_enLabel) {
        self.name_enLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 150, 30)];
    }
    return _name_enLabel;
}

- (UIImageView *)image {
    if (!_image) {
        self.image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 20, 200)];
        
    }
    return _image;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.userInteractionEnabled = YES;
        [self.contentView addSubview:self.image];
        [self.image addSubview:self.name_zh_cnLabel];
        [self.image addSubview:self.name_enLabel];
        [self.contentView addSubview:self.plansBtn];
        
        [self.contentView addSubview:self.routeBtn];
        
        [self.contentView addSubview:self.travelBtn];
        
        [self.contentView addSubview:self.specialBtn];
        
        
    }
    return self;
}

- (void)setSecondModel:(SecondModel *)secondModel {

    if (_secondModel != secondModel) {
        [_secondModel release];
        _secondModel = [secondModel retain];
    }
    self.name_zh_cnLabel.text = secondModel.name_zh_cn;
    self.name_enLabel.text = secondModel.name_en;
    [self.image sd_setImageWithURL:[NSURL URLWithString:secondModel.image_url] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    self.plansBtn.tag = [secondModel.ID integerValue];
    self.routeBtn.tag = [secondModel.ID integerValue];
    self.travelBtn.tag = [secondModel.ID integerValue];
    self.specialBtn.tag = [secondModel.ID integerValue];
}




@end
