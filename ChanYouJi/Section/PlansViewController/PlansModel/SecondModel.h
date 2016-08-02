//
//  SecondModel.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/25.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecondModel : NSObject
@property (nonatomic, copy)NSString *name_zh_cn;
@property (nonatomic, copy)NSString *name_en;
@property (nonatomic, copy)NSString *image_url;
@property (nonatomic, retain)NSNumber *ID;

+ (instancetype)secondModel:(NSDictionary *)dic;
@end
