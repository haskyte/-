//
//  DetailsViewController.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/29.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "DetailsViewController.h"
#import "Contect.h"
#import "DataBaseHelper.h"

#define  WIDTH self.view.frame.size.width
@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (UITextField *)nameField {
    if (_nameField == nil) {
        self.nameField = [[UITextField alloc]initWithFrame:CGRectMake(120, 100, WIDTH/2, 30)];
        _nameField.text=self.nameStr;
        self.nameField.borderStyle = UITextBorderStyleRoundedRect;
//        self.nameField.layer.cornerRadius = 10;
    }
    return _nameField;
}
- (UITextField *)moneyField {
    if (_moneyField == nil) {
        self.moneyField = [[UITextField alloc]initWithFrame:CGRectMake(120, 180, WIDTH/2, 30)];
        _moneyField.text = self.moneyStr;
        _moneyField.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _moneyField;
}
- (UITextView *)textVIEW {
    if (_textVIEW == nil) {
        self.textVIEW = [[UITextView alloc]initWithFrame:CGRectMake(20, 300, WIDTH-40, 100)];
//        _textVIEW.text = self.hahah;
        _textVIEW.text = self.textStr;
        _textVIEW.backgroundColor = [UIColor whiteColor];
        _textVIEW.layer.cornerRadius = 10;
    }
    return _textVIEW;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    
    self.navigationItem.title = @"账单详细";
    self.navigationItem.rightBarButtonItem  = [[[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clickEvent:)]autorelease];
    [self.view addSubview:self.moneyField];
    [self.view addSubview:self.nameField];
    [self.view addSubview:self.textVIEW];

    [self creatAddView];
}

- (void)clickEvent:(UIBarButtonItem *)item {
    //执行数据更新
    //创建账单对象
    Contect *contect = [[Contect alloc]initWithName:self.nameField.text money:self.moneyField.text remark:self.textVIEW.text ];
    [[DataBaseHelper shareWithDataBaseHelper] updateOfDataBase:contect];
     [contect release];
    [self.navigationController popViewControllerAnimated:YES];
  
}



- (void)creatAddView {
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 100,80, 30)];
    nameLabel.text = @"消费事项";
        [self.view addSubview:nameLabel];

    //--------------------------------------------
    UILabel * moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 180, 80, 30)];
    moneyLabel.text = @"花费金额";
    [self.view addSubview:moneyLabel];

    //---------------------------------------------
    UILabel * detailsLabel= [[UILabel alloc]initWithFrame:CGRectMake(40, 260, 80, 30)];
    detailsLabel.text = @"备注";
    [self.view addSubview:detailsLabel];
    
    [nameLabel release];
    [moneyLabel release];
    [detailsLabel release];
}

//@property (nonatomic,retain)UITextField * nameField;
//@property (nonatomic,retain)UITextField * moneyField;
//@property (nonatomic,retain)UITextView * textVIEW;
//@property(nonatomic,copy)NSString * nameStr;
//@property (nonatomic,copy)NSString * moneyStr;
//@property (nonatomic,copy)NSString * textStr;
////创建账单对象
//@property (nonatomic, retain)Contect *contect;
- (void)dealloc{
    self.nameField = nil;
    self.moneyField = nil;
    self.textVIEW = nil;
    self.nameStr = nil;
    self.moneyStr = nil;
    self.textStr = nil;
    self.contect = nil;
    [super dealloc];
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
