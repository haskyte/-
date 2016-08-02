//
//  SecondTravelModel.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "SecondTravelModel.h"
#import "FourthThirdModel.h"

@implementation SecondTravelModel
- (void)dealloc {
    self.secondID = nil;
    self.memo = nil;
    self.fourthThirdModel = nil;
    [super dealloc];
}

+ (instancetype)secondTravelModel:(NSDictionary *)dic {
    SecondTravelModel *second = [[SecondTravelModel alloc] init];
    second.secondID = dic[@"id"];
    second.memo = dic[@"memo"];
   
    return [second autorelease];
}


@end
