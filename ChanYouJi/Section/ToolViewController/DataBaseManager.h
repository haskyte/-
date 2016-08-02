//
//  DataBaseManager.h
//  LessonDataBase
//
//  Created by caizheyong on 15/6/6.
//  Copyright (c) 2015年 xiaocaicai111. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
/*
 DataBaseManager用来打开和关闭数据库
 */
@interface DataBaseManager : NSObject
//打开数据库
+ (sqlite3 *)openDataBase;
//关闭数据库
+ (void)closeDataBase;
@end
