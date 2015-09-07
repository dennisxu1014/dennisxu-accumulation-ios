//
//  ToolMainTableViewController.m
//  ProjectAccumulation
//
//  Created by XuYang on 15/4/1.
//  Copyright (c) 2015年 XuYang. All rights reserved.
//

#import "ToolMainTableViewController.h"

#import "MacroViewController.h"
#import "MyPlistTestViewController.h"
#import "BDBTabViewDemoViewController.h"
@interface ToolMainTableViewController ()

@end

@implementation ToolMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工具";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    // Return the number of rows in the section.
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if(indexPath.row == 0){
        [cell.textLabel setText:@"常用宏定义"];
    }else if(indexPath.row == 1){
        [cell.textLabel setText:@"Plist存储工具"];
    }    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *resultVC = nil;
    if(indexPath.row==0){
        resultVC = [[MacroViewController alloc]init];
    }else if(indexPath.row == 1){
        resultVC = [[MyPlistTestViewController alloc]init];
    }
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
    [self.navigationController pushViewController:resultVC animated:YES];
}

@end
