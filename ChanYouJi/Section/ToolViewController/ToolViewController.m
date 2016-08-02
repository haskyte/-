//
//  ToolViewController.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/17.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "ToolViewController.h"
#import "MapViewController.h"
#import "TempViewController.h"
#import "ShowTempModel.h"
#import "NetWorkManager.h"
#import "XushiModel.h"
#import "NotepadTableViewController.h"


#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface ToolViewController ()

@property (nonatomic,retain)UILabel * tempLabel;

@property (nonatomic,retain)UILabel * minLabel;
@property (nonatomic,retain)UILabel * maxLabel;
@property (nonatomic,retain)UILabel * hengLabel;
@property (nonatomic,retain)UIView * upView;
@property (nonatomic,retain)XushiModel * model;
@property (nonatomic,retain)UILabel * nilLabel;
@end

@implementation ToolViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString * str= [NSString stringWithFormat:@"https://chanyouji.com/api/wiki/destinations/infos/%@.json?page=1",[ShowTempModel manager].countryID];
    if ([ShowTempModel manager].countryID != nil) {
        [[NetWorkManager shareWithManager]getDataWithURL:str Method:@"GET" Parameters:nil Kind:50 OrContainChinese:NO success:^(id obj) {
            [ShowTempModel manager].countryID = obj[@"id"];
            [ShowTempModel manager].temp_min = obj[@"temp_min"];
            [ShowTempModel manager].temp_max = obj[@"temp_max"];
            [ShowTempModel manager].current_time = obj[@"current_time"];
            [self minLabel].text = [NSString stringWithFormat:@"%@°C",[ShowTempModel manager].temp_min];
            [self maxLabel].text = [NSString stringWithFormat:@"%@°C",[ShowTempModel manager].temp_max];
            [self hengLabel].text = [NSString stringWithFormat:@"目的地时间:%@",[ShowTempModel manager].current_time];
            NSLog(@"%@------",[ShowTempModel manager].temp_min);
            NSLog(@"%@******",[ShowTempModel manager].temp_max);
        } fail:^{
            [self getFail];
        }];
    }
    
}
- (void)getFail {
    NSLog(@"请求失败");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"旅行工具箱";
    self.navigationItem.rightBarButtonItem  = [[[UIBarButtonItem alloc]initWithTitle:@"目的地 >" style:UIBarButtonItemStylePlain target:self action:@selector(clickEvent:)]autorelease];
    
    
    self.upView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 200)];
    self.upView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    //self.upView.alpha = 0.1;
    [self.view addSubview:self.upView];
    [self.upView release];
    
    
    
    
    //    UIButton * translateButton = [UIButton buttonWithType:UIButtonTypeSystem];
    //    translateButton.frame = CGRectMake(0, HEIGHT/3+64, WIDTH/2, (HEIGHT-HEIGHT/3-113)/2);
    //    //translateButton.backgroundColor = [UIColor redColor];
    //    [translateButton setImage:[UIImage imageNamed:@"ToolboxItem6_Normal@3x.png"] forState:UIControlStateNormal];
    //    [translateButton addTarget:self action:@selector(clickTranslateButton:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:translateButton];
    //
    //    UIButton * moneyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    //    moneyButton.frame = CGRectMake(WIDTH/2, HEIGHT/3+64, WIDTH/2, (HEIGHT-HEIGHT/3-113)/2);
    //    //moneyButton.backgroundColor = [UIColor greenColor];
    //    [moneyButton setImage:[UIImage imageNamed:@"ToolboxItem3_Normal@3x.png"] forState:UIControlStateNormal];
    //    [moneyButton addTarget:self action:@selector(clickMoneyButton:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:moneyButton];
    
    UIButton * travelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    travelButton.frame = CGRectMake(0, (HEIGHT/3+64)+(HEIGHT-HEIGHT/3-113)/2-100, WIDTH/2, (HEIGHT-HEIGHT/3-113)/2);
    //travelButton.backgroundColor = [UIColor yellowColor];
    [travelButton setImage:[UIImage imageNamed:@"ToolboxItem7_Normal@2x.png"] forState:UIControlStateNormal];
    [travelButton addTarget:self action:@selector(clickTravelButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:travelButton];
    
    UIButton * mapButton = [UIButton buttonWithType:UIButtonTypeSystem];
    mapButton.frame = CGRectMake(WIDTH/2, (HEIGHT/3+64)+(HEIGHT-HEIGHT/3-113)/2-100,WIDTH/2, (HEIGHT-HEIGHT/3-113)/2);
    //mapButton.backgroundColor = [UIColor orangeColor];
    [mapButton setImage:[UIImage imageNamed:@"ToolboxItem2_Normal@3x.png"] forState:UIControlStateNormal];
    [mapButton addTarget:self action:@selector(clickMapButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mapButton];
    //-------------------------------------
    //    UILabel * translateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,(HEIGHT/3+64)+(HEIGHT-HEIGHT/3-113)/2*2/3  , WIDTH/2, 20)];
    //    translateLabel.text = @"语音翻译";
    //    translateLabel.font = [UIFont systemFontOfSize:13];
    //    translateLabel.textAlignment = NSTextAlignmentCenter;
    //    [self.view addSubview:translateLabel];
    //
    //    UILabel * moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2,(HEIGHT/3+64)+(HEIGHT-HEIGHT/3-113)/2*2/3  , WIDTH/2, 20)];
    //    moneyLabel.text = @"实时汇率";
    //    moneyLabel.font = [UIFont systemFontOfSize:13];
    //    moneyLabel.textAlignment = NSTextAlignmentCenter;
    //    [self.view addSubview:moneyLabel];
    
    UILabel * travelLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,(HEIGHT/3+64)+(HEIGHT-HEIGHT/3-113)/2+(HEIGHT-HEIGHT/3-113)/2*2/3-100, WIDTH/2, 20)];
    travelLabel.text = @"旅行记账";
    travelLabel.font = [UIFont systemFontOfSize:13];
    travelLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:travelLabel];
    
    UILabel * mapLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2,(HEIGHT/3+64)+(HEIGHT-HEIGHT/3-113)/2+(HEIGHT-HEIGHT/3-113)/2*2/3-100, WIDTH/2, 20)];
    mapLabel.text = @"行程地图";
    mapLabel.font = [UIFont systemFontOfSize:13];
    mapLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:mapLabel];
    
    
    //--------*********/-------------------------------------
    UILabel * minLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/13, 20, WIDTH/13*4, 80)];
    //minLabel.backgroundColor = [UIColor lightGrayColor];
    minLabel.textColor = [UIColor greenColor];
    minLabel.text = @"21°C";
    minLabel.font = [UIFont systemFontOfSize:33];
    minLabel.textAlignment = NSTextAlignmentRight;
    self.minLabel= minLabel;
    [self.upView addSubview:minLabel];
    [minLabel release];
    
    UILabel * maxLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/13*8, 20,WIDTH/13*4, 80)];
    maxLabel.textColor = [UIColor redColor];
    //maxLabel.backgroundColor = [UIColor cyanColor];
    maxLabel.text = @"32°C";
    maxLabel.font = [UIFont systemFontOfSize:33];
    maxLabel.textAlignment = NSTextAlignmentLeft;
    self.maxLabel = maxLabel;
    [self.upView addSubview:maxLabel];
    [maxLabel release];
    
    UILabel * nilLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/13*6, 20, WIDTH/13, 80)];
    nilLabel.textColor = [UIColor whiteColor];
    nilLabel.text = @"--";
    //nilLabel.backgroundColor = [UIColor cyanColor];
    nilLabel.font = [UIFont systemFontOfSize:33];
    nilLabel.textAlignment = NSTextAlignmentLeft;
    self.nilLabel = nilLabel;
    [self.upView addSubview:nilLabel];
    [nilLabel release];
    
    UILabel * hengLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 120, WIDTH-20, 40)];
    //hengLabel.backgroundColor = [UIColor cyanColor];
    hengLabel.textAlignment = NSTextAlignmentCenter;
    hengLabel.text = @"目的地时间: AM  18:32  周六";
    self.hengLabel = hengLabel;
    [self.upView addSubview:hengLabel];
    [hengLabel release];
    
    
    
    
    
}//--------------------

- (void)clickEvent:(UIBarButtonItem *)item {
    TempViewController * mapVC = [[TempViewController alloc]init];
    mapVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mapVC animated:YES];
}

- (void)clickTranslateButton:(UIButton *)item {
    
}
- (void)clickMoneyButton:(UIButton *)item {
    
}
- (void)clickTravelButton:(UIButton *)item {   //旅行记账
    
    NotepadTableViewController * notepadTVC = [[NotepadTableViewController alloc]init];
    notepadTVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:notepadTVC animated:YES];
    [notepadTVC release];
    
}
- (void)clickMapButton:(UIButton *)item {
    MapViewController * mapVC = [[MapViewController alloc]init];
    mapVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mapVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc{
    self.tempLabel = nil;
    [super dealloc];
}

//    TempViewController * choose = [[TempViewController alloc] init];
//    choose.modalPresentationStyle = UIModalPresentationFullScreen;
//    choose.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//    UINavigationController * root = [[UINavigationController alloc] initWithRootViewController:choose];
//    [self presentViewController:root animated:YES completion:nil];
//
//    [choose release];
//    [root release];

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
