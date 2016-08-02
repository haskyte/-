//
//  ThirdTravelModel.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "ThirdTravelModel.h"

@implementation ThirdTravelModel
- (void)dealloc {
    self.thirdID = nil;
    self.entry_id = nil;
    self.tips = nil;
    self.image_url = nil;
    self.entry_name = nil;
    self.entry_type = nil;
    self.attraction_type = nil;
    [super dealloc];
}

+ (instancetype)thirdTravelModel:(NSDictionary *)dic {
    ThirdTravelModel *third = [[ThirdTravelModel alloc] init];
    
    third.thirdID = dic[@"id"];
    third.entry_id = dic[@"entry_id"];
    third.tips = dic[@"tips"];
    third.image_url = dic[@"image_url"];
    third.entry_name = dic[@"entry_name"];
    third.entry_type = dic[@"entry_type"];
    third.attraction_type = dic[@"attraction_type"];
    third.name_zh_cn = dic[@"destination"][@"name_zh_cn"];
    
    return [third autorelease];
}


@end
