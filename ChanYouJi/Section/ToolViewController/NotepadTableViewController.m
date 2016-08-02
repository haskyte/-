//
//  NotepadTableViewController.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/29.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "NotepadTableViewController.h"
#import "AddViewController.h"
#import "NotepadTableViewCell.h"
#import "DataBaseHelper.h"
#import "Contect.h"

#import "DetailsViewController.h"

@interface NotepadTableViewController ()


@end

@implementation NotepadTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账单";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickAddEvent:)];
    
    //查询所有账单信息
    [[DataBaseHelper shareWithDataBaseHelper] findAllContect];

}
- (void)viewWillAppear:(BOOL)animated {
    //查询所有账单信息
    [[DataBaseHelper shareWithDataBaseHelper] findAllContect];
    [self.tableView reloadData];
}
- (void)clickAddEvent:(UIBarButtonItem *)item {
    AddViewController * addVC = [[AddViewController alloc]init];
    [self.navigationController pushViewController:addVC animated:YES];
    [addVC release];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return [DataBaseHelper shareWithDataBaseHelper].firstLetters.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    NSString *firstLetter = [DataBaseHelper shareWithDataBaseHelper].firstLetters[section];
   
    NSMutableArray *contects = [DataBaseHelper shareWithDataBaseHelper].contectsDic[firstLetter];
    return contects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ide = @"cell";
    NotepadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ide ];
    if (!cell) {
        cell = [[NotepadTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ide];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    Contect *contect = [[DataBaseHelper shareWithDataBaseHelper] findContectPerson:indexPath];
    //分别展示账单信息
    cell.nameDetails.text = contect.name;
    cell.moneyDetails.text = contect.money;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

// 点击cell 触发事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailsViewController *notesVC = [[DetailsViewController alloc] init];
    notesVC.hidesBottomBarWhenPushed = YES;
    
    Contect * contect = [[DataBaseHelper shareWithDataBaseHelper]findContectPerson:indexPath];

    
    
    NSLog(@"%@",contect);
    notesVC.nameStr = contect.name;
    notesVC.moneyStr = contect.money;
    notesVC.textStr = contect.remark;
//    notesVC.nameField.text = contect.name;
//    notesVC.moneyField.text = contect.money;
//    notesVC.textVIEW.text = contect.remark;
//    notesVC.hahah = contect.name;
    NSLog(@"++++++ %@",notesVC.nameField.text);
    NSLog(@"++++++ %@",notesVC.moneyField.text);
    NSLog(@"++++++ %@",notesVC.textVIEW.text);
//    NSLog(@"kkkk %@",notesVC.hahah);
//    [self.navigationController presentViewController:notesVC animated:YES completion:nil];
    
    [self.navigationController pushViewController:notesVC animated:YES];
    
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [[DataBaseHelper shareWithDataBaseHelper] deleteInforOfContect:indexPath];
         [self.tableView reloadData];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[DetailsViewController class]]) {
        //获得点击的cell
        NotepadTableViewCell *cell = (NotepadTableViewCell *)sender;
        //获得该cell对应的indexPath对象
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        NSLog(@"%@",sender);
        //查找对应的账单
        Contect *contect = [[DataBaseHelper shareWithDataBaseHelper ]findContectPerson:indexPath];
        //获得账单详情界面的视图控制器
        DetailsViewController *detail = (DetailsViewController *)segue.destinationViewController;
        detail.contect = contect;
        
    }

}


@end
