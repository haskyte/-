//
//  TopicView.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/18.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "TopicView.h"
#import "TopicTableViewCell.h"
#import "NetWorkManager.h"
#import "TopicModel.h"
@interface TopicView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *dataArray;
@end

@implementation TopicView

// 懒加载
- (UITableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain]autorelease];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
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
        [self getNewWorkRequest];
        
    }
    return self;
}

//
- (void)getNewWorkRequest{
    [[NetWorkManager shareWithManager]getDataWithURL:@"https://chanyouji.com/api/articles.json?page=1%20HTTP/1.1" Method:@"GET" Parameters:nil Kind:10 OrContainChinese:NO success:^(id obj) {
        [self getDataSuccessWithObject1:obj];
    } fail:^{
        [self getFail];
    }];
}

// 数据请求成功
- (void)getDataSuccessWithObject1:(id)obj{
    NSArray *array = obj;

    for (NSDictionary *dic in array) {

        TopicModel *topicModel = [TopicModel topicModelWithdic:dic];
        [self.dataArray addObject:topicModel];
    };
    [self.tableView reloadData];
}
// 数据请求失败
- (void)getFail{
    NSLog(@"123");
}

#pragma tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"TopicCell";
    TopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[[TopicTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify]autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.topicModel = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ([UIScreen mainScreen].bounds.size.height -100) / 2.5;
}


- (void)dealloc
{
    self.tableView = nil;
    [super dealloc];
}

@end
