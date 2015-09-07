//
//  BaseMenuViewController.h
//  ProjectAccumulation
//
//  Created by XuYang on 15/9/7.
//  Copyright (c) 2015年 XuYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonMenuViewController : UITableViewController
//当前读取的Plist
@property(nonatomic,copy)NSString* currentMenuPlist;
@end
