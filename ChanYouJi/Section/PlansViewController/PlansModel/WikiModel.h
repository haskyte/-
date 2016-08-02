//
//  WikiModel.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WikiModel : NSObject
@property (nonatomic, copy)NSString *title;
@property (nonatomic, retain)NSNumber *pagesID;
+ (instancetype)wikiModel:(NSDictionary *)dic;
@end
