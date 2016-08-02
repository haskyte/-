//
//  SecondModel.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/25.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "SecondModel.h"

@implementation SecondModel
- (void)dealloc {
    self.name_zh_cn = nil;
    self.name_en = nil;
    self.image_url = nil;
    [super dealloc];
}

+ (instancetype)secondModel:(NSDictionary *)dic {
    SecondModel *second = [[SecondModel alloc] init];
    second.name_zh_cn = dic[@"name_zh_cn"];
    second.name_en = dic[@"name_en"];
    second.image_url = dic[@"image_url"];
    second.ID = dic[@"id"];
    return [second autorelease];
}

@end
