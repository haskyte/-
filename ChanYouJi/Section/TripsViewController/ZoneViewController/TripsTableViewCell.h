//
//  TripsTableViewCell.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/20.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TripsModel.h"
@interface TripsTableViewCell : UITableViewCell

@property (nonatomic, retain)UIImageView *photoView;
@property (nonatomic, retain)UILabel *nameLabel;
@property (nonatomic, retain)UILabel *dateLabel;

@property (nonatomic, retain) TripsModel *tripsModel;
@end
