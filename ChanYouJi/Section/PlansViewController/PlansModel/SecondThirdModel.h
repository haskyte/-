//
//  SecondThirdModel.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/29.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecondThirdModel : NSObject
@property (nonatomic, copy)NSString *descriptionTitle;
@property (nonatomic,retain)NSMutableArray *second;
@property (nonatomic, copy)NSString *start_date;
@property (nonatomic, copy)NSString *userID;
@property (nonatomic, copy)NSString *userName;
+ (instancetype)secondThirdModel:(NSDictionary *)dic;
@end
