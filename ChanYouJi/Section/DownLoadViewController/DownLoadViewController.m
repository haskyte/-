//
//  DownLoadViewController.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/17.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "DownLoadViewController.h"

@interface DownLoadViewController ()

@property (nonatomic,retain)UISegmentedControl * segmentedControl;
@property (nonatomic,retain)UIScrollView * scrollView;

@end

@implementation DownLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"离线内容";
    
    self.segmentedControl = [[[UISegmentedControl alloc]initWithItems:@[@"游记",@"目的地"]]autorelease];
    self.segmentedControl.frame = CGRectMake(10, 74, self.view.frame.size.width-20, 30);
    self.segmentedControl.selectedSegmentIndex = 0;
    [self.segmentedControl addTarget:self action:@selector(changedView:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentedControl];
   
}

- (void)changedView:(UISegmentedControl *)segment{
    if (segment.selectedSegmentIndex == 0) {
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }else{
        self.scrollView.contentOffset = CGPointMake(self.view.frame.size.width, 0);
    }
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
    self.segmentedControl = nil;
    self.scrollView = nil;
    [super dealloc];
}

@end
