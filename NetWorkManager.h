//
//  NetWorkManager.h
//  NetWorking
//
//  Created by lanouhn on 15/6/18.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>

// 定义一个成功回调
typedef void(^successBlock) (id obj);
// 定义一个失败回调
typedef void(^failBlock) ();

@protocol NetWorkManagerDelegate <NSObject>

@optional
// 请求成功
- (void)getDataSuccessWithObject:(id)obj;
// 请求失败

- (void)getDataFail;

@end

@interface NetWorkManager : NSObject <NSURLConnectionDataDelegate,NSURLConnectionDelegate>

@property (nonatomic, assign)id <NetWorkManagerDelegate> delegate;

// 单例初始化方法
+ (instancetype)shareWithManager;

// 根据接口请求数据
- (void)getDataWithURL:(NSString *)URL
                Method:(NSString *)method
            Parameters:(NSMutableDictionary *)parameters
                  Kind:(NSInteger)kind
      OrContainChinese:(BOOL)orContainChinese
               success:(successBlock)success
                  fail:(failBlock)fail;



@end
