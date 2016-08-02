//
//  ArticlesModel.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/27.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "ArticlesModel.h"

@implementation ArticlesModel
- (void)dealloc {
    self.name = nil;
    self.image_url = nil;
    self.title = nil;
    self.articlesID = nil;
    self.destination_id = nil;
    [super dealloc];
}

+ (instancetype)articlesModel:(NSDictionary *)dic {
    ArticlesModel *articlesModel = [[ArticlesModel alloc] init];
    articlesModel.name = dic[@"name"];
    articlesModel.image_url = dic[@"image_url"];
    articlesModel.title = dic[@"title"];
    articlesModel.articlesID = dic[@"id"];
    articlesModel.destination_id = dic[@"destination_id"];
    return [articlesModel autorelease];
}


@end
