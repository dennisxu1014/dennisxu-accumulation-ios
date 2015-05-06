//
//  KVCKVOViewController.m
//  ProjectAccumulation
//
//  Created by XuYang on 15/4/13.
//  Copyright (c) 2015年 XuYang. All rights reserved.
//

#import "KVCKVOViewController.h"

@interface KVCKVOViewController ()

@end

@implementation KVCKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    PersonTest *person = [[PersonTest alloc]init];
    PersonTest *inner = [[PersonTest alloc]init];
    person.innerObj = inner;
    inner.name = @"innerName";
    //[<PersonTest 0x7f831050af20> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key person.
//    [person setValue:@"namevalue" forKey:@"person"];//crash
    [person setValue:@"namevalue" forKey:@"name"];
    //取值
    NSLog(@"kvc test：%@", [person valueForKey:@"name"]);
    NSLog(@"kvc test：%@", [person valueForKeyPath:@"innerObj.name"]);
    
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

@interface PersonTest()

@end
@implementation PersonTest


@end