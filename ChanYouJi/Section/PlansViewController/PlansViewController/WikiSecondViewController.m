//
//  WikiSecondViewController.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/25.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "WikiSecondViewController.h"
#import "NetWorkManager.h"
#import "WikiModel.h"
#import "WikiViewCell.h"

@interface WikiSecondViewController ()<UITableViewDelegate,UITableViewDataSource,NetWorkManagerDelegate>
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)NSMutableArray *dataArray;
@property (nonatomic, retain)NSMutableArray *category;
@property (nonatomic, retain)NSMutableArray *pagesID;
@property (nonatomic, retain)NSMutableArray *wikiArray;
@end

@implementation WikiSecondViewController

- (void)dealloc {
    self.tableView = nil;
    self.dataArray = nil;
    self.numberID = nil;
    self.category = nil;
    self.pagesID = nil;
    self.wikiArray = nil;
    [super dealloc];
}

- (NSMutableArray *)wikiArray {
    if (!_wikiArray) {
        self.wikiArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _wikiArray;
}


- (NSMutableArray *)pagesID {
    if (!_pagesID) {
        self.pagesID = [NSMutableArray arrayWithCapacity:0];
    }
    return _pagesID;
}


- (NSMutableArray *)category {
    if (!_category) {
        self.category = [NSMutableArray arrayWithCapacity:0];
    }
    return _category;
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
    [self createTableView];
    [self.tableView registerClass:[WikiViewCell class] forCellReuseIdentifier:@"identifier"];
    
    
    NSString *str = [NSString stringWithFormat:@"https://chanyouji.com/api/wiki/destinations/%@.json?page=1",self.strID];
    
    dispatch_queue_t queue1 = dispatch_get_main_queue();
    dispatch_async(queue1, ^{
        
        [[NetWorkManager shareWithManager] getDataWithURL:str Method: @"GET"Parameters:nil Kind:0 OrContainChinese:NO success:^(id obj) {
            [self getDataSuccessWithObject:obj];
        } fail:^{
            [self getDataFail];
        }];
    });
    
    
}

- (void)getDataSuccessWithObject:(id)obj {
    NSArray *array = obj;
    for (NSDictionary *dic in array) {
        NSString *cateType = [NSString stringWithFormat:@"%@",dic[@"category_type"]];
        [self.category addObject:cateType];
        if ([cateType isEqualToString:@"0"]) {
            
            NSArray *arrayPages = dic[@"pages"];
            for (NSDictionary *dicPages in arrayPages) {
                NSNumber *pagesNumber = dicPages[@"id"];
                [self.pagesID addObject:pagesNumber];
                WikiModel *wiki = [WikiModel wikiModel:dicPages];
                [self.wikiArray addObject:wiki];
            }
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.category.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WikiViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
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
