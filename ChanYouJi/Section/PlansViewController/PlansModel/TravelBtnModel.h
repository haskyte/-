//
//  TravelModel.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TravelBtnModel : NSObject

@property (nonatomic, retain)NSNumber *travel_ID;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *travel_description;
@property (nonatomic, retain)NSNumber *plan_days_count;
@property (nonatomic, retain)NSNumber *plan_nodes_count;
@property (nonatomic, copy)NSString *image_url;

+ (instancetype)travelBtnModel:(NSDictionary *)dic;
@end
