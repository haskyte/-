//
//  TravelViewController.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "TravelViewController.h"
#import "NetWorkManager.h"
#import "TravelViewCell.h"
#import "TravelBtnModel.h"
#import "SecondTravelController.h"

@interface TravelViewController ()<UITableViewDataSource, UITableViewDelegate, NetWorkManagerDelegate>
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)NSMutableArray *dataArray;
@property (nonatomic, retain)NSMutableArray *arrayID;
@end

@implementation TravelViewController

- (void)dealloc {
    self.tableView = nil;
    self.dataArray = nil;
    self.arrayID = nil;
    [super dealloc];
}

- (NSMutableArray *)arrayID {
    if (!_arrayID) {
        self.arrayID = [NSMutableArray arrayWithCapacity:0];
    }
    return _arrayID;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self crateTableView];
    [self.tableView registerClass:[TravelViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    dispatch_queue_t queue1 = dispatch_get_main_queue();
    dispatch_async(queue1, ^{
        
        [[NetWorkManager shareWithManager] getDataWithURL:[NSString stringWithFormat:@"https://chanyouji.com/api/destinations/plans/%@.json?page=1",self.btnID] Method:@"GET" Parameters:nil Kind:0 OrContainChinese:NO success:^(id obj) {
            [self getDataSuccessWithObject:obj];
        } fail:^{
            [self getDataFail];
        }];
    });
    
    
    
}

- (void)getDataSuccessWithObject:(id)obj {
    NSArray *array = obj;
    for (NSDictionary *dic in array) {
        TravelBtnModel *travel = [TravelBtnModel travelBtnModel:dic];
        [self.dataArray addObject:travel];
    }
    [self.tableView reloadData];
}

- (void)getDataFail {
    UIAlertView *alertView = [[UIAlertView  alloc] initWithTitle:@"网络连接异常，请检查网络" message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
    [alertView show];
}



- (void)crateTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    [self.view addSubview:self.tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TravelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.travelBtnModel = self.dataArray[indexPath.row];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TravelBtnModel *travelBtn = self.dataArray[indexPath.row];
    SecondTravelController *secondTravel = [[SecondTravelController alloc] init];
    secondTravel.travel_ID = [NSString stringWithFormat:@"%@",travelBtn.travel_ID];
    secondTravel.name = travelBtn.name;
    secondTravel.plan_days_count = travelBtn.plan_days_count;
    secondTravel.plan_nodes_count = travelBtn.plan_nodes_count;
    secondTravel.image_url = travelBtn.image_url;
    
    [self.navigationController pushViewController:secondTravel animated:YES];
    [secondTravel release];
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
