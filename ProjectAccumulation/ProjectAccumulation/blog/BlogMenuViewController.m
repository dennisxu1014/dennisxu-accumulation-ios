//
//  BlogMenuViewController.m
//  ProjectAccumulation
//
//  Created by XuYang on 15/9/7.
//  Copyright (c) 2015年 XuYang. All rights reserved.
//

#import "BlogMenuViewController.h"
#import "UCWebViewController.h"
@interface BlogMenuViewController ()

@end

@implementation BlogMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UCWebViewController *resultVC = nil;
    NSString* url = [[super itemValueArray] objectAtIndex:indexPath.row];
    resultVC = [[UCWebViewController alloc]init];
    resultVC.url=url;
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
    [self.navigationController pushViewController:resultVC animated:YES];
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
