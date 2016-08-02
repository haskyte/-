//
//  NearbyModel.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/24.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "NearbyModel.h"

@implementation NearbyModel
- (void)dealloc {
    self.name = nil;
    self.distance = nil;
    self.image_url = nil;
    self.user_score = nil;
    self.NumberID = nil;
    [super dealloc];
}

+ (instancetype)neaybyModel:(NSDictionary *)dic {
    NearbyModel *nearby = [[NearbyModel alloc] init];
    nearby.name = dic[@"name"];
    nearby.distance = dic[@"distance"];
    nearby.image_url = dic[@"image_url"];
    nearby.user_score = dic[@"user_score"];
    nearby.NumberID = dic[@"id"];
    return [nearby autorelease];
}

@end
