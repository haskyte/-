//
//  SeasonView.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "SeasonView.h"
#import "SearchCollectionViewCell.h"
#import "SearchModel.h"
#import "SearchResultTableViewController.h"
#import "Helper.h"
@interface SeasonView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *dataArray;

@end



@implementation SeasonView
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
        // 创建collectionView
        [self creatCollectionView];
        self.dataArray = [NSMutableArray arrayWithObjects:@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月", nil];
    }
    return self;
}

- (void)creatCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout]autorelease];
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    [self addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[SearchCollectionViewCell class] forCellWithReuseIdentifier:@"item"];
    [flowLayout release];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    cell.nameLabel.text = self.dataArray[indexPath.row];
    cell.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
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
    
    searchResultVC.countryId = [NSString stringWithFormat:@"month/%ld",indexPath.row +1];
    searchResultVC.titleName = [NSString stringWithFormat:@"%ld月",indexPath.row +1];
    searchResultVC.destinations = @"";
    [searchResultVC release];
    [navigationC release];
}


@end
