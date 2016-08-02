//
//  Contect.h
//  LessonDataBase
//
//  Created by caizheyong on 15/6/6.
//  Copyright (c) 2015年 xiaocaicai111. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Contect : NSObject
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *money;
@property (nonatomic, copy)NSString *remark;


//自定义初始化方法
- (id)initWithName:(NSString *)name
            money:(NSString *)money
            remark:(NSString *)remark;

@end
