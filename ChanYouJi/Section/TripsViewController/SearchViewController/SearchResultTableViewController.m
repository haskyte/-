//
//  SearchResultTableViewController.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "SearchResultTableViewController.h"
#import "TravelModel.h"
#import "TravelTableViewCell.h"
#import "NetWorkManager.h"
#import "NotesTableViewController.h"
#import "MJRefresh.h"
@interface SearchResultTableViewController ()

@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic) NSInteger page;


@end

@implementation SearchResultTableViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [[@[] mutableCopy]autorelease];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [NSString stringWithFormat:@"%@游记",self.titleName];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0 green:150/255.0 blue:1.0 alpha:1];
    self.page = 2;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackBarButton"] style:UIBarButtonItemStylePlain target:self action:@selector(returnSearchView:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    [self getNetWorkRequest];
    [self.tableView addFooterWithTarget:self action:@selector(footRefresh)];
    [self.tableView footerBeginRefreshing];
}
// 上提加载
- (void)footRefresh{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *url = [NSString stringWithFormat:@"https://chanyouji.com/api%@/trips/%@.json?month=0&page=%ld",self.destinations,self.countryId,self.page];
        [[NetWorkManager shareWithManager]getDataWithURL:url Method:@"GET" Parameters:nil Kind:50 OrContainChinese:NO success:^(id obj) {
            [self getDataSuccessWithObject:obj];
            [self.tableView footerEndRefreshing];
        } fail:^{
            NSLog(@"搜索失败");
        }];
        self.page ++;
    });
}



//
- (void)returnSearchView:(UINavigationItem *)item{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)getNetWorkRequest{
    NSString *url = [NSString stringWithFormat:@"https://chanyouji.com/api%@/trips/%@.json?month=0&page=1",self.destinations,self.countryId];
    [[NetWorkManager shareWithManager]getDataWithURL:url Method:@"GET" Parameters:nil Kind:50 OrContainChinese:NO success:^(id obj) {
        [self getDataSuccessWithObject:obj];
    } fail:^{
        NSLog(@"搜索失败");
    }];
}
- (void)getDataSuccessWithObject:(id)object{
    NSArray *array = object;
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        TravelModel *travelModel = [TravelModel travelModelWithDic:obj];
        [self.dataArray addObject:travelModel];
    }];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"searchCell";
    TravelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[TravelTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier]autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.travelModel = self.dataArray [indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ([UIScreen mainScreen].bounds.size.height -100) / 2.5;
}
// 点击cell 触发事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

        NotesTableViewController *notesVC = [[NotesTableViewController alloc] init];
        notesVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:notesVC animated:YES];
        TravelModel *travelModel = self.dataArray[indexPath.row];
        notesVC.travelModel = travelModel;
        notesVC.tripsID = travelModel.travelID;
    [notesVC release];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
