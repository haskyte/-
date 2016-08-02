//
//  TripsModel.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/20.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TripsModel : NSObject

@property (nonatomic, copy) NSString *tripsID;
@property (nonatomic, copy) NSString *photoImage;
@property (nonatomic, copy) NSString *nameLabel;
@property (nonatomic, copy) NSString *startDate;
@property (nonatomic, copy) NSString *days;
@property (nonatomic, copy) NSString *photoCount;

+ (instancetype)tripsModelWithDic:(NSDictionary *)dic;
@end
