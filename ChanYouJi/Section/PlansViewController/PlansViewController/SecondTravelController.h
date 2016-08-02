//
//  SecondTravelController.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondTravelController : UIViewController
@property (nonatomic, copy)NSString *travel_ID;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *image_url;
@property (nonatomic, retain)NSNumber *plan_days_count;
@property (nonatomic, retain)NSNumber *plan_nodes_count;
@end
