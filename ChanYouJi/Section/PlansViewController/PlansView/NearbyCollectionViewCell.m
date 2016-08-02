//
//  NearbyCollectionViewCell.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/24.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "NearbyCollectionViewCell.h"
#import "NearbyModel.h"
#import "UIImageView+WebCache.h"

@implementation NearbyCollectionViewCell
- (void)dealloc {
    self.nearbyModel = nil;
    self.nameLabel = nil;
    self.distanceLabel = nil;
    self.image = nil;
    [super dealloc];
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
    }
    return _nameLabel;
}

- (UILabel *)distanceLabel {
    if (!_distanceLabel) {
        self.distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 80, 30)];
    }
    return _distanceLabel;
}

- (UIImageView *)image {
    if (!_image) {
        self.image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width - 20, 200)];
    }
    return _image;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.image];
        [self.image addSubview:self.nameLabel];
        [self.image addSubview:self.distanceLabel];
    }
    return self;
}

- (void)setNearbyModel:(NearbyModel *)nearbyModel {
    if (_nearbyModel != nearbyModel) {
        [_nearbyModel release];
        _nearbyModel = [nearbyModel retain];
    }
    
    self.nameLabel.text = nearbyModel.name;
//    self.distanceLabel.text = [NSString stringWithFormat:@"%@km",[[NSString stringWithFormat:@"%@",nearbyModel.distance] substringToIndex:4]];

    
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:nearbyModel.image_url] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    
    
    
}



@end
