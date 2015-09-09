//
//  BDBToast.h
//  band
//
//  Created by heqin on 14-9-27.
//  Copyright (c) 2014年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDBToast : UIView
{
@private
    UILabel *_label;
    BOOL _stoped;
    BOOL _refreshed;
    UIImageView* _icon;
}

- (void)showToast:(NSString *)message inView:(UIView *)superView;
- (void)showToast:(NSString *)message inView:(UIView *)superView centerOffY:(CGFloat)centerOffY;
- (void)showToast:(NSString *)message withIcon:(UIImage*)icon;
//windows
- (void)showToast:(NSString *)message;
- (void)showToast:(NSString *)message centerOffY:(CGFloat)centerOffY;

+ (id)sharedInstance;

@end
