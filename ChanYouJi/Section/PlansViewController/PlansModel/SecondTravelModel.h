//
//  SecondTravelModel.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FourthThirdModel;
@interface SecondTravelModel : NSObject
@property (nonatomic, copy)NSString *secondID;
@property (nonatomic, copy)NSString *memo;
@property (nonatomic, retain)FourthThirdModel *fourthThirdModel;
+ (instancetype)secondTravelModel:(NSDictionary *)dic;
@end
