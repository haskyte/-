//
//  OverseasView.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "OverseasView.h"
#import "SearchCollectionViewCell.h"
#import "NetWorkManager.h"
#import "SearchModel.h"
#import "SearchResultTableViewController.h"
#import "Helper.h"



@interface OverseasView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *dataArray;

@end


@implementation OverseasView

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

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatCollectionView];
        // 请求网络数据
        [self getNetWorkRequest];
    
    }
    return self;
}

- (void)getNetWorkRequest{
    [[NetWorkManager shareWithManager]getDataWithURL:@"https://chanyouji.com/api/destinations/list.json%20" Method:@"GET" Parameters:nil Kind:60 OrContainChinese:YES success:^(id obj) {
        [self getDataSuccessWithObject:obj];
    } fail:^{
        NSLog(@"外国数据请求失败");
    }];
}
// 数据请求成功
- (void)getDataSuccessWithObject:(id)object{
    NSArray *array = object[@"other_destinations"];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        SearchModel *searchModel = [SearchModel searchModelWithDictionary:obj];
        [self.dataArray addObject:searchModel];
    }];
    [self.collectionView reloadData];
}

// 创建collectionView
- (void)creatCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout]autorelease];
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    // 注册对应的cell
    [self.collectionView registerClass:[SearchCollectionViewCell class] forCellWithReuseIdentifier:@"item"];
    [self addSubview:self.collectionView];
    
    [flowLayout release];
}
#pragma collection view data source
// 返回cell 的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
// 返回cell分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"item";
    SearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
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

- (void)dealloc
{
    self.collectionView = nil;
    self.dataArray = nil;
    [super dealloc];
}

@end
