//
//  UserViewController.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/17.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "UserViewController.h"
#import "loginViewController.h"
#define WIDTH self.view.frame.size.width
@interface UserViewController ()<UITextFieldDelegate>

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"我的旅行";
    
    //微博登陆按钮
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    leftButton.frame = CGRectMake(10, 100, (WIDTH-30)/2, 50);
    [leftButton setTitle:@"微博登陆" forState:UIControlStateNormal];
    leftButton.backgroundColor = [UIColor redColor];
    leftButton.layer.cornerRadius = 5;  //边角弧度
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:leftButton];
    [leftButton addTarget:self action:@selector(leftEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    //qq登陆按钮
    UIButton * rightButton= [UIButton buttonWithType:UIButtonTypeSystem];
    rightButton.frame = CGRectMake((WIDTH-30)/2+20, 100,(WIDTH-30)/2, 50);
    [rightButton setTitle:@"QQ登陆" forState:UIControlStateNormal];
    rightButton.backgroundColor = [UIColor blueColor];
    rightButton.layer.cornerRadius = 5;
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:rightButton];
    [rightButton addTarget:self action:@selector(rightEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/3, 200, WIDTH/3*2, 20)];
    label.text = @"或直接使用邮箱登陆";
    label.font = [UIFont systemFontOfSize:13];
    // label.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:label];
    [label release];
    
    UITextField * mailbField = [[UITextField alloc]initWithFrame:CGRectMake(0, 240,WIDTH, 50)];
    mailbField.placeholder = @"电子邮箱";
    mailbField.borderStyle = UITextBorderStyleRoundedRect;
    mailbField.delegate = self;
    [self.view addSubview:mailbField];
    [mailbField release];
    
    UITextField * codeField = [[UITextField alloc]initWithFrame:CGRectMake(0, 290,WIDTH, 50)];
    codeField.placeholder = @"密码";
    codeField.secureTextEntry = YES;
    codeField.borderStyle = UITextBorderStyleRoundedRect;
    codeField.delegate = self;
    [self.view addSubview:codeField];
    [codeField release];
    
    UIButton * loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    loginButton.frame = CGRectMake(WIDTH/2, 340,WIDTH/2, 40);
    [loginButton setTitle:@"没有账号？立即注册>" forState:UIControlStateNormal];
    [self.view addSubview:loginButton];
    [loginButton addTarget:self action:@selector(loginEvent:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)leftEvent:(UIButton *)button{
    
}

- (void)rightEvent:(UIButton *)button{
    
}

- (void)loginEvent:(UIButton *)button{
    loginViewController * loginVC= [[loginViewController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
    [loginVC release];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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

