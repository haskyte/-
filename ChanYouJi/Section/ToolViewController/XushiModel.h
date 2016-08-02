//
//  XushiModel.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XushiModel : NSObject

//国家
@property (nonatomic , copy) NSString * groupCountry_id;
@property (nonatomic , copy) NSString * groupCountry_name;
@property (nonatomic , retain) NSMutableArray * groupChildren;

//城市
@property (nonatomic , copy) NSString * country_id;
@property (nonatomic , copy) NSString * country_name;


+ (XushiModel *) getDataSourceWithDic : (NSDictionary *) dic;
+ (XushiModel *) getDataModelWithDic : (NSDictionary *) dic;

@end
