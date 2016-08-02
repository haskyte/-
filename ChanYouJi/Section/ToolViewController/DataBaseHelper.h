//
//  DataBaseHelper.h
//  LessonDataBase
//
//  Created by caizheyong on 15/6/6.
//  Copyright (c) 2015年 xiaocaicai111. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <sqlite3.h>
@class Contect;
@interface DataBaseHelper : NSObject
@property (nonatomic, retain)NSMutableArray *firstLetters;//用来存储姓名首字母，作为联系人的分组数据
@property (nonatomic, retain)NSMutableDictionary *contectsDic;//存储所有的联系人对象

//提供接口实现单例的创建
+ (DataBaseHelper *)shareWithDataBaseHelper;

//提供接口保存数据
- (void)saveContectInforWithName:(NSString *)name
                          money:(NSString *)money
                          remark:(NSString *)remark;

//提供接口实现对联系人的删除操作
- (void)deleteInforOfContect:(NSIndexPath *)indexPath;
//提供接口查找联系人
- (Contect *)findContectPerson:(NSIndexPath *)indexPath;
//提供接口查询所有联系人
- (void)findAllContect;
//提供接口实现数据的更新操作
- (void)updateOfDataBase:(Contect *)contect;

@end

//创建对数据库操作的指令集
@interface DataBaseHelper(CreateStement)
//创建为数据库创建表的指令集
+ (sqlite3_stmt *)createTableOfDataBase;
//创建向数据库中插入数据的指令集
+ (sqlite3_stmt *)createInsertIntoDataBase;
//创建更新数据库中数据的指令集
+ (sqlite3_stmt *)updateOfDataBase;
//创建删除数据库中数据的指令集
+ (sqlite3_stmt *)deleteOfDataBase;
//创建查询数据库数据的指令集
+ (sqlite3_stmt *)selectOfDataBase;
@end






