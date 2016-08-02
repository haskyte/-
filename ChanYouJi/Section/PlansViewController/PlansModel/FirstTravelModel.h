//
//  FirstTravelModel.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SecondTravelModel;
@interface FirstTravelModel : NSObject
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *image_url;
@property (nonatomic, retain)SecondTravelModel *secondTravelModel;

+ (instancetype)firstTravelModel:(NSDictionary *)dic;

@end
