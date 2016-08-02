//
//  FourthThirdModel.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/29.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FourthThirdModel : NSObject
@property (nonatomic, copy)NSString *photo_url;
@property (nonatomic)NSUInteger countNumber;
@property (nonatomic)NSUInteger index;
@property (nonatomic, retain)NSMutableArray *array_photoUrl;
+ (instancetype)fourthThirdModel:(NSArray *)array;
@end
