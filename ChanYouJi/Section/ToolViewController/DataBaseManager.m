//
//  DataBaseManager.m
//  LessonDataBase
//
//  Created by caizheyong on 15/6/6.
//  Copyright (c) 2015年 xiaocaicai111. All rights reserved.
//

#import "DataBaseManager.h"
@implementation DataBaseManager
static sqlite3 *sqlite = nil;
//打开数据库
+ (sqlite3 *)openDataBase {
    if (sqlite != nil) {
        return sqlite;
    }
    //1:获得数据库所在的路径
    NSString *dataBasePath = [self getDataBasePath];
    //打开数据库(UTF8String:将OC类型的字符串对象转变为C语言的字符串对象)
    sqlite3_open([dataBasePath UTF8String], &sqlite);
    NSLog(@"%@",dataBasePath);
    return sqlite;
}
//关闭数据库
+ (void)closeDataBase {
    //关闭数据库
    sqlite3_close(sqlite);
}
//获取数据库所在的路径
+ (NSString *)getDataBasePath {
    //获得Documents文件夹的路径
    NSString *documentPth = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return [documentPth stringByAppendingPathComponent:@"Contect.sqlite"];
}
@end
