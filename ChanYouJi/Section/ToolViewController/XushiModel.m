//
//  XushiModel.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "XushiModel.h"

@implementation XushiModel

+ (XushiModel *)getDataSourceWithDic:(NSDictionary *)dic {
    XushiModel* model = [[XushiModel alloc] init];
    model.groupCountry_id = dic[@"id"];
    model.groupCountry_name = dic[@"name_zh_cn"];
    model.groupChildren = dic[@"children"];
    return model;
}

+ (XushiModel *)getDataModelWithDic : (NSDictionary *)dic {
    XushiModel * model = [[XushiModel alloc] init];
    model.country_id = dic[@"id"];
    model.country_name = dic[@"name_zh_cn"];
    return model;
}

- (void)dealloc {
    self.groupCountry_id = nil;
    self.groupCountry_name = nil;
    self.groupChildren = nil;
    self.country_id = nil;
    self.country_name = nil;
    [super dealloc];
}

@end
