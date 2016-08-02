//
//  SearchModel.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchModel : NSObject

@property (nonatomic, copy)NSString *nameId;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *destinationCount;

+ (instancetype)searchModelWithDictionary:(NSDictionary *)dictionary;

@end
