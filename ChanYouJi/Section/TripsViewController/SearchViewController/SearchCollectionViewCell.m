//
//  SearchCollectionViewCell.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "SearchCollectionViewCell.h"
#import "SearchModel.h"
@implementation SearchCollectionViewCell

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        self.nameLabel = [[[UILabel alloc] initWithFrame:self.bounds]autorelease];
        _nameLabel.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.nameLabel];
    }
    return self;
}

- (void)setSearchModel:(SearchModel *)searchModel{
    if (_searchModel != searchModel) {
        [_searchModel release];
        _searchModel = [searchModel retain];
    }
    self.nameLabel.text = searchModel.name;
    
}

- (void)dealloc
{
    self.nameLabel = nil;
    [super dealloc];
}
@end
