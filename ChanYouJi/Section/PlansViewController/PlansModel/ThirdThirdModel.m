//
//  ThirdThirdModel.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/29.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "ThirdThirdModel.h"
#import "FourthThirdModel.h"

@implementation ThirdThirdModel
- (void)dealloc {
    
    self.user_name = nil;
    self.start_date = nil;
    self.user_id = nil;
    [super dealloc];
}

+ (instancetype)thirdThirdModel:(NSDictionary *)dic {
    ThirdThirdModel *thirdThirdModel = [[ThirdThirdModel alloc] init];
    thirdThirdModel.user_id = dic[@"user"][@"id"];
    thirdThirdModel.user_name = dic[@"user"][@"name"];
    thirdThirdModel.start_date = dic[@"start_date"];
    return [thirdThirdModel autorelease];
}


@end
