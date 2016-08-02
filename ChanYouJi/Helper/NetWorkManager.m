//
//  NetWorkManager.m
//  NetWorking
//
//  Created by lanouhn on 15/6/18.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "NetWorkManager.h"

@interface NetWorkManager ()

@property (nonatomic, retain)NSMutableData *data;
@property (nonatomic, copy) successBlock successBlock;
@property (nonatomic, copy) failBlock failBlock;
@property (nonatomic) NSInteger kind;

@end


@implementation NetWorkManager


//
+ (instancetype)shareWithManager{
    NetWorkManager *netWork = [[[NetWorkManager alloc] init]autorelease];
    
    return netWork;
}

- (void)getDataWithURL:(NSString *)URL Method:(NSString *)method Parameters:(NSMutableDictionary *)parameters Kind:(NSInteger)kind OrContainChinese:(BOOL)orContainChinese{
    self.kind = kind;
    // 创建URL
    NSURL *url = [NSURL URLWithString:[URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    // 创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // 设置请求方式
    if ([method isEqualToString:@"POST"]) {
        request.HTTPMethod = method;
        // 设置请求体
        NSString *parameter = [self dealWithParamerers:parameters];
        [request setHTTPBody:[parameter dataUsingEncoding:NSUTF8StringEncoding]];
    }
    // 进行网络请求
    [NSURLConnection connectionWithRequest:request delegate:self];
}
// 处理POST
- (NSString *)dealWithParamerers:(NSMutableDictionary *)parameters{
    // 创建数组 存储固定格式的参数和参数对应的值
    NSMutableArray *parameterString = [NSMutableArray arrayWithCapacity:0];
    for (NSString *key in [parameters allKeys]) {
        // 将参数和对应的值 拼接成固定的格式
        NSString *parameterStr = [NSString stringWithFormat:@"%@ = %@",key,parameters[key]];
        [parameterString addObject:parameterStr];
    }
    return [parameterString componentsJoinedByString:@"&"];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    // 接收到响应 初始化data
    self.data = [NSMutableData dataWithCapacity:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    // 数据拼接
    [self.data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    // 数据解析
    id object = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:nil];
    // Block 回调
    self.successBlock(object);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    // 失败回调
    self.failBlock();
}

// Block 数据请求
- (void)getDataWithURL:(NSString *)URL Method:(NSString *)method Parameters:(NSMutableDictionary *)parameters Kind:(NSInteger)kind OrContainChinese:(BOOL)orContainChinese success:(successBlock)success fail:(failBlock)fail{
    [self getDataWithURL:URL Method:method Parameters:parameters Kind:kind OrContainChinese:orContainChinese];
    self.successBlock = success;
    self.failBlock = fail;
}






//Https
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
        //if ([trustedHosts containsObject:challenge.protectionSpace.host])
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]
             forAuthenticationChallenge:challenge];
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

@end
