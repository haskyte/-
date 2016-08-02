//
//  TravelModel.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "TravelBtnModel.h"

@implementation TravelBtnModel
- (void)dealloc {
    self.travel_ID = nil;
    self.name = nil;
    self.travel_description = nil;
    self.plan_days_count = nil;
    self.plan_nodes_count = nil;
    self.image_url = nil;
    [super dealloc];
}

+ (instancetype)travelBtnModel:(NSDictionary *)dic {
    TravelBtnModel *travel = [[TravelBtnModel alloc] init];
    travel.travel_ID = dic[@"id"];
    travel.name = dic[@"name"];
    travel.travel_description = dic[@"description"];
    travel.plan_days_count = dic[@"plan_days_count"];
    travel.plan_nodes_count = dic[@"plan_nodes_count"];
    travel.image_url = dic[@"image_url"];
    return [travel autorelease];
}


@end
