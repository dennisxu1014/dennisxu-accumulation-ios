//
//  StudyMainTableViewController.m
//  ProjectAccumulation
//
//  Created by XuYang on 15/4/8.
//  Copyright (c) 2015年 XuYang. All rights reserved.
//

#import "StudyMainTableViewController.h"
@interface StudyMainTableViewController ()
@property(nonatomic,strong)NSArray* itemArray;
@property(nonatomic,strong)NSArray* itemClassNameArray;
@end

@implementation StudyMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _itemArray = @[@"OC消息",@"运行时创建Class",@"KVC与KVO",@"block",@"内存管理MRC",@"线程操作",@"webView测试",@"view frame bound 测试",@"autoLayout测试",@"反射学习"];
    _itemClassNameArray = @[@"OCMessageViewController",@"RuntimeCreateClassViewController",@"KVCKVOViewController",@"BlockViewController",@"MemoryManagerMRCViewController",@"ThreadViewController",@"WebViewTestViewController",@"ViewsTestViewController",@"AutoLayoutTestViewController",@"ReflectionViewController"];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_itemArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    [_itemArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:[_itemArray objectAtIndex:indexPath.row]];
 return cell;
 }

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *resultVC = nil;
    Class class = NSClassFromString([_itemClassNameArray objectAtIndex:indexPath.row]);
    resultVC = [[class alloc]init];
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
    [self.navigationController pushViewController:resultVC animated:YES];
}


@end
