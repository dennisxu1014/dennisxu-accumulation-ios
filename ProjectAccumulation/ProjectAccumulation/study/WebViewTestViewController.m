//
//  WebViewTestViewController.m
//  ProjectAccumulation
//
//  Created by XuYang on 15/5/19.
//  Copyright (c) 2015年 XuYang. All rights reserved.
//

#import "WebViewTestViewController.h"

@interface WebViewTestViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView* webView;
@end

@implementation WebViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    NSURL* url =[NSURL URLWithString:@"http://m.nuomi.com"];
    NSURLRequest* request =[NSURLRequest requestWithURL:url];
    _webView.delegate =self;

    [self.view addSubview:_webView];
    [_webView loadRequest:request];
    
}

//-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    NSLog(@"url:%@",request.URL.absoluteString);
//    NSURLCache * cache = [NSURLCache sharedURLCache];
//    [cache cachedResponseForRequest:request];
//    return YES;
//}

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
