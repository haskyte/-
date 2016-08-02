//
//  InlandViewController.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/24.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "InlandViewController.h"
#import "NetWorkManager.h"
#import "InlandCollectionViewCell.h"
#import "ForeignModel.h"
#import "SecondInlandController.h"

@interface InlandViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,NetWorkManagerDelegate>
@property (nonatomic, retain)UICollectionView *collectionView;
@property (nonatomic, retain)NSMutableArray *category;
@property (nonatomic, retain)NSMutableArray *ID;
@property (nonatomic, retain)NSMutableArray *dataArray;
@end

@implementation InlandViewController

- (void)dealloc {
    self.collectionView = nil;
    self.category = nil;
    self.ID = nil;
    self.dataArray = nil;
    [super dealloc];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}

- (NSMutableArray *)ID {
    if (!_ID) {
        self.ID = [NSMutableArray arrayWithCapacity:0];
    }
    return _ID;
}

- (NSMutableArray *)category {
    if (!_category) {
        self.category = [NSMutableArray arrayWithCapacity:0];
    }
    return _category;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createCollectionView];
    
    [self.collectionView registerClass:[InlandCollectionViewCell class] forCellWithReuseIdentifier:@"identifier"];
    
    dispatch_queue_t queue1 = dispatch_get_main_queue();
    dispatch_async(queue1, ^{
        
        [[NetWorkManager shareWithManager] getDataWithURL:@"https://chanyouji.com/api/destinations.json?page=1" Method:@"GET" Parameters:nil Kind:0 OrContainChinese:NO success:^(id obj) {
            [self getDataSuccessWithObject:obj];
        } fail:^{
            [self getDataFail];
        }];
    });
    
    
}
- (void)createCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width, 200);
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
}

- (void)getDataSuccessWithObject:(id)obj {
    NSArray *array = obj;
    for (NSDictionary *dic in array) {
        NSString *str = dic[@"category"];
        if (![str isEqualToString:@"999"]) {
            
            [self.category addObject:str];
            NSArray *arr = dic[@"destinations"];
            
            for (NSDictionary *dictionary in arr) {
                NSNumber *number = dictionary[@"id"];
                [self.ID addObject:number];
                ForeignModel *foreignModel = [ForeignModel foreignModel:dictionary];
                [self.dataArray addObject:foreignModel];
            }
        }
    }
    [self.collectionView reloadData];
}

- (void)getDataFail {
    UIAlertView *alertView = [[UIAlertView  alloc] initWithTitle:@"网络连接异常，请检查网络" message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
    [alertView show];
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *str = @"identifier";
    InlandCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:str forIndexPath:indexPath];
    cell.foreignModel = self.dataArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SecondInlandController *inlandVC = [[SecondInlandController alloc] init];
    [self.nav pushViewController:inlandVC animated:YES];
    inlandVC.strID = [NSString stringWithFormat:@"%@",self.ID[indexPath.item]];
    [inlandVC release];
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
