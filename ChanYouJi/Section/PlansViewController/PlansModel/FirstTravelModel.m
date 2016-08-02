//
//  FirstTravelModel.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "FirstTravelModel.h"
#import "SecondTravelModel.h"

@implementation FirstTravelModel
- (void)dealloc {
    self.name = nil;
    self.image_url = nil;
    self.secondTravelModel = nil;
    [super dealloc];
}

+ (instancetype)firstTravelModel:(NSDictionary *)dic {
    FirstTravelModel *first = [[FirstTravelModel alloc] init];
    first.name = dic[@"name"];
    first.image_url = dic[@"image_url"];
    for (NSDictionary *dic in dic[@"plan_days"]) {
       first.secondTravelModel  = [SecondTravelModel secondTravelModel:dic];
    }
    
    return [first autorelease];
}



@end
