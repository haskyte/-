//
//  NearbyModel.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/24.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NearbyModel : NSObject
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *image_url;
@property (nonatomic, assign)NSNumber *distance;
@property (nonatomic, copy)NSString *user_score;
@property (nonatomic, copy)NSString *NumberID;
+ (instancetype)neaybyModel:(NSDictionary *)dic;
@end
