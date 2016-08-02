//
//  DataBaseHelper.m
//  LessonDataBase
//
//  Created by caizheyong on 15/6/6.
//  Copyright (c) 2015年 xiaocaicai111. All rights reserved.
//

#import "DataBaseHelper.h"
#import "DataBaseManager.h"
#import "Contect.h"
@implementation DataBaseHelper
//实现创建单例对象的操作
+ (DataBaseHelper *)shareWithDataBaseHelper {
    static DataBaseHelper *helper = nil;
    if (helper == nil) {
        helper = [[DataBaseHelper alloc]init];
    }
    return helper;
}
//保存联系人信息
- (void)saveContectInforWithName:(NSString *)name money:(NSString *)money remark:(NSString *)remark  {
    //创建联系人对象
    Contect *contect = [[[Contect alloc]initWithName:name money:money remark:remark]autorelease];
    //联系人信息处理
    [self dealContectInfor:contect];
    //将该联系人存储到数据库中
    [self createTableOfContect];//创建联系人列表
    [self saveContectInforToDataBase:contect];//存储联系人
}
//处理一个联系人数据
- (void)dealContectInfor:(Contect *)contect {
    //获取联系人姓名首字母
    NSString *firstLetter = [self getFirstLetterOfName:contect.name];
    if (![self.firstLetters containsObject:firstLetter]) {
        //添加联系人姓名首字母
        [self.firstLetters addObject:firstLetter];
        //创建数组存储该联系人
        NSMutableArray *contects = [NSMutableArray arrayWithCapacity:0];
        [contects addObject:contect];
        //将该分区数据存储到字典中
        [self.contectsDic setObject:contects forKey:firstLetter];
    }else {
        //从对应的字典中取出对应的分区数据
        NSMutableArray *contects = [self.contectsDic objectForKey:firstLetter];
        [contects addObject:contect];
    }
    //对首字母进行升序排序
    [self.firstLetters sortUsingSelector:@selector(compare:)];
}
//获取联系人姓名首字母
- (NSString *)getFirstLetterOfName:(NSString *)name {
    //将name转换成可变字符串
    NSMutableString *name1 = [name mutableCopy];
    //将中文的汉字转换成带音调的拼音
    CFStringTransform((CFMutableStringRef)name1, nil, kCFStringTransformMandarinLatin, NO);
    //将带音调的拼音转换成不带音调的拼音
    CFStringTransform((CFMutableStringRef)name1, nil, kCFStringTransformStripDiacritics, NO);
    //拼音首字母大写
    NSString *name2 = [name1 capitalizedString];
    return [name2 substringToIndex:1];

}
- (void)pressButtonWithAlertView {
    // 警告框
    //(1)创建
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"消费事项不能为空!" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    //(2)显示
    [alertView show];
    //(3)释放
    [alertView release];
}

//在数据库中创建对应的表
- (void)createTableOfContect {
    //1:获取指令集
    sqlite3_stmt *stmt = [DataBaseHelper createTableOfDataBase];
    //2:指定SQL语句中参数－?
    //3:执行SQL语句
    if (sqlite3_step(stmt) == SQLITE_DONE) {
        NSLog(@"数据库联系人列表创建成功");
    }
}
//将联系人信息存储到数据库中
- (void)saveContectInforToDataBase:(Contect *)contect {
    //1获得指令集
    sqlite3_stmt *stmt = [DataBaseHelper createInsertIntoDataBase];
    //2:指定SQL语句中的参数?（根据情况使用）
    /*
     sqlite3_bind_text
     参数1:要执行的指令集
     参数2:代表需要指定的参数是第几个参数
     参数3:指要指定的参数的值
     参数4:要指定的值的大小
     参数5:保留参数
     */
    sqlite3_bind_text(stmt, 1, [contect.name UTF8String], -1, nil);
    sqlite3_bind_text(stmt, 2, [contect.money UTF8String], -1, nil);
    sqlite3_bind_text(stmt, 3, [contect.remark UTF8String], -1, nil);
//    sqlite3_bind_text(stmt, 4, [contect.phone UTF8String], -1, nil);
//    sqlite3_bind_text(stmt, 5, [contect.motto UTF8String], -1, nil);
    //将UIImage类型的数据转化为NSData类型的数据
//    NSData *photoData = UIImagePNGRepresentation(contect.photo);
//    sqlite3_bind_blob(stmt, 6, photoData.bytes, (int)photoData.length, nil);
    //执行SQL语句
    //判断SQL语句究竟有没有执行完毕
    if (sqlite3_step(stmt) ==SQLITE_DONE) {
        //释放数据库资源，关闭数据库
        sqlite3_finalize(stmt);
        [DataBaseManager closeDataBase];
        NSLog(@"数据插入成功!");
    }
}
/***********删除联系人*********/
- (void)deleteInforOfContect:(NSIndexPath *)indexPath {
    //查找要删除的联系人信息
    Contect *contect = [self findContectPerson:indexPath];
    //删除数据库中的数据
    [self deleteInforOfDataBase:contect];
    //删除联系人信息
    [self deleteInterfaceData:indexPath];
}
//查找联系人信息
- (Contect *)findContectPerson:(NSIndexPath *)indexPath {
    //查找到点击的是哪一个分区
    NSString *firstLetter = [self.firstLetters objectAtIndex:indexPath.section];
    //取出来该分区的所有联系人
    NSMutableArray *contects = [self.contectsDic objectForKey:firstLetter];
    //取出数组中对应位置的联系人
    return [contects objectAtIndex:indexPath.row];
}
//删除界面数据
- (void)deleteInterfaceData:(NSIndexPath *)indexPath {
    //查找到点击的是哪一个分区
    NSString *firstLetter = [self.firstLetters objectAtIndex:indexPath.section];
    //取出来该分区的所有联系人
    NSMutableArray *contects = [self.contectsDic objectForKey:firstLetter];
    if (contects.count > 1) {
        [contects removeObjectAtIndex:indexPath.row];
    }else {
        //删除分区数据
        [self.firstLetters removeObjectAtIndex:indexPath.section];
        //移除字典中对应的分区数据
        [self.contectsDic removeObjectForKey:firstLetter];
    }
    
}
//删除数据库中的数据
- (void)deleteInforOfDataBase:(Contect *)contect {
    //1:获取指令集
    sqlite3_stmt *stmt = [DataBaseHelper deleteOfDataBase];
    //2指定SQL语句中的参数 －?
   sqlite3_bind_text(stmt, 1, [contect.name UTF8String], -1, nil);
    //3:执行SQL语句
    if (sqlite3_step(stmt) == SQLITE_DONE) {
        //释放数据库资源，关闭数据库
        sqlite3_finalize(stmt);
        [DataBaseManager closeDataBase];
        NSLog(@"联系人删除成功!");
    }
}
/********查询联系人信息********/
- (void)findAllContect {
    //清空临时容器中的数据
    [self.firstLetters removeAllObjects];
    [self.contectsDic removeAllObjects];
    
    [self createTableOfContect];
    //从数据库中查询所有联系人
    //1:获得指令集
    sqlite3_stmt *stmt = [DataBaseHelper selectOfDataBase];
    //2:指定SQL语句的参数
    //3:执行SQL语句
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        const unsigned char *name = sqlite3_column_text(stmt, 0);
        const unsigned char *money = sqlite3_column_text(stmt, 1);
        const unsigned char *remark = sqlite3_column_text(stmt, 2);
//        const unsigned char *phone = sqlite3_column_text(stmt, 3);
//        const unsigned char *motto = sqlite3_column_text(stmt, 4);
//        //返回数据库中二进制数据的字节大小
//        const void *photo = sqlite3_column_blob(stmt, 5);
//        //返回数据库中二进制数据的长度
//       int length = sqlite3_column_bytes(stmt, 5);
        
        NSString *nameC = [NSString stringWithUTF8String:(const char *)name];
        NSString *moneyC = [NSString stringWithUTF8String:(const char *)money];
        NSString *remarkC = [NSString stringWithUTF8String:(const char *)remark];
//        NSString *phoneC = [NSString stringWithUTF8String:(const char *)phone];
//        NSString *mottoC = [NSString stringWithUTF8String:(const char *)motto];
//        NSData *photoC = [NSData dataWithBytes:photo length:length];
        //创建联系人对象
        Contect *contect = [[Contect alloc]initWithName:nameC money:moneyC remark:remarkC];
        [self dealContectInfor:contect];
    }
    //释放数据库的资源和关闭数据库
    sqlite3_finalize(stmt);
    [DataBaseManager closeDataBase];
}
//提供接口实现数据的更新操作
- (void)updateOfDataBase:(Contect *)contect {
    //获得需要操作的指令集
    sqlite3_stmt *stmt = [DataBaseHelper updateOfDataBase];
    //指定SQL语句中的参数的值
    sqlite3_bind_text(stmt, 1, [contect.name UTF8String], -1, nil);
    sqlite3_bind_text(stmt, 2, [contect.money UTF8String], -1, nil);
    sqlite3_bind_text(stmt, 3, [contect.remark UTF8String], -1, nil);
//    sqlite3_bind_text(stmt, 4, [contect.phone UTF8String], -1, nil);
//    sqlite3_bind_text(stmt, 5, [contect.motto UTF8String], -1, nil);
//    NSData *photoData = UIImagePNGRepresentation(contect.photo);
//    sqlite3_bind_blob(stmt, 6, photoData.bytes, (int)photoData.length, nil);
//    sqlite3_bind_text(stmt, 7, [contect.phone UTF8String], -1, nil);
    //执行对应的指令集
    if (sqlite3_step(stmt) == SQLITE_DONE) {
        NSLog(@"数据更新完成");
        //释放数据库占用的资源同时关闭数据库
        sqlite3_finalize(stmt);
        [DataBaseManager closeDataBase];
    }
}


//初始化存储联系人的首字母的数组
- (NSMutableArray *)firstLetters {
    if (_firstLetters == nil) {
        self.firstLetters = [NSMutableArray arrayWithCapacity:0];
    }
    return _firstLetters;
}
//初始化存储联系人的字典
- (NSMutableDictionary *)contectsDic {
    if (_contectsDic == nil) {
        self.contectsDic = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _contectsDic;
}

@end


@implementation DataBaseHelper(CreateStement)
//创建为数据库创建表的指令集
+ (sqlite3_stmt *)createTableOfDataBase {
    //1:获取数据库的指针
    sqlite3 *db = [DataBaseManager openDataBase];
    //2创建指令集对象(指令集里面存储的是对数据库操作的相关指令)
    sqlite3_stmt *stmt = nil;
    //3:创建SQL语句
    NSString *createSQL = @"create table if not exists Contects(con_name text primary key,con_money text,con_remark text)";
    //4检测SQL语句是否正确
    /*
     sqlite3_prepare_v2方法中参数的含义:
     参数1:操作的数据库
     参数2:将要执行的SQL语句
     参数3:SQL语句的长度，－1代表无限长
     参数4:代表将要使用的指令集
     参数5:保留参数，一般为nil
     检测SQL语句是否正确，同时将数据库和SQL语句写入到指令集中
     */
    int flag = sqlite3_prepare_v2(db, [createSQL UTF8String], -1, &stmt, nil);
    NSLog(@"%d",flag);
    //5:SQLITE_OK:代表SQL语句正确并且成功写入指令集
    if (SQLITE_OK == flag) {
        NSLog(@"表创建成功!");
        //返回指令集
        return stmt;
    }
    return nil;
}
//创建向数据库中插入数据的指令集
+ (sqlite3_stmt *)createInsertIntoDataBase {
    //1获得数据库指针
    sqlite3 *db = [DataBaseManager openDataBase];
    //2创建指令集对象
    sqlite3_stmt *stmt = nil;
    //3:创建SQL语句(?:告诉系统现在我还不知道这里将要放置何种数据)
    NSString *createSQL = @"insert into Contects(con_name,con_money,con_remark) values(?,?,?)";
    //4:检测SQL语句是否正确，并且写入指令集
    int flag =  sqlite3_prepare_v2(db, [createSQL UTF8String], -1, &stmt, nil);
    if (SQLITE_OK == flag) {
        NSLog(@"数据插入成功");
        return stmt;
    }
    return nil;
}
//创建更新数据库中数据的指令集
+ (sqlite3_stmt *)updateOfDataBase {
    //1获得数据库指针
    sqlite3 *db = [DataBaseManager openDataBase];
    //2创建指令集对象
    sqlite3_stmt *stmt = nil;
    //3:创建SQL语句(?:告诉系统现在我还不知道这里将要放置何种数据)
    NSString *createSQL = @"update Contects set con_name = ?,con_money = ?,con_remark = ?  where con_name = ?";
    //4:检测SQL语句是否正确，并且写入指令集
    int flag =  sqlite3_prepare_v2(db, [createSQL UTF8String], -1, &stmt, nil);
    if (SQLITE_OK == flag) {
        NSLog(@"数据插入成功");
        return stmt;
    }
    return nil;
}
//创建删除数据库中数据的指令集
+ (sqlite3_stmt *)deleteOfDataBase {
    //1获得数据库指针
    sqlite3 *db = [DataBaseManager openDataBase];
    //2创建指令集对象
    sqlite3_stmt *stmt = nil;
    //3:创建SQL语句(?:告诉系统现在我还不知道这里将要放置何种数据)
    NSString *createSQL = @"delete  from Contects where con_name = ?";
    //4:检测SQL语句是否正确，并且写入指令集
    int flag =  sqlite3_prepare_v2(db, [createSQL UTF8String], -1, &stmt, nil);
    if (SQLITE_OK == flag) {
        NSLog(@"数据插入成功");
        return stmt;
    }
    return nil;
}
//创建查询数据库数据的指令集
+ (sqlite3_stmt *)selectOfDataBase {
    //1获得数据库指针
    sqlite3 *db = [DataBaseManager openDataBase];
    //2创建指令集对象
    sqlite3_stmt *stmt = nil;
    //3:创建SQL语句(?:告诉系统现在我还不知道这里将要放置何种数据)
    NSString *createSQL = @"select * from Contects";
    //4:检测SQL语句是否正确，并且写入指令集
    int flag =  sqlite3_prepare_v2(db, [createSQL UTF8String], -1, &stmt, nil);
    if (SQLITE_OK == flag) {
        NSLog(@"数据查询成功");
        return stmt;
    }
    return nil;
}
@end

