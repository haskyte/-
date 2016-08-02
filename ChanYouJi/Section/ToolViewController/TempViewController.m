//
//  TempViewController.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/27.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "TempViewController.h"
#import "NetWorkManager.h"
#import "XushiModel.h"
#import "ShowTempModel.h"
#import "ToolViewController.h"
@interface TempViewController ()<NetWorkManagerDelegate>

@property (nonatomic , retain) NSMutableDictionary * dataDic;
@property (nonatomic , retain) NSMutableArray * dataArray;
@property (nonatomic , retain) NSMutableArray * ary;

@end

@implementation TempViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    self.ary  = [NSMutableArray arrayWithCapacity:0];
    self.dataDic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    
    self.mTableView = [[TQMultistageTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height)];
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    [self.view addSubview:self.mTableView];
    [self getNetWorkRequest];
    
}

- (void)getNetWorkRequest {
    [[NetWorkManager shareWithManager]getDataWithURL:@"https://chanyouji.com/api/wiki/destinations.json?page=1" Method:@"GET" Parameters:nil Kind:30
                                    OrContainChinese:NO success:^(id obj) {
                                        
                                        [self getDataSuccessWithObject:obj];
                                        
                                    } fail:^{
                                        
                                        [self getFail];
                                    }];
}
//请求成功
- (void)getDataSuccessWithObject:(id)obj {
    
    [obj enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj[@"destinations"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            XushiModel * model = [XushiModel getDataSourceWithDic:obj];
            [self.dataArray addObject:model];
            [model.groupChildren enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                XushiModel * nextModel = [XushiModel getDataModelWithDic:obj];
                [self.ary addObject:nextModel];
            }];
            [self.dataDic setObject:self.ary forKey:model.groupCountry_id];
            self.ary  = [NSMutableArray arrayWithCapacity:0];
        }];
    }];
    [self.mTableView reloadData];
    
    
}
//请求失败
- (void)getFail{
    NSLog(@"+++++请求失败");
}

- (void) cancelChoose : (UIBarButtonItem *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TQTableViewDataSource
//返回分区
- (NSInteger)numberOfSectionsInTableView:(TQMultistageTableView *)tableView
{
    return self.dataArray.count;
}
//返回分区行数
- (NSInteger)mTableView:(TQMultistageTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    XushiModel * model = self.dataArray[section];
    NSArray * ary = [self.dataDic objectForKey:model.groupCountry_id];
    return ary.count;
}

- (UITableViewCell *)mTableView:(TQMultistageTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"TQMultistageTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
//    UIView *view = [[UIView alloc] initWithFrame:cell.bounds] ;
//    view.backgroundColor = [UIColor lightGrayColor];
//    view.alpha = 0.2;
//    cell.backgroundView = view;
    
    XushiModel * model = self.dataArray[indexPath.section];
    NSArray * ary = [self.dataDic objectForKey:model.groupCountry_id];
    XushiModel * nextModel = ary[indexPath.row];
    cell.textLabel.text = nextModel.country_name;
    
    
    
    return cell;
}



////   ****- --- - --- - ****
//- (UIView *)mTableView:(TQMultistageTableView *)tableView openCellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 100)];
//    view.backgroundColor = [UIColor colorWithRed:187/255.0 green:206/255.0 blue:190/255.0 alpha:1];;
//
//    return view;
//}

#pragma mark - Table view delegate

- (CGFloat)mTableView:(TQMultistageTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)mTableView:(TQMultistageTableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
////三级cell
//- (CGFloat)mTableView:(TQMultistageTableView *)tableView heightForOpenCellAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 10;
//}

- (UIView *)mTableView:(TQMultistageTableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * control = [[UIView alloc] init];
    control.backgroundColor = [UIColor whiteColor];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 48, tableView.frame.size.width, 2)];
    view.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *label = [[UILabel alloc] init];      //标题
    
    XushiModel * model = self.dataArray[section];
    label.text = model.groupCountry_name;
    
    label.textColor = [UIColor blackColor];
    label.frame = CGRectMake(20, 0, 200, 40);
    [control addSubview:label];
    [control addSubview:view];
    return control;
}


- (void)dealloc {
    self.dataArray = nil;
    [super dealloc];
}

//- (void)mTableView:(TQMultistageTableView *)tableView didSelectHeaderAtSection:(NSInteger)section
//{
//    NSLog(@"headerClick%d",section);
//}

//celll点击
- (void)mTableView:(TQMultistageTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellClick%@",indexPath);
    
    XushiModel * xushiModel = self.dataArray[indexPath.section];
    NSArray * ary = [self.dataDic objectForKey:xushiModel.groupCountry_id];
    XushiModel * nextModel = ary[indexPath.row];
    [ShowTempModel manager].countryID = nextModel.country_id;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//header展开
//- (void)mTableView:(TQMultistageTableView *)tableView willOpenHeaderAtSection:(NSInteger)section
//{
//    NSLog(@"headerOpen%d",section);
//}
//
////header关闭
//- (void)mTableView:(TQMultistageTableView *)tableView willCloseHeaderAtSection:(NSInteger)section
//{
//    NSLog(@"headerClose%d",section);
//}
//
//- (void)mTableView:(TQMultistageTableView *)tableView willOpenCellAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"OpenCell%@",indexPath);
//}
//
//- (void)mTableView:(TQMultistageTableView *)tableView willCloseCellAtIndexPath:(NSIndexPath *)indexPath;
//{
//    NSLog(@"CloseCell%@",indexPath);
//}



//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
