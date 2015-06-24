//
//  AutoLayoutTestViewController.m
//  ProjectAccumulation
//
//  Created by XuYang on 15/5/28.
//  Copyright (c) 2015年 XuYang. All rights reserved.
//

#import "AutoLayoutTestViewController.h"

@interface AutoLayoutTestViewController ()
@property (weak, nonatomic) IBOutlet UIButton *Button;
@property (weak, nonatomic) IBOutlet UILabel *testLabel1;
@property (weak, nonatomic) IBOutlet UILabel *testLabel2;
@property (strong, nonatomic) UILabel *testLabel3;
@end

@implementation AutoLayoutTestViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.translucent = NO;

    _testLabel3 = [[UILabel alloc]initWithFrame:CGRectZero];
    _testLabel3.font =[UIFont systemFontOfSize:16.0f];
    _testLabel3.text = @"TestLabel3";
    _testLabel3.frame = CGRectMake(_testLabel2.frame.origin.x, _testLabel2.frame.origin.y, 0, 0);
    [_testLabel3 sizeToFit];

    [self.view addSubview:_testLabel3];
    
    for( NSLayoutConstraint *constraint in _testLabel1.constraints){
        if(constraint.firstItem == _testLabel1){
            NSLog(@"constraint :%f",constraint.constant);
        }
    }
    
    NSArray *views = [[NSBundle mainBundle]loadNibNamed:@"AutoLayoutTestCustomerView" owner:nil options:nil];
    UIView* aView =[views objectAtIndex:0];
    
    
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 64.0f, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64.0f)];
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(scrollView.frame), CGRectGetHeight(scrollView.frame));
    [scrollView addSubview:aView];
    
    
    
    UILabel* lable = (UILabel*)[aView viewWithTag:100];
    lable.translatesAutoresizingMaskIntoConstraints = YES;
    lable.frame = CGRectMake(100, 100, 100, 100);
    
    [self.view addSubview:scrollView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onButtonClick:(id)sender {
    NSLog(@"buttonClick");
    
    [UIView animateWithDuration:0.5f animations:^{
        _testLabel3.frame = CGRectMake(100, 100, 0, 0);
        [_testLabel3 sizeToFit];
        
        _testLabel2.frame = CGRectMake(100, 200, 0, 0);
        [_testLabel2 sizeToFit];
    }];
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
