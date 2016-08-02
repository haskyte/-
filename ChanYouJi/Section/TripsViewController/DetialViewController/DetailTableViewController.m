//
//  DetailTableViewController.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/23.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "DetailTableViewController.h"
#import "UIImageView+WebCache.h"
#import "NetWorkManager.h"
#import "TopicModel.h"
#import "DetailModel.h"
#import "DetailTableViewCell.h"
#import "Helper.h"
#import "UMSocial.h"

#define SCREENWIDE [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
@interface DetailTableViewController ()<UMSocialUIDelegate>

@property (nonatomic, retain) NSMutableArray *dataArray;

//
@property (nonatomic, retain) UIImageView *photoImage;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *nameLabel;

@end

@implementation DetailTableViewController
// 懒加载初始化
- (UIImageView *)photoImage{
    if (_photoImage == nil) {
        self.photoImage = [[[UIImageView alloc] init]autorelease];
        
    }
    return _photoImage;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        self.titleLabel = [[[UILabel alloc]initWithFrame:CGRectMake(10, SCREENHEIGHT/6 - 35, SCREENWIDE - 20, 30)]autorelease];
        _titleLabel.text = self.topicModel.title;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:20];
    }
    return _titleLabel;
}
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        self.nameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, SCREENHEIGHT/6 + 5, SCREENWIDE - 20, 10)]autorelease];
        _nameLabel.text = self.topicModel.name;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _nameLabel;
}

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        self.dataArray = [[@[] mutableCopy]autorelease];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[Helper shareWithHelper]getDetailNavigaitonController:self.navigationController];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackBarButton"] style:UIBarButtonItemStylePlain target:self action:@selector(returnVCWithItem:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ShareBarButton"] style:UIBarButtonItemStylePlain target:self action:@selector(shareButtonAction:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [[NetWorkManager shareWithManager]getDataWithURL:[NSString stringWithFormat:@"https://chanyouji.com/api/articles/%@.json?page=1",self.topicID] Method:@"GET" Parameters:nil Kind:70 OrContainChinese:NO success:^(id obj) {
        [self getDataSuccessWithObject:obj];
    } fail:^{
        NSLog(@"Detail数据请求失败");
    }];
    
}
// 分享界面
- (void)shareButtonAction:(UIBarButtonItem *)item{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:nil shareText:@"分享" shareImage:nil shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToQQ,UMShareToRenren,UMShareToTencent, nil] delegate:self];
}
// 返回上一个界面
- (void)returnVCWithItem:(UIBarButtonItem *)item{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getDataSuccessWithObject:(id)object{
    NSURL *url = [NSURL URLWithString:object[@"image_url"]];
    [self.photoImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    self.titleLabel.text = object[@"title"];
    self.nameLabel.text = object[@"name"];
    NSMutableArray *array = object[@"article_sections"];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        DetailModel *detailModel = [DetailModel detailModelWithDic:obj];
        [self.dataArray addObject:detailModel];
    }];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - Table view data source
// 返回分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}
// 返回分区行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section != 0) {
        return self.dataArray.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return nil;
    }
    static NSString *indetifie = @"detailCell";
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indetifie];
    if (cell == nil) {
        cell = [[[DetailTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indetifie]autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.detailModel = self.dataArray[indexPath.row];

    return cell;
    
}
// 返回cell 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailModel *detailModel = self.dataArray[indexPath.row];
    CGFloat height = [detailModel.imageHeight floatValue];
    CGFloat width = [detailModel.imageWidth floatValue];
    CGFloat photoHeight = height * (SCREENWIDE - 20) / width;
    
    CGRect rect = [detailModel.imageDescription boundingRectWithSize:CGSizeMake(300, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    CGRect rect1 = [detailModel.title boundingRectWithSize:CGSizeMake(300, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];

    if (height == 0 && width == 0 ) {
        if (detailModel.title.length == 0) {
            return rect.size.height;
        }
        return rect.size.height + rect1.size.height ;
    }
    return photoHeight +rect.size.height + rect1.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return SCREENHEIGHT/3;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
    
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, SCREENHEIGHT/6 -10 , SCREENWIDE - 20 , 10)];
        lineLabel.textColor = [UIColor whiteColor];
        lineLabel.textAlignment = NSTextAlignmentCenter;
        lineLabel.text = [NSString stringWithFormat:@"--------------------------"];
        
        [self.photoImage addSubview:self.nameLabel];
        [self.photoImage addSubview:self.titleLabel];
        [self.photoImage addSubview:lineLabel];
        [lineLabel release];
        
        return self.photoImage;
    }
    return nil;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
