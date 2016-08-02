//
//  ShowTempModel.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/27.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowTempModel : NSObject
@property (nonatomic,copy)NSString * countryID;
@property (nonatomic,copy)NSString * temp_min;
@property (nonatomic,copy)NSString * temp_max;
@property (nonatomic,copy)NSString * current_time;

+ (instancetype)manager;

@end
