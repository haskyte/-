//
//  PlansViewController.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/17.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "PlansViewController.h"
#import "ForeignController.h"
#import "InlandViewController.h"
#import "NearbyViewController.h"

#define X self.view.frame.origin.x
#define Y self.view.frame.origin.y
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height

@interface PlansViewController ()<UIScrollViewDelegate>
@property (nonatomic, retain)UISegmentedControl *segmented;
@property (nonatomic, retain)UIScrollView *scrollView;
@end

@implementation PlansViewController

- (void)dealloc {
    self.segmented = nil;
    self.scrollView = nil;
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"旅行攻略";
    self.navigationController.navigationBar.translucent = NO;
    
    [self creatSegmented];
    [self creatScrollView];


}

- (void)creatSegmented {
    self.segmented = [[UISegmentedControl alloc] initWithItems:@[@"国内",@"国外",@"附近"]];
    self.segmented.frame = CGRectMake(X, Y, WIDTH, HEIGHT / 20);
    self.segmented.selectedSegmentIndex = 0;
    [self.segmented addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmented];
}

- (void)changeView:(UISegmentedControl *)segmentedControl {
    if (segmentedControl.selectedSegmentIndex == 0) {
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }else if (segmentedControl.selectedSegmentIndex == 1) {
        self.scrollView.contentOffset = CGPointMake(WIDTH, 0);
    }else {
        self.scrollView.contentOffset = CGPointMake(WIDTH *2, 0);
    }
}


- (void)creatScrollView {
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(X, Y + HEIGHT / 20, WIDTH, HEIGHT)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(WIDTH * 3, 0);
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    
    ForeignController *foreign = [[ForeignController alloc] init];
    foreign.view.frame = CGRectMake(X, Y, WIDTH, HEIGHT);
    foreign.nav = self.navigationController;
    [self.scrollView addSubview:foreign.view];
    
    InlandViewController *inland = [[InlandViewController alloc] init];
    inland.view.frame = CGRectMake(WIDTH, Y, WIDTH, HEIGHT);
    inland.nav = self.navigationController;
    [self.scrollView addSubview:inland.view];
    
    NearbyViewController *nearby = [[NearbyViewController alloc] init];
    nearby.view.frame = CGRectMake(WIDTH * 2, Y, WIDTH, HEIGHT);
    nearby.nav = self.navigationController;
    [self.scrollView addSubview:nearby.view];
    
    
    [foreign release];
    [inland release];
    [nearby release];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint offSet = scrollView.contentOffset;
    self.segmented.selectedSegmentIndex = offSet.x / WIDTH;
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
