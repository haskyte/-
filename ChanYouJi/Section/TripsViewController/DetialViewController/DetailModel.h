//
//  DetailModel.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/23.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *imageWidth;
@property (nonatomic, copy) NSString *imageHeight;
@property (nonatomic, copy) NSString *descriptionUserid;
@property (nonatomic, copy) NSString *imageDescription;
@property (nonatomic, copy) NSString *imageId;
@property (nonatomic, copy) NSString *tripId;
@property (nonatomic, copy) NSString *tripName;
@property (nonatomic, copy) NSString *userName;

+ (instancetype)detailModelWithDic:(NSDictionary *)dictionary;


@end
