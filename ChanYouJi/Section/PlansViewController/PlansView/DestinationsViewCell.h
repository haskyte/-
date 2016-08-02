//
//  DestinationsViewCell.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/27.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DestinationsModel;
@interface DestinationsViewCell : UITableViewCell
@property (nonatomic, retain)UIImageView *layerImage;
@property (nonatomic, retain)UILabel *trips_countLabel;
@property (nonatomic, retain)UILabel *nameLabel;
@property (nonatomic, retain)UILabel *user_scoreLabel;//星星
@property (nonatomic, retain)UILabel *summaryLabel;
@property (nonatomic, retain)DestinationsModel *destinationModel;
@end
