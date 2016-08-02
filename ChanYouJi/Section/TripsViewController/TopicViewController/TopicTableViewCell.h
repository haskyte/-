//
//  TopicTableViewCell.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/19.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicModel.h"
@interface TopicTableViewCell : UITableViewCell

@property (nonatomic, retain) UIImageView *photoImage;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) TopicModel *topicModel;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
