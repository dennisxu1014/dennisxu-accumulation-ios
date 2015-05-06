//
//  StudyMainTableViewController.m
//  ProjectAccumulation
//
//  Created by XuYang on 15/4/8.
//  Copyright (c) 2015年 XuYang. All rights reserved.
//

#import "StudyMainTableViewController.h"
#import "OCMessageViewController.h"
#import "RuntimeCreateClassViewController.h"
#import "KVCKVOViewController.h"
#import "BlockViewController.h"
#import "MemoryManagerMRCViewController.h"
#import "ThreadViewController.h"
@interface StudyMainTableViewController ()

@end

@implementation StudyMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    [tableview setDelegate:self];
    [tableview setDataSource:self];
    [self.view addSubview:tableview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if(indexPath.row == 0){
        [cell.textLabel setText:@"OC消息"];
    }else if(indexPath.row == 1){
        [cell.textLabel setText:@"运行时创建Class"];
    }else if(indexPath.row == 2){
        [cell.textLabel setText:@"KVC与KVO"];
    }else if(indexPath.row ==3){
        [cell.textLabel setText:@"block"];
    }else if(indexPath.row ==4){
        [cell.textLabel setText:@"内存管理MRC"];
    }else if(indexPath.row ==5){
        [cell.textLabel setText:@"线程操作"];
    }
 return cell;
 }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *resultVC = nil;
    if(indexPath.row==0){
        resultVC = [[OCMessageViewController alloc]init];
    }else if(indexPath.row==1){
        resultVC = [[RuntimeCreateClassViewController alloc]init];
    }else if(indexPath.row == 2){
        resultVC = [[KVCKVOViewController alloc]init];
    }else if(indexPath.row == 3){
        resultVC = [[BlockViewController alloc]init];
    }else if(indexPath.row ==4){
        resultVC = [[MemoryManagerMRCViewController alloc]init];
    }else if (indexPath.row == 5){
        resultVC = [[ThreadViewController alloc]init];
    }
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
    [self.navigationController pushViewController:resultVC animated:YES];
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
