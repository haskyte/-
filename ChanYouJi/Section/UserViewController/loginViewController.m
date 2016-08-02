//
//  loginViewController.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/19.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "loginViewController.h"

@interface loginViewController ()<UITextFieldDelegate>

@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    // Do any additional setup after loading the view.
    
    UITextField * mailbField = [[UITextField alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50)];
    mailbField.placeholder = @"邮箱";
    mailbField.borderStyle = UITextBorderStyleRoundedRect;
    mailbField.delegate = self;
    [self.view addSubview:mailbField];
    [mailbField release];
    
    UITextField * codeField = [[UITextField alloc]initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, 50)];
    codeField.placeholder = @"密码";
    codeField.secureTextEntry = YES;
    codeField.returnKeyType = UIReturnKeyGo;
    codeField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:codeField];
    [codeField release];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return  YES;
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
