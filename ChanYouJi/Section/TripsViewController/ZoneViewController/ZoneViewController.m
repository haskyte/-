//
//  ZoneViewController.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/20.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "ZoneViewController.h"
#import "TripsView.h"
#import "FavouriteView.h"
#import "Helper.h"
#import "NetWorkManager.h"
#import "UIImageView+WebCache.h"

#define SCREENWIDE [UIScreen mainScreen].bounds.size.width
#define HEIGHT 64
#define USERVIEWHEIGHT ([UIScreen mainScreen].bounds.size.height - 64)/4
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
@interface ZoneViewController ()<UIScrollViewDelegate>

@property (nonatomic, retain) UISegmentedControl *segmentControl;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIImageView *photoImage;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *tripsLabel;
@property (nonatomic, retain) UIImageView *genderImage;

@end

@implementation ZoneViewController
// 懒加载
- (UIImageView *)photoImage{
    if (_photoImage == nil) {
        // 头像
        self.photoImage = [[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, USERVIEWHEIGHT/3, USERVIEWHEIGHT/3)]autorelease];
        
        _photoImage.layer.cornerRadius = USERVIEWHEIGHT/6;
        _photoImage.layer.masksToBounds = YES;
    }
    return _photoImage;
}
- (UILabel *)nameLabel{
    // 昵称
    if (_nameLabel == nil) {
        self.nameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(15 + USERVIEWHEIGHT/3, 10, SCREENWIDE/2 , USERVIEWHEIGHT/6)]autorelease];
        _nameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _nameLabel;
}
-(UILabel *)tripsLabel{
    if (_tripsLabel == nil) {
        // 游记数量
        self.tripsLabel = [[[UILabel alloc]initWithFrame:CGRectMake(20 + USERVIEWHEIGHT/6 + USERVIEWHEIGHT/3, 10 + USERVIEWHEIGHT/6, SCREENWIDE/2, USERVIEWHEIGHT/6)]autorelease];
        _tripsLabel.font = [UIFont systemFontOfSize:12];

    }
    return _tripsLabel;
}

- (UIImageView *)genderImage{
    if (_genderImage == nil) {
        self.genderImage = [[[UIImageView alloc] initWithFrame:CGRectMake(15 + USERVIEWHEIGHT/3, 10 + USERVIEWHEIGHT/6, USERVIEWHEIGHT/6, USERVIEWHEIGHT/6)]autorelease];
        _genderImage.layer.cornerRadius = USERVIEWHEIGHT/ 12;
        _genderImage.layer.masksToBounds = YES;
    }
    return _genderImage;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackBarButton"] style:UIBarButtonItemStylePlain target:self action:@selector(returnTripsVCWithItem:)];
 
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    [[Helper shareWithHelper]getViewController:self];
    [self creatUserBoard];
    [self creatScrollView];
    // Do any additional setup after loading the view.
    [[NetWorkManager shareWithManager]getDataWithURL:[NSString stringWithFormat:@"https://chanyouji.com/api/users/%@.json?page=1 HTTP/1.1",self.userID] Method:@"GET" Parameters:nil Kind:30 OrContainChinese:YES success:^(id obj) {
        [self getUserDataWithObject:obj];
    } fail:^{
        NSLog(@"用户信息请求失败");
    }];
    
}
// 请求用户信息
- (void)getUserDataWithObject:(id)obj{
    NSMutableDictionary *dic = (NSMutableDictionary *)obj;
    self.nameLabel.text = dic[@"name"];
    self.tripsLabel.text = [NSString stringWithFormat:@"%@篇游记",dic[@"trips_count"]];
    NSURL *url = [NSURL URLWithString:dic[@"image"]];
    [self.photoImage sd_setImageWithURL:url];
    self.navigationItem.title = self.nameLabel.text;
    CGFloat gender = [dic[@"gender"] floatValue];
    if (gender == 0) {
        self.genderImage.image = [UIImage imageNamed:@"IconFemale"];
    }else{
        self.genderImage.image = [UIImage imageNamed:@"IconMale"];
    }
}



// 返回主列表界面
- (void)returnTripsVCWithItem:(UIBarButtonItem *)item{
    [self.navigationController popViewControllerAnimated:YES];
}
// 创建用户简介界面
- (void)creatUserBoard{
    UIView *userView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT, SCREENWIDE, (SCREENHEIGHT - 64)/4)];
    userView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:userView];


    // button
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeSystem];
    addButton.frame = CGRectMake(10, USERVIEWHEIGHT/3 + 15, SCREENWIDE/2 - 15, USERVIEWHEIGHT/3 - 20);
    addButton.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [addButton setTitle:@"关注他" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *messageButton = [UIButton buttonWithType:UIButtonTypeSystem];
    messageButton.frame = CGRectMake(SCREENWIDE/2 + 5, USERVIEWHEIGHT/3 + 15, SCREENWIDE/2 - 15, USERVIEWHEIGHT/3 - 20);
    messageButton.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [messageButton setTitle:@"发私信" forState:UIControlStateNormal];
    [messageButton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [userView addSubview:self.photoImage];
    [userView addSubview:self.nameLabel];
    [userView addSubview:self.tripsLabel];
    [userView addSubview:addButton];
    [userView addSubview:messageButton];
    [userView addSubview:self.genderImage];

    self.segmentControl = [[[UISegmentedControl alloc]initWithItems:@[@"游记",@"喜欢"]]autorelease];
    self.segmentControl.frame = CGRectMake(0, USERVIEWHEIGHT/3 * 2, SCREENWIDE, USERVIEWHEIGHT/3);
    self.segmentControl.backgroundColor = [UIColor whiteColor];
    self.segmentControl.selectedSegmentIndex = 0;
    [self.segmentControl addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventValueChanged];
    [userView addSubview:self.segmentControl];
    [_segmentControl release];
    [_tripsLabel release];
    [_nameLabel release];
    [_photoImage release];
    [userView release];
}

- (void)addButtonAction:(UIButton *)button{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请关注版本内容更新" message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles: nil];
    [alertView show];
}




- (void)changeView:(UISegmentedControl *)segment{
    if (segment.selectedSegmentIndex == 0) {
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }else{
        self.scrollView.contentOffset = CGPointMake(SCREENWIDE, 0);
    }
}
// 创建详细界面滚动视图
- (void)creatScrollView{
    self.scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, USERVIEWHEIGHT + 64, SCREENWIDE, USERVIEWHEIGHT * 3)]autorelease];
    [self.view addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake(SCREENWIDE * 2, USERVIEWHEIGHT * 3);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    TripsView *tripsView = [[TripsView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDE, USERVIEWHEIGHT * 3)];
    FavouriteView *favView = [[FavouriteView alloc] initWithFrame:CGRectMake(SCREENWIDE, 0, SCREENWIDE, USERVIEWHEIGHT * 3)];
    [self.scrollView addSubview:tripsView];
    [self.scrollView addSubview:favView];
    
    
    [_scrollView release];
    [tripsView release];
    [favView release];
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
    self.userID = nil;
    self.scrollView = nil;
    self.segmentControl = nil;
    [super dealloc];
}
@end
