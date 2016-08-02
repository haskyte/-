//
//  TravelViewCell.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "TravelViewCell.h"
#import "TravelBtnModel.h"
#import "UIImageView+WebCache.h"

@implementation TravelViewCell
- (void)dealloc {
    self.nameLabel = nil;
    self.descriptionLabel = nil;
    self.planLabel = nil;
    self.image = nil;
    self.planLabel = nil;
    [super dealloc];

}

- (UIImageView *)image {
    if (!_image) {
        
        self.image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 20, 200)];
    }
    return _image;
}


- (UILabel *)nameLabel {
    if (!_nameLabel) {
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.image.bounds.origin.x, self.image.bounds.origin.y + 120, 250, 30)];
        self.nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}


- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.image.bounds.origin.x, self.image.bounds.origin.y + 220, 300, 80)];
        self.descriptionLabel.numberOfLines = 0;
    }
    return _descriptionLabel;
}

- (UILabel *)planLabel {
    if (!_planLabel) {
        self.planLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.image.bounds.origin.x, self.image.bounds.origin.y + 150, 150, 30)];
    }
    return _planLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.image];
        [self addSubview:self.descriptionLabel];
        [self.image addSubview:self.nameLabel];
        [self.image addSubview:self.planLabel];
        
    }
    return self;
}





- (void)setTravelBtnModel:(TravelBtnModel *)travelBtnModel {
    if (_travelBtnModel != travelBtnModel) {
        [_travelBtnModel release];
        _travelBtnModel = [travelBtnModel retain];
    }
    
    self.nameLabel.text = travelBtnModel.name;
    self.descriptionLabel.text = travelBtnModel.travel_description;
    
    self.planLabel.text = [NSString stringWithFormat:@"%@天/%@个旅游地",travelBtnModel.plan_days_count,travelBtnModel.plan_nodes_count];
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:travelBtnModel.image_url] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
}






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
