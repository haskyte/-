//
//  FavouriteView.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/20.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "FavouriteView.h"
#import "UICollectionViewWaterfallLayout.h"
#import "FavoutiteCollectionViewCell.h"
#import "NetWorkManager.h"
#import "ZoneViewController.h"
#import "Helper.h"
#import "UserFavouriteModel.h"
#import "MJRefresh.h"
#import "PhotoShowViewController.h"
#import "UIImageView+WebCache.h"


#define SCREENWIDE [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGTH [UIScreen mainScreen].bounds.size.height
@interface FavouriteView ()<UICollectionViewDelegateWaterfallLayout,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, retain)UICollectionView *collectionView;
@property (nonatomic, retain)NSMutableArray *dataArray;
@property (nonatomic)NSInteger page;

@end


@implementation FavouriteView

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        self.dataArray = [[@[] mutableCopy]autorelease];
    }
    return _dataArray;
}


- (void)dealloc
{
    self.collectionView = nil;
    self.dataArray = nil;
    [super dealloc];
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
        self.page = 2;
        [self creatCollectionView];
        self.collectionView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        [self getNetWorkRequest];
        [self.collectionView addFooterWithTarget:self action:@selector(footRefresh)];
        [self.collectionView footerBeginRefreshing];
        
    }
    return self;
}
// 上提刷新
- (void)footRefresh{
    ZoneViewController *viewController = (ZoneViewController *)[Helper shareWithHelper].viewController;
    [[NetWorkManager shareWithManager]getDataWithURL:[NSString stringWithFormat:@"https://chanyouji.com/api/users/likes/%@.json?per_page=18&page=%ld",viewController.userID,self.page] Method:@"GET" Parameters:nil Kind:50 OrContainChinese:NO success:^(id obj) {
        [self getDataSuccessWithObject:obj];
        self.page ++;
        [self.collectionView footerEndRefreshing];
    } fail:^{
       
    }];
}

// 请求网络数据
- (void)getNetWorkRequest{
    ZoneViewController *viewController = (ZoneViewController *)[Helper shareWithHelper].viewController;
    [[NetWorkManager shareWithManager]getDataWithURL:[NSString stringWithFormat:@"https://chanyouji.com/api/users/likes/%@.json?per_page=18&page=1",viewController.userID] Method:@"GET" Parameters:nil Kind:50 OrContainChinese:NO success:^(id obj) {
        [self getDataSuccessWithObject:obj];
    } fail:^{
        NSLog(@"图片请求失败");
    }];
    
}
// 数据请求成功
- (void)getDataSuccessWithObject:(id)object{
    [object enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UserFavouriteModel *favouriteModel = [UserFavouriteModel favouriteModelWithDictionary:obj];
        [self.dataArray addObject:favouriteModel];
    }];
    [self.collectionView reloadData];
}
// 创建集合视图
- (void)creatCollectionView{
    UICollectionViewWaterfallLayout *waterFlowLayout = [[UICollectionViewWaterfallLayout alloc] init];
    waterFlowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    waterFlowLayout.itemWidth = ([UIScreen mainScreen].bounds.size.width - 30)/2;
    waterFlowLayout.delegate = self;
    waterFlowLayout.minLineSpacing = 10;
    
    self.collectionView = [[[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:waterFlowLayout]autorelease];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self addSubview:self.collectionView];
    [self.collectionView registerClass:[FavoutiteCollectionViewCell class] forCellWithReuseIdentifier:@"favourite"];
}
// 返回每个分区的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
// 返回分区总数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FavoutiteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"favourite" forIndexPath:indexPath];
    cell.favouriteModel = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewWaterfallLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath{
    UserFavouriteModel *favouriteModel = self.dataArray[indexPath.row];
    CGFloat picH = favouriteModel.photoHeight.floatValue;
    CGFloat picw = favouriteModel.photoWidth.floatValue;
    CGFloat wide = ([UIScreen mainScreen].bounds.size.width - 30)/2;
    return   picH * wide / picw;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoShowViewController *photoShowVC = [[PhotoShowViewController alloc] init];

    photoShowVC.pictureCount = indexPath.row;


    NSMutableArray *photoArray = [NSMutableArray arrayWithCapacity:0];
    [self.dataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UserFavouriteModel *favouriteModel = obj;
        CGFloat picH = favouriteModel.photoHeight.floatValue;
        CGFloat picw = favouriteModel.photoWidth.floatValue;
        CGFloat height = picH * SCREENWIDE / picw;
        
        UIImageView *photoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, (SCREENHEIGTH - height)/2, SCREENWIDE, height)];;
        [photoImage sd_setImageWithURL:[NSURL URLWithString:favouriteModel.photoUrl]];
        [photoArray addObject:photoImage];
        
    }];
    photoShowVC.photoArray = photoArray;
    
    
    
    [[Helper shareWithHelper].viewController.navigationController presentViewController:photoShowVC animated:NO completion:nil];
    [photoShowVC release];
    
    FavoutiteCollectionViewCell *cell = (FavoutiteCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"%@",cell);
    
}
//测试tableView的cellRollFunction
- (void)setUpViewSendFunction{
    UITableView * tabelView = [[UITableView alloc]initWithFrame:CGRectMake(SCREENWIDE-20, SCREENHEIGTH-100, SCREENWIDE, SCREENHEIGTH)];
    [self addSubview:tabelView];
}

@end
