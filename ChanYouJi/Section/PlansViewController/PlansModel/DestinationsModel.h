//
//  DestinationsModel.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/27.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DestinationsModel : NSObject
@property (nonatomic, copy)NSString *destinationsID;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *name_en;
@property (nonatomic, copy)NSString *attraction_trips_count;
@property (nonatomic, copy)NSString *user_score;//星星等级
@property (nonatomic, copy)NSString *description_summary;
@property (nonatomic, copy)NSString *image_url;
+ (instancetype)destinationsModel:(NSDictionary *)dic;
@end
