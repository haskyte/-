//
//  ThirdTravelModel.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThirdTravelModel : NSObject
@property (nonatomic, copy)NSString *thirdID;
@property (nonatomic, copy)NSString *entry_id;
@property (nonatomic, copy)NSString *tips;
@property (nonatomic, copy)NSString *image_url;
@property (nonatomic, copy)NSString *entry_name;
@property (nonatomic, copy)NSString *entry_type;
@property (nonatomic, copy)NSString *attraction_type;
@property (nonatomic, copy)NSString *name_zh_cn;
+ (instancetype)thirdTravelModel:(NSDictionary *)dic;
@end
