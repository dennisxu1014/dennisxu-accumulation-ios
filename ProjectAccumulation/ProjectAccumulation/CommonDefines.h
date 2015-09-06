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

#endif
