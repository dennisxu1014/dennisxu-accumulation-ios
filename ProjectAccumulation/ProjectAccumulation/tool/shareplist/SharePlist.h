//
//  SharePlist.h
//  ProjectAccumulation
//
//  Created by XuYang on 15/5/6.
//  Copyright (c) 2015年 XuYang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PlistEditor;
@protocol PlistEditorDelegate <NSObject>
-(id)initWithName:(NSString*)str isOrder:(BOOL)ord;
-(id)pushStringWithKey:(NSString*)key value:(NSString*)value;
@end

//plist工具类
@interface SharePlist : NSObject
//当前的
@property(nonatomic,strong)NSString* currentPlistName;
@property(nonatomic,assign)BOOL isOrder;

+(SharePlist*)getDefaultSharePlist;

+(SharePlist*)getSharePlistWithName:(NSString*)str;

+(SharePlist*)getSharePlistWithName:(NSString*)str isOrder:(BOOL)ord;

//是否存在该plist
+(BOOL)containPlist:(NSString*)str;

//该plist是否支持排序
+(BOOL)isOrderPlist:(NSString*)str;

//直接删除
+(void)removePlist:(NSString*)str;

-(PlistEditor*)editor;
@end

//plist编辑器
@interface  PlistEditor: NSObject<PlistEditorDelegate>
@property(nonatomic,strong)NSString* currentPlistName;
@property(nonatomic,assign)BOOL isOrder;

-(PlistEditor*)initWithName:(NSString*)str isOrder:(BOOL)ord;
-(void)pushStringWithKey:(NSString*)key value:(NSString*)value;
@end


