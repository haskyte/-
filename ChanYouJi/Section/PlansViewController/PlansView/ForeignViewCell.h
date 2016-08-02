//
//  ForeignViewCell.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/25.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondModel.h"

@interface ForeignViewCell : UICollectionViewCell
@property (nonatomic, retain)UILabel *name_zh_cnLabel;
@property (nonatomic, retain)UILabel *name_enLabel;
@property (nonatomic, retain)UIImageView *image;
@property (nonatomic, retain)SecondModel *secondModel;

@property (nonatomic, retain)UIButton *plansBtn;
@property (nonatomic, retain)UIButton *routeBtn;
@property (nonatomic, retain)UIButton *travelBtn;
@property (nonatomic, retain)UIButton *specialBtn;




@end
