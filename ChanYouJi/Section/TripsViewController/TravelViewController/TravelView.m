//
//  TravelView.m

#import "TravelView.h"
#import "TravelTableViewCell.h"
#import "NetWorkManager.h"
#import "TravelModel.h"
#import "TripsViewController.h"
#import "Helper.h"
#import "NotesTableViewController.h"
#import "DoubleImageTableViewCell.h"
#import "DoubleImageModel.h"
#import "MJRefresh.h"
@interface TravelView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain)NSMutableArray *dataArray;
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)NSMutableArray *doubleImageArray;
@property (nonatomic)NSInteger page;
@end

@implementation TravelView
// 初始化数据源
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}

- (NSMutableArray *)doubleImageArray{
    if (_doubleImageArray == nil) {
        self.doubleImageArray = [[@[] mutableCopy]autorelease];
    }
    return _doubleImageArray;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UITableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain]autorelease];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];

    }
    return _tableView;
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
        // 下拉刷新
        [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
        [self.tableView headerBeginRefreshing];
        // 上提加载
        [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
        [self.tableView footerBeginRefreshing];
//        [self getNetWorkRequest];
        [self getDoubleImageRequest];
        self.page = 2;
        

    }
    return self;
}
// 下拉刷新
- (void)headerRereshing{
    [self.dataArray removeAllObjects];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self getNetWorkRequest];
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
        
    });
}
// 上提加载
- (void)footerRereshing{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NetWorkManager shareWithManager]getDataWithURL:[NSString stringWithFormat:@"https://chanyouji.com/api/trips/featured.json?page=%ld",self.page] Method:@"GET" Parameters:nil Kind:10 OrContainChinese:nil success:^(id obj) {
            [self getDataSuccessWithObject:obj];
            self.page ++;
            [self.tableView footerEndRefreshing];
        } fail:^{
            [self getDataFail];
        }];
    });
}



// 请求TravelCell网络数据
- (void)getNetWorkRequest{
    [[NetWorkManager shareWithManager]getDataWithURL:@"https://chanyouji.com/api/trips/featured.json?page=1" Method:@"GET" Parameters:nil Kind:10 OrContainChinese:NO success:^(id obj) {
        [self getDataSuccessWithObject:obj];
    } fail:^{
        [self getDataFail];
    }];
}
// 数据请求成功
- (void)getDataSuccessWithObject:(id)obj{
    NSArray *dataArray = obj;
    for (NSDictionary *dic in dataArray) {
        TravelModel *travelModel = [TravelModel travelModelWithDic:dic];
        [self.dataArray addObject:travelModel];
    }
    [self.tableView reloadData];
}
// 数据请求失败
- (void)getDataFail{
//    UIAlertView *alertView = [[UIAlertView  alloc] initWithTitle:@"网络连接异常，请检查网络" message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
//    [alertView show];
}
// 请求doubleImage网络数据

- (void)getDoubleImageRequest{
    [[NetWorkManager shareWithManager]getDataWithURL:@"https://chanyouji.com/api/adverts.json?name=app_featured_banner_android&channel=chanyouji" Method:@"GET" Parameters:nil Kind:80 OrContainChinese:NO success:^(id obj) {
        [self getDoubleImageDataSuccessWithObject:obj];
    } fail:^{
        NSLog(@"doubleImage数据请求失败");
    }];
}

// 数据请求成功
- (void)getDoubleImageDataSuccessWithObject:(id)object{
    NSArray *array = object;
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        DoubleImageModel *doubleImageModel = [[DoubleImageModel alloc] init];
        [doubleImageModel setValuesForKeysWithDictionary:obj];
        [self.doubleImageArray addObject:doubleImageModel];
        [doubleImageModel release];
    }];
    [self.tableView reloadData];
}

//返回Cell的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

//返回cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        return ([UIScreen mainScreen].bounds.size.height -100)/5;
    }else{
        return ([UIScreen mainScreen].bounds.size.height -100) / 2.5;
    }
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        static NSString *indetifie = @"doubleImageCell";
        DoubleImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indetifie];
        if (cell == nil) {
            cell = [[[DoubleImageTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indetifie]autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [self.doubleImageArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            cell.doubleImageModel = obj;
        }];
        return cell;
    }else{
        static NSString * identifier = @"cekk";
        TravelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[[TravelTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier]autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.travelModel = self.dataArray[indexPath.row];
        return cell;
    }
}

//ClickCellJumpEvent
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {

    }else{
    NotesTableViewController *notesVC = [[NotesTableViewController alloc] init];
    notesVC.hidesBottomBarWhenPushed = YES;
    [[Helper shareWithHelper].tripsNavigaitionController pushViewController:notesVC animated:YES];
    TravelModel *travelModel = self.dataArray[indexPath.row];
    notesVC.travelModel = travelModel;
    notesVC.tripsID = travelModel.travelID;
    [notesVC release];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
        //设置Cell的动画效果为3D效果
        //设置x和y的初始值为0.1；
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    cell.layer.transform = CATransform3DMakeRotation(0.8, 0.5, 0.5, 0.5);
        //x和y的最终值为1
        [UIView animateWithDuration:1 animations:^{
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
            cell.layer.transform = CATransform3DMakeRotation(0, 1, 1, 1);
        }];
    
}

- (void)dealloc
{
    self.tableView = nil;
    self.dataArray = nil;
    [super dealloc];
}

@end
