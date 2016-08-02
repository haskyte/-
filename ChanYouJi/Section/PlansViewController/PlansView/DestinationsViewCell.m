//
//  DestinationsViewCell.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/27.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "DestinationsViewCell.h"
#import "DestinationsModel.h"
#import "UIImageView+WebCache.h"

@implementation DestinationsViewCell
- (void)dealloc {
    self.layerImage = nil;
    self.trips_countLabel = nil;
    self.nameLabel = nil;
    self.user_scoreLabel = nil;
    self.summaryLabel = nil;
    self.destinationModel = nil;
    [super dealloc];
}

- (UIImageView *)layerImage {
    if (!_layerImage) {
        self.layerImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, [UIScreen mainScreen].bounds.size.width - 20, 100)];
    }
    return _layerImage;

}

- (UILabel *)trips_countLabel {
    if (!_trips_countLabel) {
        self.trips_countLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 100, 50)];
    }
    return _trips_countLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 10, 200, 50)];
    }
    return _nameLabel;
}

- (UILabel *)summaryLabel {
    if (!_summaryLabel) {
        self.summaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 70, 200, 50)];
        _summaryLabel.font = [UIFont systemFontOfSize:10];
        _summaryLabel.numberOfLines = 0;
    }
    return _summaryLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.layerImage];
        [self.layerImage addSubview:self.trips_countLabel];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.summaryLabel];
    }
    return self;
}

- (void)setDestinationModel:(DestinationsModel *)destinationModel {
    if (_destinationModel != destinationModel) {
        [_destinationModel release];
        _destinationModel = [destinationModel retain];
    }
    
    self.nameLabel.text = destinationModel.name;
    self.trips_countLabel.text = [NSString stringWithFormat:@"%@篇游记",destinationModel.attraction_trips_count];
    self.summaryLabel.text = destinationModel.description_summary;
    
    [self.layerImage sd_setImageWithURL:[NSURL URLWithString:destinationModel.image_url] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    
}







- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
