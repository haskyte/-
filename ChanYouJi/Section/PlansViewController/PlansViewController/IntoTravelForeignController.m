//
//  IntoTravelForeignController.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/28.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "IntoTravelForeignController.h"
#import "NetWorkManager.h"
#import "DestinationsModel.h"
#import "DestinationsViewCell.h"
#import "SecondIntoTravelController.h"

@interface IntoTravelForeignController ()<UITableViewDataSource, UITableViewDelegate,NetWorkManagerDelegate>
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)NSMutableArray *dataArray;
@end

@implementation IntoTravelForeignController
- (void)dealloc {
    self.tableView = nil;
    self.dataArray = nil;
    [super dealloc];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[DestinationsViewCell class] forCellReuseIdentifier:@"CHU"];
    
    dispatch_queue_t queue1 = dispatch_get_main_queue();
    dispatch_async(queue1, ^{
        
        [[NetWorkManager shareWithManager] getDataWithURL:[NSString stringWithFormat:@"https://chanyouji.com/api/destinations/attractions/%@.json?page=1",self.strID] Method:@"GET" Parameters:nil Kind:0 OrContainChinese:NO success:^(id obj) {
            [self getDataSuccessWithObject:obj];
        } fail:^{
            [self getDataFail];
        }];
    });
    
    
    
}

- (void)getDataSuccessWithObject:(id)obj {
    NSArray *array = obj;
    for (NSDictionary *dic in array) {
        DestinationsModel *destinationModel = [DestinationsModel destinationsModel:dic];
        [self.dataArray addObject:destinationModel];
    }
    [self.tableView reloadData];
}

- (void)getDataFail {
    UIAlertView *alertView = [[UIAlertView  alloc] initWithTitle:@"网络连接异常，请检查网络" message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
    [alertView show];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DestinationsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CHU" forIndexPath:indexPath];
    cell.destinationModel = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SecondIntoTravelController *second = [[SecondIntoTravelController alloc] init];
    DestinationsModel *destinationsModel = self.dataArray[indexPath.row];
    second.strID = destinationsModel.destinationsID;
    [self.navigationController pushViewController:second animated:YES];
}



- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
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
