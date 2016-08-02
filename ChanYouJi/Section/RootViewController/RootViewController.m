//
//  RootViewController.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/17.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "RootViewController.h"
#import "TripsViewController.h"
#import "PlansViewController.h"
#import "ToolViewController.h"
//#import "UserViewController.h"
//#import "DownLoadViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 增加导航控制器和视图控制器
    
    TripsViewController *tripsVC = [[TripsViewController alloc] init];
    UINavigationController *tripsNC = [[UINavigationController alloc] initWithRootViewController:tripsVC];
    
    PlansViewController *plansVC = [[PlansViewController alloc] init];
    UINavigationController *plansNC = [[UINavigationController alloc] initWithRootViewController:plansVC];
    
    ToolViewController *toolVC = [[ToolViewController alloc] init];
    UINavigationController *toolNC = [[UINavigationController alloc] initWithRootViewController:toolVC];
    
//    UserViewController *userVC = [[UserViewController alloc] init];
//    UINavigationController *userNC = [[UINavigationController alloc] initWithRootViewController:userVC];
//
//    DownLoadViewController *downLoadVC = [[DownLoadViewController alloc] init];
//    UINavigationController *downLoadNC = [[UINavigationController alloc] initWithRootViewController:downLoadVC];
    
    self.viewControllers = @[tripsNC,plansNC,toolNC];
    
    // 导航控制器的颜色
    tripsNC.navigationBar.barTintColor = [UIColor colorWithRed:0 green:150/255.0 blue:1.0 alpha:1];
    plansNC.navigationBar.barTintColor = [UIColor colorWithRed:0 green:150/255.0 blue:1.0 alpha:1];
    toolNC.navigationBar.barTintColor = [UIColor colorWithRed:0 green:150/255.0 blue:1.0 alpha:1];
//    userNC.navigationBar.barTintColor = [UIColor colorWithRed:0 green:150/255.0 blue:1.0 alpha:1];
//    downLoadNC.navigationBar.barTintColor = [UIColor colorWithRed:0 green:150/255.0 blue:1.0 alpha:1];
    // 标签控制器颜色
    self.tabBar.barTintColor = [UIColor whiteColor];
    // 标签控制器图片
//    userNC.tabBarItem.image = [UIImage imageWithCGImage:[UIImage imageNamed:@"TabBarIconMy"].CGImage scale:2 orientation:UIImageOrientationUp];
    toolNC.tabBarItem.image = [UIImage imageWithCGImage:[UIImage imageNamed:@"TabBarIconToolbox"].CGImage scale:2 orientation:UIImageOrientationUp];
    tripsNC.tabBarItem.image = [UIImage imageWithCGImage:[UIImage imageNamed:@"TabBarIconFeatured"].CGImage scale:2 orientation:UIImageOrientationUp];
    plansNC.tabBarItem.image = [UIImage imageWithCGImage:[UIImage imageNamed:@"TabBarIconDestination"].CGImage scale:2 orientation:UIImageOrientationUp];
//    downLoadNC.tabBarItem.image = [UIImage imageWithCGImage:[UIImage imageNamed:@"TabBarIconOffline"].CGImage scale:2 orientation:UIImageOrientationUp];
    
    toolNC.tabBarItem.title = @"工具箱";
//    userNC.tabBarItem.title = @"我的";
    plansNC.tabBarItem.title = @"攻略";
//    downLoadNC.tabBarItem.title = @"下载";
    
    [tripsVC release];
    [tripsNC release];
    [plansVC release];
    [plansNC release];
    [toolVC release];
    [toolNC release];
//    [userVC release];
//    [userNC release];
//    [downLoadVC release];
//    [downLoadNC release];
    
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
