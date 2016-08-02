//
//  Contect.m
//  LessonDataBase
//
//  Created by caizheyong on 15/6/6.
//  Copyright (c) 2015年 xiaocaicai111. All rights reserved.
//

#import "Contect.h"

@implementation Contect
- (void)dealloc {
    self.name = nil;
    self.money = nil;
    self.remark = nil;

    [super dealloc];
}
- (id)initWithName:(NSString *)name money:(NSString *)money remark:(NSString *)remark  {
    self = [super init];
    if (self) {
        self.name = name;
        self.money = money;
        self.remark = remark;

    }
    return self;
}
@end
