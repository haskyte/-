//
//  TripsView.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/20.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "TripsView.h"
#import "TripsTableViewCell.h"
#import "NetWorkManager.h"
#import "TravelView.h"
#import "Helper.h"
#import "TripsModel.h"
#import "ZoneViewController.h"
#import "NotesTableViewController.h"
#import "MJRefresh.h"

@interface TripsView () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)NSMutableArray *dataArray;
@property (nonatomic) NSInteger page;

@end

@implementation TripsView

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain]autorelease];
        _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate  = self;
    }
    return _tableView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];

        [self getNetWorkRequest];
        self.page = 2;
        [self.tableView addFooterWithTarget:self action:@selector(footRefresh)];
        [self.tableView footerBeginRefreshing];
    }
    return self;
}
// 上啦加载
- (void)footRefresh{
    // 获得User的id
    ZoneViewController *viewController = (ZoneViewController *)[Helper shareWithHelper].viewController;
    NSString *strid = viewController.userID;
    
    [[NetWorkManager shareWithManager]getDataWithURL:[NSString stringWithFormat:@"https://chanyouji.com/api/users/%@.json?page=%ld HTTP/1.1",strid,self.page] Method:@"GET" Parameters:nil Kind:20 OrContainChinese:NO success:^(id obj) {
        [self getDataSuccessWithObject:obj];
        self.page ++;
        [self.tableView footerEndRefreshing];
    } fail:^{
        
    }];
    
}



 //网络请求
- (void)getNetWorkRequest{
    // 获得User的id
    ZoneViewController *viewController = (ZoneViewController *)[Helper shareWithHelper].viewController;
    NSString *strid = viewController.userID;
    
    [[NetWorkManager shareWithManager]getDataWithURL:[NSString stringWithFormat:@"https://chanyouji.com/api/users/%@.json?page=1 HTTP/1.1",strid] Method:@"GET" Parameters:nil Kind:20 OrContainChinese:NO success:^(id obj) {
        NSLog(@"%@",strid);
        [self getDataSuccessWithObject:obj];
    } fail:^{
        [self getDataFail];
    }];
}
// 请求成功
- (void)getDataSuccessWithObject:(id)obj{
    NSArray *array = obj[@"trips"];
    [array enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        TripsModel *tripModel = [TripsModel tripsModelWithDic:object];
        [self.dataArray addObject:tripModel];
    }];
    [self.tableView reloadData];
}
// 请求失败
- (void)getDataFail{
    NSLog(@"失败");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identif = @"trips";
    TripsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identif];
    if (cell == nil) {
        cell = [[[TripsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identif]autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.tripsModel = self.dataArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ([UIScreen mainScreen].bounds.size.height - 64) /3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TripsModel *tripModel = self.dataArray[indexPath.row];
    NotesTableViewController *notesTVC= [[NotesTableViewController alloc] init];
    [[Helper shareWithHelper].tripsNavigaitionController pushViewController:notesTVC animated:YES];
    notesTVC.tripsID = tripModel.tripsID;
    [notesTVC release];
}

@end
