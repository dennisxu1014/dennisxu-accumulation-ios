//
//  OnePxLineViewController.m
//  ProjectAccumulation
//
//  Created by XuYang on 15/9/7.
//  Copyright (c) 2015年 XuYang. All rights reserved.
//

#import "OnePxLineViewController.h"

#define INFO @"iOS 如何正确的绘制1像素的线 \
iOS中当我们使用Quartz，UIKit，CoreAnimation等框架时，所有的坐标系统采用Point来衡量。系统在实际渲染到设置时会帮助我们处理Point到Pixel的转换。\
这样做的好处隔离变化，即我们在布局的事后不需要关注当前设备是否为Retina，直接按照一套坐标系统来布局即可。\n \
实际使用中我们需要牢记下面这一点:\
One point does not necessarily correspond to one physical pixel.\n \
1 Point的线在非Retina屏幕则是一个像素，在Retina屏幕上则可能是2个或者3个，取决于系统设备的DPI。 \
... ...\
"
@interface OnePxLineViewController ()
@property(nonatomic,strong)UILabel* lable;
@property(nonatomic,strong)UIButton* button;

@end

@implementation OnePxLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"iOS 如何正确的绘制1像素的线";
    // Do any additional setup after loading the view.
    
    _lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    _lable.backgroundColor = LABLE_BACKGROUND_COLOR;
    [_lable setText:INFO];
    _lable.numberOfLines = 0;
    [_lable sizeToFit];
    [self.view addSubview:_lable];
    
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    [_button setTitle:@"http://www.cnblogs.com/smileEvday/p\n/iOS_PixelVsPoint.html" forState:UIControlStateNormal];
    _button.frame = CGRectMake(0,CGRectGetMaxY(_lable.frame), SCREEN_WIDTH, 0);
    _button.titleLabel.numberOfLines = 0;
    [_button sizeToFit];
    [_button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];

    UIView* line1 = [self generateSimpleLineView:CGRectMake(11, CGRectGetMaxY(_button.frame), 0.5f, 300)];
    line1.backgroundColor = [UIColor blackColor];
    [self.view addSubview:line1];
    
    UIView* line2 = [self generateSimpleLineView:CGRectMake(26, CGRectGetMaxY(_button.frame), 0.5f, 300)];
    line2.backgroundColor = [UIColor blackColor];
    [self.view addSubview:line2];
    
    UIView* line3 = [self generateSimpleLineView:CGRectMake(0, CGRectGetMaxY(_button.frame)+30, 300, 0.5f)];
    line3.backgroundColor = [UIColor blackColor];
    [self.view addSubview:line3];
    
    UIView* line4 = [self generateSimpleLineView:CGRectMake(0, CGRectGetMaxY(_button.frame)+61, 300, 0.5f)];
    line4.backgroundColor = [UIColor blackColor];
    [self.view addSubview:line4];
    
}

-(void)click:(id)button{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.cnblogs.com/smileEvday/p/iOS_PixelVsPoint.html"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#warning 工具方法----画线方法
//提供工具方法
-(UIView*)generateSimpleLineView:(CGRect)frame{
    CGFloat single_line_width = (1 / [UIScreen mainScreen].scale);
    CGFloat sinle_line_adjust_offset = ((1 / [UIScreen mainScreen].scale) / 2);
    CGRect resultFrame = CGRectZero;
    if(frame.size.width>frame.size.height){
        //横线
        CGFloat offset = 0;
        if((int)frame.origin.y % 2 !=0){
            //需要调整
            offset = sinle_line_adjust_offset;
        }
        resultFrame = CGRectMake(frame.origin.x, frame.origin.y-offset, frame.size.width, single_line_width);
    }else{
        CGFloat offset = 0;
        if((int)frame.origin.x % 2 !=0){
            //需要调整
            offset = sinle_line_adjust_offset;
        }
        resultFrame = CGRectMake(frame.origin.x-offset, frame.origin.y, single_line_width, frame.size.height);
    }
    UIView *resultView = [[UIView alloc] initWithFrame:resultFrame];
    return resultView;
}

@end
