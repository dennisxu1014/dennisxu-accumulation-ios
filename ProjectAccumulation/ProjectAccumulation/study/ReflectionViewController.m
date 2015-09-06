//
//  ReflectionViewController.m
//  ProjectAccumulation
//
//  Created by XuYang on 15/8/12.
//  Copyright (c) 2015年 XuYang. All rights reserved.
//

#import "ReflectionViewController.h"

@interface ReflectionViewController ()

@end

@implementation ReflectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //反射创建对象
    NSString* classString = @"OCMessageViewController";
    Class class =  NSClassFromString(classString);
    id instance = [[class alloc]init];
    NSLog(@"[instance description]:%@",[instance description]);
    
    //反射调用方法
    if([instance respondsToSelector:@selector(test)]){
        objc_msgSend(instance, @selector(test));
    }
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

