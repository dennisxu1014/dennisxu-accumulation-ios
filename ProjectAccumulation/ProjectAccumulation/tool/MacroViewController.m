//
//  MacroViewController.m
//  ProjectAccumulation
//  有用的宏
//  Created by XuYang on 15/5/6.
//  Copyright (c) 2015年 XuYang. All rights reserved.
//

#import "MacroViewController.h"


//颜色工具
#define UIColorFromRGB(rgbValue) ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0])
//nsinteger转字符串
#define itos(l) [NSString stringWithFormat:@"%ld", (long)(l)]

//引用工具
#define WEAK_REF(obj) \
__weak typeof(obj) weak_##obj = obj; \

#define STRONG_REF(obj) \
__strong typeof(weak_##obj) obj = weak_##obj;

//判断系统版本号
#define kCurrentDeviceSystemVersion                         ([[UIDevice currentDevice].systemVersion floatValue])
#define isCurrentDeviceSystemVersionLater(__Version__)      (kCurrentDeviceSystemVersion >= (__Version__))

//log
#define NSLog(fmt, ...) do { \
    NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);\
} while (0);

//NavBar高度
#define NavigationBar_HEIGHT 44

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//带有RGBA的颜色设置
#define RGBA(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//背景色
#define BACKGROUND_COLOR [UIColor colorWithRed:242.0/255.0 green:236.0/255.0 blue:231.0/255.0 alpha:1.0]
@interface MacroViewController ()
//清除背景色
#define CLEARCOLOR [UIColor clearColor]
@end

@implementation MacroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"常用宏定义";
    self.view.backgroundColor = BACKGROUND_COLOR;
    // Do any additional setup after loading the view.
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    UILabel* textLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 2000)];
    [textLable setText:@"\
1.颜色工具 UIColorFromRGB(rgbValue)\n\
2.NSInteger转字符串 itos(l)\n\
3.引用工具WEAK_REF(obj),STRONG_REF(obj)\n\
4.判断系统版本号\n\
5.NSLog(fmt, ...)打印当前行\n\
6.NavBar高度\n\
7.获取屏幕 宽度、高度\n\
8.带有RGBA的颜色设置\n\
9.清除背景色\n\
10.\n\
..."];
    textLable.textAlignment = NSTextAlignmentLeft;
    textLable.lineBreakMode = NSLineBreakByCharWrapping;
    textLable.numberOfLines = 100;
    [textLable sizeToFit];
    [scrollView addSubview: textLable];
    [self.view addSubview:scrollView];
    
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
