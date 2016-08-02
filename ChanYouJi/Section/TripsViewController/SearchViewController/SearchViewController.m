//
//  SearchViewController.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "SearchViewController.h"
#import "OverseasView.h"
#import "DomesticView.h"
#import "SeasonView.h"
#import "Helper.h"
#import "SeekTableViewController.h"

#define SCREENWIDE [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
@interface SearchViewController ()<UISearchBarDelegate>

@property (nonatomic, retain)OverseasView *overseaView;
@property (nonatomic, retain)DomesticView *domesticView;
@property (nonatomic, retain)SeasonView *seasonView;

@end

@implementation SearchViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[Helper shareWithHelper]getSearchNavigationController:self.navigationController];
    
    [self creatSearchBar];
    [self creatSegmentControl];
    [self creatCollectionView];
    
}
// 创建searchBar
- (void)creatSearchBar{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0 green:150/255.0 blue:1.0 alpha:1];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(returnTripsVC:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10,  20,SCREENWIDE - 60, 40)];
    searchBar.layer.borderWidth = 2;
    searchBar.layer.borderColor = [UIColor colorWithRed:0 green:150/255.0 blue:1.0 alpha:1].CGColor;
//    searchBar.barTintColor = [UIColor colorWithRed:0 green:150/255.0 blue:1.0 alpha:1];
    searchBar.barTintColor = [UIColor redColor];

    [self.navigationController.view addSubview:searchBar];
    searchBar.placeholder = @"搜索游记、旅行地";
    searchBar.delegate = self;
}
// 创建segmentController
- (void)creatSegmentControl{
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"国外",@"国内",@"四季", nil]];
    segmentControl.frame = CGRectMake(0, 64, SCREENWIDE, 40);
    segmentControl.selectedSegmentIndex = 0;
    segmentControl.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:segmentControl];
    [segmentControl addTarget:self action:@selector(exchangeView:) forControlEvents:UIControlEventValueChanged];
}
//界面切换
- (void)exchangeView:(UISegmentedControl *)segmentControl{
    if (segmentControl.selectedSegmentIndex == 0) {
        [self.view bringSubviewToFront:self.overseaView];
    }else if (segmentControl.selectedSegmentIndex == 1){
        [self.view bringSubviewToFront:self.domesticView];
    }else{
        [self.view bringSubviewToFront:self.seasonView];
    }
}
// 添加视图
- (void)creatCollectionView{
    self.overseaView= [[[OverseasView alloc] initWithFrame:CGRectMake(0, 104, SCREENWIDE, SCREENHEIGHT - 104)]autorelease];
    self.domesticView= [[[DomesticView alloc] initWithFrame:CGRectMake(0, 104, SCREENWIDE, SCREENHEIGHT - 104)]autorelease];
    self.seasonView = [[[SeasonView alloc] initWithFrame:CGRectMake(0, 104, SCREENWIDE, SCREENHEIGHT - 104)]autorelease];
    [self.view addSubview:self.seasonView];
    [self.view addSubview:self.domesticView];
    [self.view addSubview:self.overseaView];
}
//单击search进行搜索；
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    SeekTableViewController *seekVC = [[SeekTableViewController alloc] init];
    UINavigationController *navigationControl = [[UINavigationController alloc] initWithRootViewController:seekVC];
    [self.navigationController presentViewController:navigationControl animated:YES completion:nil];
    seekVC.searchText = [searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [seekVC release];
    [navigationControl release];
}
// 返回主界面
- (void)returnTripsVC:(UIBarButtonItem *)item{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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

- (void)dealloc
{
    self.overseaView = nil;
    self.domesticView = nil;
    self.seasonView = nil;
    [super dealloc];
}

@end
