//
//  SearchModel.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel

- (void)dealloc
{
    self.nameId = nil;
    self.name = nil;
    self.destinationCount = nil;
    [super dealloc];
}

+ (instancetype)searchModelWithDictionary:(NSDictionary *)dictionary{
    SearchModel *searchModel = [[[SearchModel alloc] init]autorelease];
    searchModel.nameId = dictionary[@"id"];
    searchModel.name = dictionary[@"name"];
    searchModel.destinationCount = dictionary[@"destination_trips_count"];
    return searchModel;
}
@end
