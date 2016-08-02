//
//  NearbyCollectionViewCell.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/24.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NearbyModel;
@interface NearbyCollectionViewCell : UICollectionViewCell
@property (nonatomic, retain)UIImageView *image;
@property (nonatomic, retain)UILabel *nameLabel;
@property (nonatomic, retain)UILabel *distanceLabel;
@property (nonatomic, retain)NearbyModel *nearbyModel;
@end
