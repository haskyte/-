//
//  ArticlesViewCell.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/27.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ArticlesModel;
@interface ArticlesViewCell : UITableViewCell
@property (nonatomic, retain)UILabel *nameLabel;
@property (nonatomic, retain)UILabel *titleLabel;
@property (nonatomic, retain)UIImageView *layerImage;
@property (nonatomic, retain)ArticlesModel *articlesModel;
@end
