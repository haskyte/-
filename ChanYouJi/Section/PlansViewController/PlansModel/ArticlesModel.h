//
//  ArticlesModel.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/27.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticlesModel : NSObject
@property (nonatomic, retain)NSNumber *articlesID;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *image_url;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *destination_id;
+ (instancetype)articlesModel:(NSDictionary *)dic;
@end
