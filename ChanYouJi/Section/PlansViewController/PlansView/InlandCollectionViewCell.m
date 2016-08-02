//
//  InlandCollectionViewCell.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/24.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "InlandCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "ForeignModel.h"

@implementation InlandCollectionViewCell
- (void)dealloc {
    self.image = nil;
    self.name_zh_cn = nil;
    self.name_en = nil;
    self.poi_count = nil;
    self.foreignModel = nil;
    [super dealloc];
}
- (UIImageView *)image {
    if (!_image) {
        self.image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 20, 200)];
    }
    return _image;
}

- (UILabel *)name_zh_cn {
    if (!_name_zh_cn) {
        self.name_zh_cn = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 150, 30)];
    }
    return _name_zh_cn;
}

- (UILabel *)name_en {
    if (!_name_en) {
        self.name_en = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 150, 30)];
    }
    return _name_en;
}

- (UILabel *)poi_count {
    if (!_poi_count) {
        self.poi_count = [[UILabel alloc] initWithFrame:CGRectMake(200, 150, 100, 30)];
    }
    return _poi_count;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.image];
        [self addSubview:self.name_zh_cn];
        [self addSubview:self.name_en];
        [self addSubview:self.poi_count];
    }
    return self;
}

- (void)setForeignModel:(ForeignModel *)foreignModel {
    if (_foreignModel != foreignModel) {
        [_foreignModel release];
        _foreignModel = [foreignModel retain];
    }
    
    self.name_zh_cn.text = foreignModel.name_zh_cn;
    self.name_en.text = foreignModel.name_en;
    self.poi_count.text = [NSString stringWithFormat:@"旅行地%ld",(long)foreignModel.poi_count];
    [self.image sd_setImageWithURL:[NSURL URLWithString:foreignModel.image_url] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    
}


@end
