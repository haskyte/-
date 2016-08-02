//
//  TripsViewController.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/18.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "TripsViewController.h"
#import "TravelView.h"
#import "TopicView.h"
#import "ZoneViewController.h"
#import "Helper.h"
#import "SetupTableViewController.h"
#import "SearchViewController.h"

#define SCREENWIDE self.view.frame.size.width
#define SCREENHEIGHT self.view.frame.size.height

@interface TripsViewController ()<UIScrollViewDelegate>

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UISegmentedControl *segmentControl;
@end

@implementation TripsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [[Helper shareWithHelper] getNavigaitonController:self.navigationController];
    self.title = @"游记";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"SettingBarButton"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"SearchBarButton"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    [self creatSegmentControl];
    [self crearScrollView];
}
// 点击设置按钮
- (void)leftBarButtonItemAction:(UIBarButtonItem *)item{
    SetupTableViewController *setupVC = [[SetupTableViewController alloc] init];
    [self.navigationController pushViewController:setupVC animated:YES];
    [setupVC release];
}
// 点击搜索按钮
- (void)rightBarButtonItemAction:(UIBarButtonItem *)item{
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    UINavigationController *navigationControl = [[UINavigationController alloc]initWithRootViewController:searchVC];
    self.modalPresentationStyle = UIModalPresentationPopover;
    self.modalTransitionStyle =UIModalTransitionStyleCrossDissolve;
    [self presentViewController:navigationControl animated:YES completion:nil];
    
    [navigationControl release];
    [searchVC release];
}


// 创建SegmentControl
- (void)creatSegmentControl{
    self.segmentControl = [[[UISegmentedControl alloc] initWithItems:@[@"游记",@"专题"]]autorelease];
    self.segmentControl.frame = CGRectMake(0, 64, SCREENWIDE, 30);
    self.segmentControl.backgroundColor = [UIColor whiteColor];
    self.segmentControl.selectedSegmentIndex = 0;
    [self.segmentControl addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentControl];
    [_segmentControl release];
}
- (void)changeView:(UISegmentedControl *)segment{
    if (segment.selectedSegmentIndex == 0) {
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }else{
        self.scrollView.contentOffset = CGPointMake(SCREENWIDE, 0);
    }
}
// 创建ScrollView
- (void)crearScrollView{
    self.scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 94,SCREENWIDE, SCREENHEIGHT - 94)]autorelease];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(2 * SCREENWIDE , SCREENHEIGHT - 94);
    [self.view addSubview:self.scrollView];
    self.scrollView.delegate = self;
    // 创建表视图
    TravelView *travelView = [[TravelView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDE, SCREENHEIGHT - 94)];
    TopicView *topicView = [[TopicView alloc] initWithFrame:CGRectMake(SCREENWIDE, 0, SCREENWIDE, SCREENHEIGHT - 94)];
    [self.scrollView addSubview:travelView];
    [self.scrollView addSubview:topicView];
    
    [travelView release];
    [topicView release];
    [_scrollView release];
}
// ScrollViewDelegate 根据scrollView偏移量设置segmentController默认值
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint point = self.scrollView.contentOffset;
    self.segmentControl.selectedSegmentIndex = point.x/SCREENWIDE;
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
    self.segmentControl = nil;
    self.scrollView = nil;
    [super dealloc];
}

@end
