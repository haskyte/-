//
//  SecondTravelViewCell.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FirstTravelModel;
@class SecondTravelModel;
@class ThirdTravelModel;
@interface SecondTravelViewCell : UITableViewCell
@property (nonatomic, retain)FirstTravelModel *first;
@property (nonatomic, retain)SecondTravelModel *second;
@property (nonatomic, retain)ThirdTravelModel *third;
@property (nonatomic, retain)UIImageView *layerImage;
@property (nonatomic, retain)UILabel *label;
@property (nonatomic, retain)UILabel *accessLabel;
@end
