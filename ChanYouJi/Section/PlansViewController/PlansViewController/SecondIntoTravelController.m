//
//  SecondIntoTravelController.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/30.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "SecondIntoTravelController.h"
#import "NetWorkManager.h"
#import "SecondThirdModel.h"
#import "ThirdThirdModel.h"
#import "FourthThirdModel.h"
#import "ThirdTravelViewCell.h"

@interface SecondIntoTravelController ()<UITableViewDataSource, UITableViewDelegate, NetWorkManagerDelegate>
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)NSMutableArray *dataArray;
@property (nonatomic, retain)NSMutableArray *attraction_contents;
@property (nonatomic, retain)NSMutableArray *strName;//存放区头文字
@property (nonatomic, retain)NSMutableArray *secondNumber;
@property (nonatomic, retain)NSMutableArray *thirdArray;

@end

@implementation SecondIntoTravelController
- (void)dealloc {
    self.tableView = nil;
    self.dataArray = nil;
    self.attraction_contents = nil;
    self.strName = nil;
    self.secondNumber = nil;
    self.thirdArray = nil;
    [super dealloc];
}

- (NSMutableArray *)thirdArray {
    if (!_thirdArray) {
        self.thirdArray = [NSMutableArray array];
    }
    return _thirdArray;
}

- (NSMutableArray *)secondNumber {
    if (!_secondNumber) {
        self.secondNumber = [NSMutableArray array];
    }
    return _secondNumber;
}

- (NSMutableArray *)strName {
    if (!_strName) {
        self.strName = [NSMutableArray array];
    }
    return _strName;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)attraction_contents {
    if (!_attraction_contents) {
        self.attraction_contents = [NSMutableArray array];
    }
    return _attraction_contents;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[ThirdTravelViewCell class] forCellReuseIdentifier:@"SKY"];
    
    dispatch_queue_t queue1 = dispatch_get_main_queue();
    dispatch_async(queue1, ^{
        
        
        [[NetWorkManager shareWithManager] getDataWithURL:[NSString stringWithFormat:@"https://chanyouji.com/api/attractions/%@.json",self.strID] Method:@"GET" Parameters:nil Kind:0 OrContainChinese:NO success:^(id obj) {
            [self getDataSuccessWithObject:obj];
        } fail:^{
            [self getDataFail];
        }];
    });
    
    
}
- (void)getDataSuccessWithObject:(id)obj {
    NSDictionary *dic = obj;
    
    NSArray *array = dic[@"attraction_trip_tags"];
    for (NSDictionary *dic in array) {
        NSString *strName = dic[@"name"];
        [self.strName addObject:strName];//titleForSection
        NSArray *arr = dic[@"attraction_contents"];
        for (NSDictionary *dict in arr) {
            SecondThirdModel *second = [SecondThirdModel secondThirdModel:dict];
            [self.secondNumber addObject:second];//numberOfRow
            ThirdThirdModel *third = [ThirdThirdModel thirdThirdModel:dict[@"trip"]];
            [self.thirdArray addObject:third];
            NSArray *arrayNotes = dict[@"notes"];
            
            FourthThirdModel *fourth = [FourthThirdModel fourthThirdModel:arrayNotes];
            [self.dataArray addObject:fourth];
            
//            for (NSDictionary *dicNotes in arrayNotes) {
//                FourthThirdModel *fourth = [FourthThirdModel fourthThirdModel:dicNotes];
//                fourth.countNumber = arrayNotes.count;
//                [self.dataArray addObject:fourth];
//            }
        }
        
    }
    
    [self.tableView reloadData];
}

- (void)getDataFail {
    UIAlertView *alertView = [[UIAlertView  alloc] initWithTitle:@"网络连接异常，请检查网络" message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
    [alertView show];
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ThirdTravelViewCell *cell = [[ThirdTravelViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SKY"];
    /*未完待续*/
    cell.second = self.secondNumber[indexPath.row];
    cell.third = self.thirdArray[indexPath.row];
    cell.fourth = self.dataArray[indexPath.row];
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.secondNumber.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.strName.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.strName[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
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
