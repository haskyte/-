//
//  SecondForeignController.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/25.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "SecondForeignController.h"
#import "NetWorkManager.h"
#import "ForeignModel.h"
#import "ForeignViewCell.h"
#import "SecondModel.h"
#import "IntoPlansForeignController.h"
#import "IntoTravelForeignController.h"
#import "IntoSpecialForeignController.h"

@interface SecondForeignController ()<UICollectionViewDataSource, UICollectionViewDelegate, NetWorkManagerDelegate>
@property (nonatomic, retain)UICollectionView *collectionView;
@property (nonatomic, retain)NSMutableArray *dataArray;
@end

@implementation SecondForeignController

- (void)dealloc {
    self.strID = nil;
    self.collectionView = nil;
    self.dataArray = nil;
    [super dealloc];
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
    self.view.userInteractionEnabled = YES;
    [self createCollectionView];
    
    [self.collectionView registerClass:[ForeignViewCell class] forCellWithReuseIdentifier:@"Cell"];
    dispatch_queue_t queue1 = dispatch_get_main_queue();
    dispatch_async(queue1, ^{
        
        NSString *str = [NSString stringWithFormat:@"https://chanyouji.com/api/destinations/%@.json?page=1",self.strID];
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
    self.collectionView.userInteractionEnabled = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   
    return self.dataArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ForeignViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell"forIndexPath:indexPath];
    
    cell.secondModel = self.dataArray[indexPath.item];
    [cell.routeBtn addTarget:self action:@selector(IntoPlans:) forControlEvents:UIControlEventTouchUpInside];
    [cell.travelBtn addTarget:self action:@selector(IntoTravel:) forControlEvents:UIControlEventTouchUpInside];
    [cell.specialBtn addTarget:self action:@selector(IntoSpecial:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)IntoSpecial:(UIButton *)button {
    IntoSpecialForeignController *specialVC = [[IntoSpecialForeignController alloc] init];
    specialVC.strID = [NSString stringWithFormat:@"%ld",button.tag];
    [self.navigationController pushViewController:specialVC animated:YES];
}

- (void)IntoTravel:(UIButton *)button {
    IntoTravelForeignController *intoTravelVC = [[IntoTravelForeignController alloc] init];
    intoTravelVC.strID = [NSString stringWithFormat:@"%ld",button.tag];
    [self.navigationController pushViewController:intoTravelVC animated:YES];
}

- (void)IntoPlans:(UIButton *)button {
    
    IntoPlansForeignController *intoPlansVC = [[IntoPlansForeignController alloc] init];
    intoPlansVC.strID = [NSString stringWithFormat:@"%ld",button.tag];
    [self.navigationController pushViewController:intoPlansVC animated:YES];
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
