//
//  FavoutiteCollectionViewCell.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/27.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserFavouriteModel.h"

@interface FavoutiteCollectionViewCell : UICollectionViewCell

@property (nonatomic, retain) UIImageView *photoImage;
@property (nonatomic, retain) UserFavouriteModel *favouriteModel;

- (instancetype)initWithFrame:(CGRect)frame;
@end
