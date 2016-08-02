//
//  ThirdTravelViewCell.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/29.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SecondThirdModel;
@class ThirdThirdModel;
@class FourthThirdModel;
@class FirstThirdModel;
@interface ThirdTravelViewCell : UITableViewCell
@property (nonatomic, retain)UIScrollView *imageScroll;
@property (nonatomic, retain)UILabel *user_nameLabel;
@property (nonatomic, retain)UILabel *user;
@property (nonatomic, retain)UILabel *start_time;
@property (nonatomic, retain)UIImageView *layerImage;
@property (nonatomic, retain)SecondThirdModel *second;
@property (nonatomic, retain)ThirdThirdModel *third;
@property (nonatomic, retain)FourthThirdModel *fourth;
@property (nonatomic, retain)UILabel *nameLabel;
@property (nonatomic, retain)NSMutableArray *arrayImageUrl;
@end
