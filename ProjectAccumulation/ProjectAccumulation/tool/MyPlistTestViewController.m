//
//  MyPlistTestViewController.m
//  ProjectAccumulation
//
//  Created by XuYang on 15/5/6.
//  Copyright (c) 2015年 XuYang. All rights reserved.
//

#import "MyPlistTestViewController.h"
#import "SharePlist.h"
@interface MyPlistTestViewController ()

@end

@implementation MyPlistTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    SharePlist *plist = [SharePlist getSharePlistWithName:@"test3.plist"isOrder:NO];
    [SharePlist containPlist:@""];
    PlistEditor *editor = [plist editor];
    [editor pushStringWithKey:@"testKey" value:@"testValue"];
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
