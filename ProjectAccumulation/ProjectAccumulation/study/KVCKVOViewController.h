//
//  KVCKVOViewController.h
//  ProjectAccumulation
//
//  Created by XuYang on 15/4/13.
//  Copyright (c) 2015年 XuYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KVCKVOViewController : UIViewController

@end

@interface PersonTest : NSObject
@property (nonatomic,strong)NSString* name;
@property (nonatomic,strong)PersonTest *innerObj;
@end