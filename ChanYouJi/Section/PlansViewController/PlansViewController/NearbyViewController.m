//
//  NearbyViewController.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/24.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "NearbyViewController.h"
#import "NetWorkManager.h"
#import "NearbyCollectionViewCell.h"
#import "NearbyModel.h"
#import "SecondNearbyController.h"
#import "SeconDestinationViewController.h"
#import "CLLocationManager+blocks.h"


@interface NearbyViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,NetWorkManagerDelegate>
@property (nonatomic, retain)UICollectionView *collectionView;
@property (nonatomic, retain)NSMutableArray *ID;
@property (nonatomic, retain)NSMutableArray *dataArray;
@property (nonatomic, retain)CLLocationManager *manager;
@end

@implementation NearbyViewController
- (void)dealloc {
    self.collectionView = nil;
    self.ID = nil;
    self.dataArray = nil;
    self.manager = nil;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createCollectionView];
    [self.collectionView registerClass:[NearbyCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.manager = [CLLocationManager updateManagerWithAccuracy:50 locationAge:15 authorizationDesciption:CLLocationUpdateAuthorizationDescriptionAlways];
    
    if ([CLLocationManager isLocationUpdatesAvailable]) {
        [self.manager startUpdatingLocationWithUpdateBlock:^(CLLocationManager *manager, CLLocation *location, NSError *error, BOOL *stopUpdating) {
            dispatch_queue_t queue1 = dispatch_get_main_queue();
            dispatch_async(queue1, ^{
                [[NetWorkManager shareWithManager] getDataWithURL:[NSString stringWithFormat:@"https://chanyouji.com/api/attractions.json?lat=%f&lng=%f&all=true",location.coordinate.latitude, -location.coordinate.longitude] Method:@"GET" Parameters:nil Kind:0 OrContainChinese:NO success:^(id obj) {
                    [self getDataSuccessWithObject:obj];
                } fail:^{
                    [self getDataFail];
                }];
                *stopUpdating = YES;
            });

        }];
    }
    
    

    
    
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
        NSNumber *number = dic[@"id"];
//        NSString *number = [NSString stringWithFormat:@"%@",dic[@"id"]];
        NSString *str = [NSString stringWithFormat:@"%@",number];
        [self.ID addObject:str];
        NearbyModel *nearbyModel = [NearbyModel neaybyModel:dic];
        [self.dataArray addObject:nearbyModel];

    }
    [self.collectionView reloadData];
}

- (void)getDataFail {
    UIAlertView *alertView = [[UIAlertView  alloc] initWithTitle:@"网络连接异常，请检查网络" message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
    [alertView show];
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *str = @"cell";
    NearbyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:str forIndexPath:indexPath];
    cell.nearbyModel = self.dataArray[indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    SecondNearbyController *second = [[SecondNearbyController alloc] init];
//    [self.nav pushViewController:second animated:YES];
//    [second release];
    SeconDestinationViewController *seconVC = [[SeconDestinationViewController alloc] init];
    
    NearbyModel *near = self.dataArray[indexPath.row];
    seconVC.strID = [NSString stringWithFormat:@"%@",near.NumberID];//未完待续
    [self.nav pushViewController:seconVC animated:YES];
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
