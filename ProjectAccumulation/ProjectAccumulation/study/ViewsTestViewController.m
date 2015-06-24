//
//  ViewsTestViewController.m
//  ProjectAccumulation
//
//  Created by XuYang on 15/5/27.
//  Copyright (c) 2015年 XuYang. All rights reserved.
//

#import "ViewsTestViewController.h"

@interface ViewsTestViewController ()

@end

@implementation ViewsTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    UIView* view1 = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 300, 500)];
    view1.backgroundColor = [UIColor redColor];
    view1.bounds = CGRectMake(-10, -10, 300, 500);

    
    UIView* view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    view2.backgroundColor = [UIColor yellowColor];
    
    [view1 addSubview:view2];
    
    [self.view addSubview:view1];
    
    
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
