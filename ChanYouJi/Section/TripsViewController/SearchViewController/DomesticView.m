//
//  DomesticView.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "DomesticView.h"
#import "SearchCollectionViewCell.h"
#import "NetWorkManager.h"
#import "SearchModel.h"

#import "SearchResultTableViewController.h"
#import "Helper.h"

@interface DomesticView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *dataArray;

@end


@implementation DomesticView

- (void)dealloc
{
    self.collectionView = nil;
    self.dataArray = nil;
    [super dealloc];
}
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        self.dataArray = [[@[] mutableCopy]autorelease];
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
        // 创建collectionView;
        [self creatCollectionView];
        //
        [self getNetWorkRequest];
    }
    return self;
}
// 创建collectionView;
- (void)creatCollectionView{
    UICollectionViewFlowLayout *flowLayout =[[[UICollectionViewFlowLayout alloc] init]autorelease];
    self.collectionView = [[[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout]autorelease];
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    [self addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    // 注册cell
    [self.collectionView registerClass:[SearchCollectionViewCell class] forCellWithReuseIdentifier:@"item"];
    
    [_collectionView release];
}
// 进行网络请求
- (void)getNetWorkRequest{
    [[NetWorkManager shareWithManager]getDataWithURL:@"https://chanyouji.com/api/destinations/list.json%20" Method:@"GET" Parameters:nil Kind:60 OrContainChinese:YES success:^(id obj) {
        [self getDataSuccessWithObject:obj];
    } fail:^{
        NSLog(@"数据请求失败");
    }];
}
// 数据请求成功
- (void)getDataSuccessWithObject:(id)object{
    NSArray *array = object[@"china_destinations"];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        SearchModel *searchModel = [SearchModel searchModelWithDictionary:obj];
        [self.dataArray addObject:searchModel];
    }];
    [self.collectionView reloadData];
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    cell.searchModel = self.dataArray[indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width -40)/3, 30);
}
// cell 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SearchResultTableViewController *searchResultVC =[[SearchResultTableViewController alloc] init];
    UINavigationController *navigationC = [[UINavigationController alloc] initWithRootViewController:searchResultVC];
    [[Helper shareWithHelper].searchNavigationController presentViewController:navigationC animated:YES completion:nil];
    
    SearchModel *searchModel = self.dataArray[indexPath.row];
    searchResultVC.countryId = searchModel.nameId;
 
    searchResultVC.titleName = searchModel.name;
    searchResultVC.destinations = @"/destinations";
    [searchResultVC release];
    [navigationC release];
}


@end
