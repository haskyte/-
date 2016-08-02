//
//  ProposeViewController.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "ProposeViewController.h"

#define SCREENWIDE [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
@interface ProposeViewController ()

@end

@implementation ProposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    self.navigationItem.title = @"给开发者提意见";
    [self creatTextView];
    
}

- (void)creatTextView{
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 74, SCREENWIDE - 20 , 100)];
    textView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textView];
    [textView release];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 184, SCREENWIDE - 20, 30)];
    textField.backgroundColor = [UIColor whiteColor];
    textField.placeholder = @"Email或者QQ号";
    textField.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:textField];
    [textField release];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame =CGRectMake(10, 234, SCREENWIDE- 20, 30);
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
// 保存操作

- (void)saveAction:(UIButton *)button{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"保存成功" message:nil delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil];
    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
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
