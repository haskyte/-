//
//  TripsModel.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/20.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "TripsModel.h"

@implementation TripsModel

- (void)dealloc
{
    self.tripsID = nil;
    self.photoImage = nil;
    self.nameLabel = nil;
    self.startDate = nil;
    self.days = nil;
    self.photoCount = nil;
    [super dealloc];
}

+ (instancetype)tripsModelWithDic:(NSDictionary *)dic{
    TripsModel *tripsModel = [[[TripsModel alloc] init]autorelease];
    tripsModel.tripsID = dic[@"id"];
    tripsModel.photoImage = dic[@"front_cover_photo_url"];
    tripsModel.nameLabel = dic[@"name"];
    tripsModel.startDate = dic[@"start_date"];
    tripsModel.days = dic[@"days"];
    tripsModel.photoCount = dic[@"photos_count"];
    return tripsModel;
}


@end
