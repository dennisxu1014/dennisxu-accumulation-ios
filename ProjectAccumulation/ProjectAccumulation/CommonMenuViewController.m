//
//  BaseMenuViewController.m
//  ProjectAccumulation
//
//  Created by XuYang on 15/9/7.
//  Copyright (c) 2015年 XuYang. All rights reserved.
//

#import "CommonMenuViewController.h"

@interface CommonMenuViewController ()

@property(nonatomic,strong)NSMutableArray* itemArray;
@property(nonatomic,strong)NSMutableArray* itemClassNameArray;

@end

@implementation CommonMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadMenuPlist];
    self.title = _currentMenuPlist;
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    [tableview setDelegate:self];
    [tableview setDataSource:self];
    
//    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.0f)];
//    headerView.backgroundColor = [UIColor greenColor];
//    tableview.tableHeaderView = headerView;
    
    [self.view addSubview:tableview];
}

-(void)loadMenuPlist{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:_currentMenuPlist ofType:@"plist"];
    NSMutableDictionary *listDic = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    NSLog(@"%@",listDic);
    if(listDic!=nil){
        _itemArray = [[NSMutableArray alloc]init];
        _itemClassNameArray = [[NSMutableArray alloc]init];
        for (NSString *key in listDic) {
            NSLog(@"key: %@ value: %@", key, listDic[key]);
            [_itemArray addObject:key];
            [_itemClassNameArray addObject:listDic[key]];
        }
    }
    
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

@end
