//
//  AddViewController.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/29.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "AddViewController.h"
#import "DataBaseHelper.h"


#define  WIDTH self.view.frame.size.width

@interface AddViewController ()<UITextFieldDelegate>


@property (nonatomic,retain)UITextField * nameField;
@property (nonatomic,retain)UITextField * moneyField;
@property (nonatomic,retain)UITextView * textView;
@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    
    self.navigationItem.title = @"新建账单";
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(baoEvent:)];
    
    [self creatAddView];
   
}
//保存记账信息
- (void)baoEvent:(UIBarButtonItem *)item {
    if (self.nameField.text.length == 0) {
        [self pressButtonWithAlertView];
    }else{
        //创建DataBaseHelper对象实现数据保存
        DataBaseHelper *helper = [DataBaseHelper shareWithDataBaseHelper];
        [helper saveContectInforWithName:self.nameField.text money:self.moneyField.text remark:self.textView.text ];
        //返回到我们的联系人界面
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)pressButtonWithAlertView {
    // 警告框
    //(1)创建
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"消费事项不能为空哦" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    //(2)显示
    [alertView show];
    //(3)释放
    [alertView release];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)creatAddView {
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 100,80, 30)];
    nameLabel.text = @"消费事项";
    //nameLabel.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:nameLabel];
    
    UITextField * nameField = [[UITextField alloc]initWithFrame:CGRectMake(120, 100, WIDTH/2, 30)];
    self.nameField = nameField;
    self.nameField.delegate = self;
    self.nameField.placeholder = @"必填";
//    nameField.backgroundColor = [UIColor redColor];
    self.nameField.borderStyle = UITextBorderStyleRoundedRect;
    self.nameField.layer.cornerRadius = 10;

    [self.view addSubview:nameField];
    //--------------------------------------------
    UILabel * moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 180, 80, 30)];
    moneyLabel.text = @"花费金额";
    //moneyLabel.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:moneyLabel];
    
    UITextField * moneyField = [[UITextField alloc]initWithFrame:CGRectMake(120, 180, WIDTH/2, 30)];
    self.moneyField = moneyField;
    self.moneyField.delegate = nil;
    //moneyField.backgroundColor = [UIColor redColor];
    self.moneyField.borderStyle = UITextBorderStyleRoundedRect;
    self.moneyField.layer.cornerRadius = 10;
    [self.view addSubview:moneyField];
    //---------------------------------------------
    UILabel * detailsLabel= [[UILabel alloc]initWithFrame:CGRectMake(40, 260, 80, 30)];
    detailsLabel.text = @"备注";
    //detailsLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:detailsLabel];
    
    UITextView * textView= [[UITextView alloc]initWithFrame:CGRectMake(20, 300, WIDTH-40, 100)];
    self.textView = textView;
   // textView.backgroundColor = [UIColor greenColor];
    self.textView.layer.cornerRadius = 10;
    [self.view addSubview:textView];
    
    [nameLabel release];
    [nameField release];
    [moneyLabel release];
    [moneyField release];
    [detailsLabel release];
    [textView release];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
