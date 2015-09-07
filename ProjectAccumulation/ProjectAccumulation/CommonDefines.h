//
//  CommonDefines.h
//  ProjectAccumulation
//
//  Created by XuYang on 15/4/27.
//  Copyright (c) 2015年 XuYang. All rights reserved.
//

#ifndef ProjectAccumulation_CommonDefines_h
#define ProjectAccumulation_CommonDefines_h


#define NSLog(fmt, ...) do { \
NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);\
} while (0);

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

//lable背景色
#define LABLE_BACKGROUND_COLOR [UIColor colorWithRed:222.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0]
//背景色
#define BACKGROUND_COLOR [UIColor whiteColor]

#define UIColorFromRGB(rgbValue) ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0])
#endif
