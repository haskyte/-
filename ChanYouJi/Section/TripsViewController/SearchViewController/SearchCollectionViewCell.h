//
//  SearchCollectionViewCell.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchModel;
@interface SearchCollectionViewCell : UICollectionViewCell

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) SearchModel *searchModel;

- (instancetype)initWithFrame:(CGRect)frame;

@end
