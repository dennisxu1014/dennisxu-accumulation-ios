//
//  Utils.m
//  ProjectAccumulation
//
//  Created by XuYang on 15/9/8.
//  Copyright (c) 2015年 XuYang. All rights reserved.
//

#import "Utils.h"

@implementation Utils

//获得当前屏幕截图
+(UIImage*)getCurrentSnapshot{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    UIGraphicsBeginImageContext(window.rootViewController.view.bounds.size);
    [window.rootViewController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //可以存入相册
    //    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    UIGraphicsEndImageContext();
    return image;
}

@end
