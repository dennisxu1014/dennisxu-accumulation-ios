//
//  BDLCustomerWebView.h
//  bainuolite
//
//  Created by XuYang on 15/6/26.
//  Copyright (c) 2015年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BDLCustomerWebView;
@protocol BDLCustomerWebViewDelegate <NSObject>
@optional
-(void)webViewTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)webViewTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)webViewTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)webViewTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;


-(void)customerWebViewBack:(BDLCustomerWebView*) webview;
-(void)customerWebViewForward:(BDLCustomerWebView*) webview;
@end

@interface BDLCustomerWebView : UIWebView

@property(nonatomic,weak)id<BDLCustomerWebViewDelegate> webViewDelegate;
@property(nonatomic,assign)BOOL isSwipeBackEnable;
@end


