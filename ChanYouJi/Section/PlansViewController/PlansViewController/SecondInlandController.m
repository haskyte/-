//
//  SecondInlandController.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/25.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "SecondInlandController.h"
#import "NetWorkManager.h"
#import "ForeignViewCell.h"
#import "SecondModel.h"

#import "WikiSecondViewController.h"
#import "SecondPlansViewController.h"
#import "TravelViewController.h"
#import "ArticlesViewController.h"
#import "DestinationsViewController.h"

@interface SecondInlandController ()<UICollectionViewDataSource, UICollectionViewDelegate, NetWorkManagerDelegate>
@property (nonatomic, retain)UICollectionView *collectionView;
@property (nonatomic, retain)NSMutableArray *dataArray;
@property (nonatomic, retain)NSMutableArray *numberROW;
@property (nonatomic, copy)NSString *number;
@end

@implementation SecondInlandController

- (void)dealloc {
    self.collectionView = nil;
    self.dataArray = nil;
    self.numberROW = nil;
    [super dealloc];
}

- (NSMutableArray *)numberROW {
    if (!_numberROW) {
        self.numberROW = [NSMutableArray arrayWithCapacity:0];
    }
    return _numberROW;
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
    self.view.userInteractionEnabled = YES;
    self.collectionView.userInteractionEnabled = YES;
    [self createCollectionView];
    
    [self.collectionView registerClass:[ForeignViewCell class] forCellWithReuseIdentifier:@"identifier"];
    
    
    NSString *str = [NSString stringWithFormat:@"https://chanyouji.com/api/destinations/%@.json?page=1",self.strID];
    
    dispatch_queue_t queue1 = dispatch_get_main_queue();
    dispatch_async(queue1, ^{
        
        [[NetWorkManager shareWithManager] getDataWithURL:str Method:@"GET" Parameters:nil Kind:0 OrContainChinese:NO success:^(id obj) {
            [self getDataSuccessWithObject:obj];
        } fail:^{
            [self getDataFail];
        }];
    });
    
    

}

- (void)getDataSuccessWithObject:(id)obj {
    NSArray *array = obj;
    for (NSDictionary *dic in array) {
        NSNumber *number = dic[@"id"];
        [self.numberROW addObject:number];
        
        SecondModel *foreignModel = [SecondModel secondModel:dic];
        [self.dataArray addObject:foreignModel];
    }
    [self.collectionView reloadData];
    
}

- (void)getDataFail {
    UIAlertView *alertView = [[UIAlertView  alloc] initWithTitle:@"网络连接异常，请检查网络" message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
    [alertView show];
}


- (void)createCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width, 240);
    flowLayout.minimumLineSpacing = 30;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ForeignViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    cell.secondModel = self.dataArray[indexPath.row];
    //攻略
    [cell.plansBtn addTarget:self action:@selector(IntoWiki:) forControlEvents:UIControlEventTouchUpInside];
    //行程
    [cell.routeBtn addTarget:self action:@selector(IntoPlans:) forControlEvents:UIControlEventTouchUpInside];
    //旅行地
    [cell.travelBtn addTarget:self action:@selector(IntoDestinations:) forControlEvents:UIControlEventTouchUpInside];
    //专题
    [cell.specialBtn addTarget:self action:@selector(IntoArticles:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)IntoDestinations:(UIButton *)button {
    DestinationsViewController *destinationsVC = [[DestinationsViewController alloc] init];
    [self.navigationController pushViewController:destinationsVC animated:YES];
    destinationsVC.destinationsBtn = [NSString stringWithFormat:@"%ld",button.tag];
}



- (void)IntoArticles:(UIButton *)button {
    ArticlesViewController *articlesVC = [[ArticlesViewController alloc] init];
    [self.navigationController pushViewController:articlesVC animated:YES];
    articlesVC.btnID = [NSString stringWithFormat:@"%ld",button.tag];
}

- (void)IntoWiki:(UIButton *)button {
    WikiSecondViewController *wikiVC = [[WikiSecondViewController alloc] init];
    [self.navigationController pushViewController:wikiVC animated:YES];
    wikiVC.strID = self.strID;
    wikiVC.numberID = [NSString stringWithFormat:@"%ld",button.tag];
    wikiVC.btnKind = @"wiki";
    [wikiVC release];
}

- (void)IntoPlans:(UIButton *)button {
    TravelViewController *plansVC = [[TravelViewController alloc] init];
    plansVC.btnID = [NSNumber numberWithInteger:button.tag];
    [self.navigationController pushViewController:plansVC animated:YES];
    
    [plansVC release];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.number = [NSString stringWithFormat:@"%@",self.numberROW[indexPath.row]];
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
