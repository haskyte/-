//
//  ArticlesViewController.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/27.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "ArticlesViewController.h"
#import "NetWorkManager.h"
#import "ArticlesViewCell.h"
#import "ArticlesModel.h"
#import "SecondArticlesViewController.h"
#import "DetailTableViewController.h"

@interface ArticlesViewController ()<UITableViewDataSource, UITableViewDelegate, NetWorkManagerDelegate>
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)NSMutableArray *dataArray;
@end

@implementation ArticlesViewController

- (void)dealloc {
    self.btnID = nil;
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
    [self crateTableView];
    [self.tableView registerClass:[ArticlesViewCell class] forCellReuseIdentifier:@"identifier"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    dispatch_queue_t queue1 = dispatch_get_main_queue();
    dispatch_async(queue1, ^{

        [[NetWorkManager shareWithManager] getDataWithURL:[NSString stringWithFormat:@"https://chanyouji.com/api/articles.json?destination_id=%@&page=1",self.btnID] Method:@"GET" Parameters:nil Kind:0 OrContainChinese:NO success:^(id obj) {
            [self getDataSuccessWithObject:obj];
        } fail:^{
            [self getDataFail];
        }];
    });
    
    
}

- (void)getDataSuccessWithObject:(id)obj {
    NSArray *array = obj;
    for (NSDictionary *dic in array) {
        ArticlesModel *articles = [ArticlesModel articlesModel:dic];
        [self.dataArray addObject:articles];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticlesViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];
    cell.articlesModel = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 310;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailTableViewController *second = [[DetailTableViewController alloc] init];
    ArticlesModel *articles = self.dataArray[indexPath.row];
    second.topicID = [NSString stringWithFormat:@"%@",articles.articlesID];
    [self.navigationController pushViewController:second animated:YES];
    [second release];
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
