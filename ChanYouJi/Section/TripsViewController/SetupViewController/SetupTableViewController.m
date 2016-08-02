//
//  SetupTableViewController.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/25.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "SetupTableViewController.h"
#import "LandTableViewCell.h"
#import "ProposeViewController.h"
#import "SendMessageViewController.h"
#import "UIImageView+WebCache.h"
#import "UMSocial.h"

@interface SetupTableViewController ()<UMSocialUIDelegate>

@end

@implementation SetupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView = [[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped] autorelease];
    self.navigationItem.title = @"设置";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackBarButton"] style:UIBarButtonItemStylePlain target:self action:@selector(returnTripsVCWithItem:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
}
- (void)returnTripsVCWithItem:(UIBarButtonItem *)item{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        return 3;
    }else{
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"]autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
        CGFloat fileSize = [self folderSizeAtPath:cachesPath];
        NSString *string = [NSString stringWithFormat:@"清除浏览缓存   %.2fM",fileSize];
        NSArray *array = [NSArray arrayWithObjects:@"给开发者提意见",@"连接社交网络",string, nil];
        switch (indexPath.row) {
            case 0:
                cell.imageView.image = [UIImage imageNamed:@"IconSetting0"];
                break;
            case 1:
                cell.imageView.image = [UIImage imageNamed:@"IconSetting2"];
                break;
            case 2:
                cell.imageView.image = [UIImage imageNamed:@"IconSetting4"];
                break;
            default:
                break;
        }
        
        cell.textLabel.text = array[indexPath.row];
        return cell;
    }else{
//        LandTableViewCell *cell = [[[LandTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"button"]autorelease];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ProposeViewController *proposeVC = [[[ProposeViewController alloc] init]autorelease];
            [self.navigationController pushViewController:proposeVC animated:YES];
        }else if (indexPath.row == 1){
            //去appstore评价/
            [UMSocialSnsService presentSnsIconSheetView:self appKey:nil shareText:@"分享" shareImage:nil shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToQQ,UMShareToRenren,UMShareToTencent, nil] delegate:self];
            
        }else if (indexPath.row == 2){
            NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
            [[NSFileManager defaultManager] removeItemAtPath:cachesPath error:nil];
            [self.tableView reloadData];
            ///@"连接社交网络/
            
        }
    }
}

// 获得文件夹的大小
- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];//从前向后枚举器／／／／//
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }

    return folderSize/(1024.0*1024.0);
}
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
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
