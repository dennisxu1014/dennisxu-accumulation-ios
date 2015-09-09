//
//  UCWebViewController.m
//  ProjectAccumulation
//
//  Created by XuYang on 15/9/8.
//  Copyright (c) 2015年 XuYang. All rights reserved.
//

#import "UCWebViewController.h"
#import "BDLCustomerWebView.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
@interface UCWebViewController ()<BDLCustomerWebViewDelegate,NJKWebViewProgressDelegate,UIWebViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) BDLCustomerWebView* webView;
//进度条相关
@property (nonatomic,strong)NJKWebViewProgressView *progressView;
@property (nonatomic,strong)NJKWebViewProgress *progressProxy;
@end

@implementation UCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect grouponWebViewRect = CGRectZero;
    CGFloat widthOfScreen = [UIScreen mainScreen].bounds.size.width;
    CGFloat heightOfScreen = [UIScreen mainScreen].bounds.size.height;
    grouponWebViewRect = CGRectMake(0, 0, widthOfScreen, heightOfScreen-64);
    _webView = [[BDLCustomerWebView alloc] initWithFrame:grouponWebViewRect];
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.restorationIdentifier = @"_grouponWebView";
    _webView.scrollView.delegate = self;
    _webView.dataDetectorTypes =UIDataDetectorTypePhoneNumber;
    _webView.delegate = self;
    [self.view addSubview:_webView];
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithTitle:@"复制链接" style:UIBarButtonItemStylePlain target:self action:@selector(copy:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    CGFloat progressBarHeight = 1.5f;
    CGRect barFrame = CGRectMake(0, 0, widthOfScreen, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_webView addSubview:_progressView];
    [self loadUrl];
    
}

-(void)copy:(id)button{
    NSLog(@"copy");
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = _webView.request.URL.absoluteString;
    [[BDBToast sharedInstance]showToast:[NSString stringWithFormat:@"%@ 已拷贝刀剪切板",_webView.request.URL.absoluteString]];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view addSubview:_progressView];
}


-(void)loadUrl{
    if(_url ==nil ||[_url length]<1){
        _url = @"http://m.nuomi.com";
    }
    NSURLRequest* request =[NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [_webView loadRequest:request];
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
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    _webView.isSwipeBackEnable = YES;
    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
}


@end
