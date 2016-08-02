//
//  DestinationsModel.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/27.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "DestinationsModel.h"

@implementation DestinationsModel
- (void)dealloc {
    self.destinationsID = nil;
    self.name = nil;
    self.name_en = nil;
    self.attraction_trips_count = nil;
    self.user_score = nil;
    self.description_summary = nil;
    self.image_url = nil;
    [super dealloc];
}

+ (instancetype)destinationsModel:(NSDictionary *)dic {
    DestinationsModel *destination = [[DestinationsModel alloc] init];
    destination.destinationsID = dic[@"id"];
    destination.name = dic[@"name"];
    destination.name_en = dic[@"name_en"];
    destination.attraction_trips_count = dic[@"attraction_trips_count"];
    destination.user_score = dic[@"user_score"];
    destination.description_summary = dic[@"description_summary"];
    destination.image_url = dic[@"image_url"];
    return [destination autorelease];
}




@end
