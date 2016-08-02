//
//  WikiModel.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "WikiModel.h"

@implementation WikiModel
- (void)dealloc {
    self.title = nil;
    self.pagesID = nil;
    [super dealloc];
}
+ (instancetype)wikiModel:(NSDictionary *)dic {
    WikiModel *wiki = [[WikiModel alloc] init];
    wiki.title = dic[@"title"];
    wiki.pagesID = dic[@"id"];
    return [wiki autorelease];
}
@end
