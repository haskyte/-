//
//  FourthThirdModel.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/29.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "FourthThirdModel.h"

@implementation FourthThirdModel
- (void)dealloc {
    self.photo_url = nil;
    self.array_photoUrl = nil;
    [super dealloc];
}



- (NSMutableArray *)array_photoUrl {
    if (!_array_photoUrl) {
        self.array_photoUrl = [NSMutableArray array];
    }
    return _array_photoUrl;
}



+ (instancetype)fourthThirdModel:(NSArray *)array {
    FourthThirdModel *fourth = [[FourthThirdModel alloc] init];
    NSMutableArray *arr = [@[] mutableCopy];
    for (NSDictionary *dic in array) {
        [arr addObject:dic[@"photo_url"]];
        fourth.countNumber = array.count;
    }
    [fourth.array_photoUrl addObjectsFromArray:arr];
   
    return fourth;
}


@end
