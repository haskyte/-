//
//  ForeignModel.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/24.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForeignModel : NSObject
@property (nonatomic, copy)NSString *name_zh_cn;
@property (nonatomic, copy)NSString *name_en;
@property (nonatomic, copy)NSString *ID;
@property (nonatomic, copy)NSString *poi_count;
@property (nonatomic, copy)NSString *image_url;
+ (instancetype)foreignModel:(NSDictionary *)dic;
@end