//
//  ArticlesViewCell.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/27.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "ArticlesViewCell.h"
#import "ArticlesModel.h"
#import "UIImageView+WebCache.h"

@implementation ArticlesViewCell

- (void)dealloc {
    self.nameLabel = nil;
    self.layerImage = nil;
    self.titleLabel = nil;
    self.articlesModel = nil;
    [super dealloc];

}

- (UIImageView *)layerImage {
    if (!_layerImage) {
        self.layerImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width , 300)];
    }
    return _layerImage;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 250, 200, 50)];
    }
    return _titleLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, 200, 50)];
    }
    return _nameLabel;
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.layerImage];
        [self.layerImage addSubview:self.nameLabel];
        [self.layerImage addSubview:self.titleLabel];
    }
    return self;
}

- (void)setArticlesModel:(ArticlesModel *)articlesModel {
    if (_articlesModel != articlesModel) {
        [_articlesModel release];
        _articlesModel = [articlesModel retain];
    }
    
    self.nameLabel.text = articlesModel.name;
    self.titleLabel.text = articlesModel.title;
    [self.layerImage sd_setImageWithURL:[NSURL URLWithString:articlesModel.image_url] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    
    
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
