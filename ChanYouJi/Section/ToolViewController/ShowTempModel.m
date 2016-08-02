//
//  ShowTempModel.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/27.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "ShowTempModel.h"

@implementation ShowTempModel

+ (instancetype)manager {
    static ShowTempModel * model = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[ShowTempModel alloc]init];
    });
    return model;
}

- (void)dealloc {
    self.countryID = nil;
    self.temp_max = nil;
    self.temp_min = nil;
    self.current_time = nil;
    [super dealloc];
}

@end
