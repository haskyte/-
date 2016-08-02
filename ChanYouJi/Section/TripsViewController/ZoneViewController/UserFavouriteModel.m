//
//  UserFavouriteModel.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/27.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "UserFavouriteModel.h"

@implementation UserFavouriteModel

- (void)dealloc
{
    self.photoDescription = nil;
    self.photoHeight = nil;
    self.photoUrl = nil;
    self.photoWidth = nil;
    self.photoID = nil;
    [super dealloc];
}

+ (instancetype)favouriteModelWithDictionary:(NSDictionary *)dictionary{
    UserFavouriteModel *favouriteModel = [[[UserFavouriteModel alloc] init]autorelease];
    favouriteModel.photoID = dictionary[@"id"];
    favouriteModel.photoDescription = dictionary[@"description"];
    favouriteModel.photoWidth = dictionary[@"width"];
    favouriteModel.photoHeight = dictionary[@"height"];
    favouriteModel.photoUrl = dictionary[@"photo_url"];
    return favouriteModel;
}



@end
