//
//  BlurGlassViewController.m
//  ProjectAccumulation
//
//  Created by XuYang on 15/9/8.
//  Copyright (c) 2015年 XuYang. All rights reserved.
//

//毛玻璃效果
#import "BlurGlassViewController.h"

@interface BlurGlassViewController ()
@property(nonatomic,strong)UIButton* openButton;
@property(nonatomic,strong)UIButton* closeButton;
@property(nonatomic,strong)UIImageView* image;
@end

@implementation BlurGlassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel* text = [[UILabel alloc]init];
    [text setText:@"BlurGlass测试"];
    [text sizeToFit];
    [self.view addSubview:text];
    
    _openButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_openButton setTitle:@"打开" forState:UIControlStateNormal];
    _openButton.titleLabel.font = [UIFont systemFontOfSize:30.0f];
    [_openButton sizeToFit];
    _openButton.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2-80);
    [_openButton addTarget:self action:@selector(open:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_openButton];
    
    
    
}

-(void)open:(id)button{
    _image = [[UIImageView alloc]initWithImage:[[Utils getCurrentSnapshot] imgWithBlur]];
    _image.tag = 100;
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        if (window.windowLevel == UIWindowLevelNormal) {
            [window addSubview:_image];
            
            _closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
            [_closeButton setTitle:@"关闭" forState:UIControlStateNormal];
            _closeButton.titleLabel.font = [UIFont systemFontOfSize:30.0f];
            [_closeButton sizeToFit];
            _closeButton.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
            [_closeButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
            [window addSubview:_closeButton];
        }
    }
}

-(void)close:(id)button{
    [_image removeFromSuperview];
    [_closeButton removeFromSuperview];
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
