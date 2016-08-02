//
//  SecondTravelController.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "SecondTravelController.h"
#import "NetWorkManager.h"
#import "FirstTravelModel.h"
#import "SecondTravelModel.h"
#import "ThirdTravelModel.h"
#import "UIImageView+WebCache.h"
#import "SecondTravelViewCell.h"
#import "ThirdTravelController.h"

@interface SecondTravelController ()<UITableViewDataSource, UITableViewDelegate,NetWorkManagerDelegate>
@property (nonatomic, retain)NSMutableArray *dataArray;
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)NSMutableArray *planDays;
@property (nonatomic, retain)NSMutableArray *planNodes;
@end

@implementation SecondTravelController

- (void)dealloc {
    self.dataArray = nil;
    self.planDays = nil;
    self.planNodes = nil;
    [super dealloc];
}

- (NSMutableArray *)planNodes {
    if (!_planNodes) {
        self.planNodes = [NSMutableArray arrayWithCapacity:0];
    }
    return _planNodes;
}

- (NSMutableArray *)planDays {
    if (!_planDays) {
        self.planDays = [NSMutableArray arrayWithCapacity:0];
    }
    return _planDays;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self createTableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[SecondTravelViewCell class] forCellReuseIdentifier:@"identifier"];
    
    dispatch_queue_t queue1 = dispatch_get_main_queue();
    dispatch_async(queue1, ^{
        
        [[NetWorkManager shareWithManager] getDataWithURL:[NSString stringWithFormat:@"https://chanyouji.com/api/plans/%@.json?page=1",self.travel_ID] Method:@"GET" Parameters:nil Kind:0 OrContainChinese:NO success:^(id obj) {
            [self getDataSuccessWithObject:obj];
        } fail:^{
            [self getDataFail];
        }];
    });
    
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< 蝉" style:UIBarButtonItemStylePlain target:self action:@selector(getOutView:)];
   
}

- (void)getOutView:(UIBarButtonItem *)item {
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)getDataSuccessWithObject:(id)obj {
    NSDictionary *dic = obj;
//    FirstTravelModel *first = [FirstTravelModel firstTravelModel:dic];
    NSArray *array = dic[@"plan_days"];
    for (NSDictionary *dicPlanDays in array) {
        SecondTravelModel *second = [SecondTravelModel secondTravelModel:dicPlanDays];
        [self.planDays addObject:second];
        NSArray *arr = dicPlanDays[@"plan_nodes"];
        for (NSDictionary *dicPlanNodes in arr) {
            ThirdTravelModel *third = [ThirdTravelModel thirdTravelModel:dicPlanNodes];
            [self.planNodes addObject:third];
        }
    }
    
    [self.tableView reloadData];
}

- (void)getDataFail {
    UIAlertView *alertView = [[UIAlertView  alloc] initWithTitle:@"网络连接异常，请检查网络" message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
    [alertView show];
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.planNodes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SecondTravelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];
    
    cell.second = self.planDays[indexPath.section];
    cell.third = self.planNodes[indexPath.row];

      return cell;
    
   
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 355;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ThirdTravelController *thirdVC = [[ThirdTravelController alloc] init];
    ThirdTravelModel *thirdTravelModel = self.planNodes[indexPath.row];
    thirdVC.strID = thirdTravelModel.entry_id;
    [self.navigationController pushViewController:thirdVC animated:YES];
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
