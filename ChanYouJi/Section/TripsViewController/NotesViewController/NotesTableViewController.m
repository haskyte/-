//
//  NotesTableViewController.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/22.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "NotesTableViewController.h"
#import "UIImageView+WebCache.h"
#import "ZoneViewController.h"
#import "NetWorkManager.h"
#import "NoteModel.h"
#import "NoteTableViewCell.h"
#import "UMSocial.h"

#define SCREENWIDE self.view.bounds.size.width
#define SCREENHEIGHT self.view.bounds.size.height
@interface NotesTableViewController ()<UMSocialUIDelegate>

@property (nonatomic, retain) NSMutableArray *headArray;
@property (nonatomic, retain) NSMutableDictionary *cellDic;
@property (nonatomic, retain) NSMutableArray *allkeys;
@property (nonatomic, retain) NSMutableArray *cellArray;

@end

@implementation NotesTableViewController

- (void)dealloc
{
    self.headArray = nil;
    self.cellDic= nil;
    self.allkeys = nil;
    self.cellArray = nil;
    [super dealloc];
}

// 懒加载初始化

- (NSMutableArray *)cellArray{
    if (_cellArray == nil) {
        self.cellArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _cellArray;
}
- (NSMutableArray *)headArray{
    if (_headArray == nil) {
        self.headArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _headArray;
}
- (NSMutableDictionary *)cellDic{
    if (_cellDic == nil) {
        self.cellDic = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _cellDic;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor whiteColor];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    // 请求网络数据

    [[NetWorkManager shareWithManager]getDataWithURL:[NSString stringWithFormat:@"https://chanyouji.com/api/trips/%@.json",self.tripsID] Method:@"GET" Parameters:nil Kind:50 OrContainChinese:NO success:^(id obj) {
        [self getDataSuccessWithObject:obj];
    } fail:^{
        NSLog(@"NOTE数据请求失败");
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackBarButton"] style:UIBarButtonItemStylePlain target:self action:@selector(returnVCWithItem:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ShareBarButton"] style:UIBarButtonItemStylePlain target:self action:@selector(shareButtonAction:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    
}
// 分享界面
- (void)shareButtonAction:(UIBarButtonItem *)item{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:nil shareText:@"分享" shareImage:nil shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToQQ,UMShareToRenren,UMShareToTencent, nil] delegate:self];
}
- (void)returnVCWithItem:(UIBarButtonItem *)item{
    [self.navigationController popViewControllerAnimated:YES];
}
// 数据请求成功
- (void)getDataSuccessWithObject:(id)object{
    // 存储区头数据
    NSArray *array = object[@"trip_days"];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NoteModel *noteModel = [NoteModel noteModelWithDic:obj];
        [self.headArray addObject:noteModel];
    }];
    //存储cell数据
    NSMutableArray *array3 = [@[] mutableCopy];
    NSMutableArray *array1 = object[@"trip_days"];
    NSMutableArray *allkeys = [NSMutableArray arrayWithCapacity:0];
//    NSMutableArray *array5 = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < array1.count; i ++) {
        NSDictionary *dic = array1[i];
        NSArray *array2 = dic[@"nodes"];
        NSMutableArray *array4 = [@[] mutableCopy];
        for (NSDictionary *dic1 in array2) {
            array3 = dic1[@"notes"];
            
            for (NSDictionary *dic in array3) {
                NoteModel *noteModel = [NoteModel noteModelWithDic:dic];
                [array4 addObject:noteModel];
            }
        }
        NSString *str = [NSString stringWithFormat:@"%d",i];
        [allkeys addObject:str];
        [self.cellArray addObject:array4];
    }
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
// 返回分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return self.headArray.count + 1;
}
 // 返回分区行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }

//    return valueArray.count;
       NSArray *array = self.cellArray[section -1];
    return array.count;
}
// 返回区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        if (self.travelModel.photoImage == nil) {
            return 0;
        }else{
            return SCREENHEIGHT/3;
        }
    }else{
        return 20;
    }
}
// 自定义区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;{
    if (section == 0) {
        UIImageView *photoImage = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDE, SCREENHEIGHT/3)]autorelease];
        NSURL *url = [NSURL URLWithString:self.travelModel.photoImage];
        [photoImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeHolder"]];
        photoImage.userInteractionEnabled = YES;
        // 用户头像
        UIImageView *userImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, SCREENHEIGHT/3 - SCREENHEIGHT/18 -10, SCREENHEIGHT/18, SCREENHEIGHT/18)];
        userImage.layer.cornerRadius = SCREENHEIGHT/36;
        userImage.layer.masksToBounds = YES;
        userImage.layer.borderWidth = 1;
        userImage.layer.borderColor = [UIColor whiteColor].CGColor;
        userImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToZoneView:)];
        [userImage addGestureRecognizer:tap];
        NSURL *userURL = [NSURL URLWithString:self.travelModel.userImage];
        [userImage sd_setImageWithURL:userURL];
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 + SCREENHEIGHT/ 18, SCREENHEIGHT/3 - SCREENHEIGHT/ 18 -10, SCREENWIDE, SCREENHEIGHT / 36)];
        nameLabel.text = self.travelModel.name;
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.textColor = [UIColor whiteColor];
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 + SCREENHEIGHT/ 18, SCREENHEIGHT/3 - SCREENHEIGHT/ 36 -10, SCREENWIDE, SCREENWIDE/36)];
        dateLabel.text = [NSString stringWithFormat:@"%@/%@天/%@图",self.travelModel.startDate,self.travelModel.days,self.travelModel.photosCount];
        dateLabel.textColor = [UIColor whiteColor];
        dateLabel.font = [UIFont systemFontOfSize:12];
        
        [photoImage addSubview:dateLabel];
        [photoImage addSubview:nameLabel];
        [photoImage addSubview:userImage];
        [userImage release];
        [dateLabel release];
        [nameLabel release];
        return photoImage;
    }else{
        UILabel *label = [[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDE, 20)]autorelease];
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
        label.font = [UIFont systemFontOfSize:14];
        NoteModel *noteModel = self.headArray[section - 1];
        NSString *str = [NSString stringWithFormat:@"%@",noteModel.tripDate];
        if ([str isEqualToString:@"<null>"]) {
            label.text = [NSString stringWithFormat:@"DAY%@",noteModel.dayCount];
            return label;
        }
        label.text = [NSString stringWithFormat:@"DAY%@  %@",noteModel.dayCount,str];

        return label;
    }
}
// 跳转到用户界面
- (void)pushToZoneView:(UIGestureRecognizer *)tap{
    ZoneViewController *zoneVC = [[ZoneViewController alloc] init];
    zoneVC.userID = self.travelModel.userID;
    [self.navigationController pushViewController:zoneVC animated:YES];
}

// 返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return nil;
    }
    static NSString *idenf = @"noteCell";
    NoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idenf];
    if (cell == nil) {
        cell = [[[NoteTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:idenf]autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSArray *array = self.cellArray[indexPath.section - 1];
    cell.noteModel = array[indexPath.row];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSArray *array = self.cellArray[indexPath.section - 1];
    NoteModel * noteModel = array[indexPath.row];
    CGFloat photoHeight = [noteModel.photoImageHeight floatValue];
    CGFloat photoWidth = [noteModel.photoImageWide floatValue];
    NSString *str = [NSString stringWithFormat:@"%@",noteModel.notesDescription];
    
    if ([str isEqualToString:@"<null>"]) {
        
        return photoHeight * (SCREENWIDE - 20) / photoWidth + 10;
    }else{
        
        CGRect rect = [str boundingRectWithSize:CGSizeMake(375, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
        if (photoHeight == 0 && photoWidth == 0) {
            return rect.size.height + 20 ;
        }
        return photoHeight * (SCREENWIDE - 20) / photoWidth + rect.size.height + 20;
    }
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
