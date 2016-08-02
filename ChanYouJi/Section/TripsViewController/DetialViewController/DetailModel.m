//
//  DetailModel.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/23.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "DetailModel.h"

@implementation DetailModel

- (void)dealloc
{
    self.title = nil;
    self.imageUrl = nil;
    self.imageWidth = nil;
    self.imageHeight = nil;
    self.descriptionUserid = nil;
    self.imageDescription = nil;
    self.imageId = nil;
    self.tripId = nil;
    self.tripName = nil;
    self.userName = nil;
    [super dealloc];
}

+ (instancetype)detailModelWithDic:(NSDictionary *)dictionary{
    DetailModel *detailModel = [[[DetailModel alloc] init]autorelease];
    detailModel.title = dictionary[@"title"];
    detailModel.imageUrl = dictionary[@"image_url"];
    detailModel.imageWidth = dictionary[@"image_width"];
    detailModel.imageHeight = dictionary[@"image_height"];
//    detailModel.descriptionUserid = dictionary[@""];
    detailModel.imageDescription = dictionary[@"description"];
    detailModel.imageId = dictionary[@"note"][@"id"];
    detailModel.tripId = dictionary[@"note"][@"trip_id"];
    detailModel.tripName = dictionary[@"note"][@"trip_name"];
    detailModel.userName = dictionary[@"note"][@"user_name"];
    return detailModel;
}


@end
