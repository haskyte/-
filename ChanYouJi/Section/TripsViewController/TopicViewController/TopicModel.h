//
//  TopicModel.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/19.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicModel : NSObject

@property (nonatomic, copy) NSString *topicID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, copy) NSString *title;

+ (instancetype)topicModelWithdic:(NSDictionary *)dic;

@end
