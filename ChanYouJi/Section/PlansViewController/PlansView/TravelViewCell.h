//
//  TravelViewCell.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TravelBtnModel;
@interface TravelViewCell : UITableViewCell
@property (nonatomic, retain)UILabel *nameLabel;
@property (nonatomic, retain)UILabel *planLabel;
@property (nonatomic, retain)UILabel *descriptionLabel;
@property (nonatomic, retain)UIImageView *image;
@property (nonatomic, retain)TravelBtnModel *travelBtnModel;
@end
