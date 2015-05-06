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



#endif
