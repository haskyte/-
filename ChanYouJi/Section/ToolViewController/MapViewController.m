//
//  MapViewController.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/23.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()<UIWebViewDelegate>

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建UIWebView
    UIWebView * web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    web.delegate =self;
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[@"http://map.baidu.com/?newmap=1&ie=utf-8&s=s%26wd%3D中国地图" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
    
    
    [self.view addSubview:web];
    [web release];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
