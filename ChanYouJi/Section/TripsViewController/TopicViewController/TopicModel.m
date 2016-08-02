//
//  TopicModel.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/19.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "TopicModel.h"

@implementation TopicModel

+ (instancetype)topicModelWithdic:(NSDictionary *)dic{
    TopicModel *topicModel = [[[TopicModel alloc] init]autorelease];
    topicModel.topicID = [dic objectForKey:@"id"];
    topicModel.name = dic[@"name"];
    topicModel.title = dic[@"title"];
    topicModel.imageURL = dic[@"image_url"];
    return topicModel;
}

- (void)dealloc
{
    self.topicID = nil;
    self.name = nil;
    self.title = nil;
    self.imageURL = nil;
    [super dealloc];
}



@end
