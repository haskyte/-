//
//  SecondThirdModel.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/29.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "SecondThirdModel.h"
#import "FourthThirdModel.h"
@implementation SecondThirdModel
- (void)dealloc {
    self.descriptionTitle = nil;
    [super dealloc];
}
- (NSMutableArray *)second {
    if (!_second) {
        self.second = [NSMutableArray array];
    }
    return _second;
}
+ (instancetype)secondThirdModel:(NSDictionary *)dic {
    SecondThirdModel *secondThird = [[SecondThirdModel alloc] init];
    secondThird.descriptionTitle = dic[@"description"];
    return [secondThird autorelease];
}


@end
