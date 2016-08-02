//
//  ForeignModel.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/24.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "ForeignModel.h"

@implementation ForeignModel
- (void)dealloc {
    self.ID = nil;
    self.name_zh_cn = nil;
    self.name_en = nil;
    self.poi_count = nil;
    self.image_url = nil;
    [super dealloc];
}

+ (instancetype)foreignModel:(NSDictionary *)dic {
    ForeignModel *foreignModel = [[ForeignModel alloc] init];
    foreignModel.ID = dic[@"id"];
    foreignModel.name_zh_cn = dic[@"name_zh_cn"];
    foreignModel.name_en = dic[@"name_en"];
    foreignModel.poi_count = dic[@"poi_count"];
    foreignModel.image_url = dic[@"image_url"];
    return [foreignModel autorelease];
}
@end
