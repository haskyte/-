//
//  DetailTableViewCell.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/23.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailModel;
@interface DetailTableViewCell : UITableViewCell

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *descriptionLabel;

@property (nonatomic, retain) UIImageView *photoImage;
@property (nonatomic, retain) UILabel *tripNameLabel;
@property (nonatomic, retain) UILabel *userNameLabel;

@property (nonatomic, retain) DetailModel *detailModel;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
