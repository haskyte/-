//
//  ThirdThirdModel.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/29.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThirdThirdModel : NSObject

@property (nonatomic, copy)NSString *user_name;
@property (nonatomic, copy)NSString *start_date;
@property (nonatomic, copy)NSString *user_id;
+ (instancetype)thirdThirdModel:(NSDictionary *)dic;
@end
