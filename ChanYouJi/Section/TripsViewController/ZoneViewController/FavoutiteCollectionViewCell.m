//
//  FavoutiteCollectionViewCell.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/27.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "FavoutiteCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation FavoutiteCollectionViewCell

//- (void)dealloc
//{
//    self.photoImage = nil;
//    [super dealloc];
//}

- (UIImageView *)photoImage{
    if (_photoImage == nil) {
        self.photoImage = [[[UIImageView alloc] initWithFrame:self.bounds]autorelease];
    }
    return _photoImage;
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.photoImage];
    }
    return self;
}

//-(void)layoutSubviews{
//    [super layoutSubviews];
//
//}

- (void)setFavouriteModel:(UserFavouriteModel *)favouriteModel{
    if (_favouriteModel != favouriteModel) {
        [_favouriteModel release];
        _favouriteModel = [favouriteModel retain];
    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",favouriteModel.photoUrl]];
    [self.photoImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    self.photoImage.frame = self.bounds;
    
}

@end
