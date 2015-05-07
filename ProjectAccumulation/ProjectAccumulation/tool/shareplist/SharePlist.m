//
//  SharePlist.m
//  ProjectAccumulation
//
//  Created by XuYang on 15/5/6.
//  Copyright (c) 2015年 XuYang. All rights reserved.
//

#import "SharePlist.h"
#define DEFAULT_PLIST_NAME @"share_plist_default"
#define KEYSUFFIX @"_key"

//plist常用路径
#define PATH NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)
#define PLISTPATH [PATH objectAtIndex:0]
#define PLIST_FILE_NAME(fn) [PLISTPATH stringByAppendingPathComponent:fn]
//获取是否存在该plist file
#define HAS_PLIST_FILE(fn) [[NSMutableDictionary alloc]initWithContentsOfFile:PLIST_FILE_NAME(fn)]==nil?NO:YES
//根据文件名获得dictionary
#define MDICTIONARY_FROM_PLIST_FILE_NAME(fn) [[NSMutableDictionary alloc]initWithContentsOfFile:PLIST_FILE_NAME(fn)]


//添加plist结尾
#define CHECK_PLIST_SUFFIX(str) if(![str hasSuffix:@".plist"]){\
str = [NSString stringWithFormat:@"%@.plist",str];\
}

@interface SharePlist()

@property(nonatomic,strong)PlistEditor* editor;

@end

@implementation SharePlist

+(SharePlist*)getDefaultSharePlist{
    return [self getSharePlistWithName:DEFAULT_PLIST_NAME];
}

+(SharePlist*)getSharePlistWithName:(NSString*)str{
    return [self getSharePlistWithName:str isOrder:NO];
}

+(SharePlist*)getSharePlistWithName:(NSString*)str isOrder:(BOOL)ord{
    //auto add plist suffix
    CHECK_PLIST_SUFFIX(str);
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    
    NSMutableDictionary *keyData = nil;
    NSString *keyFileName= nil;
    NSLog(@"xuyang plistPath:%@",plistPath);
    if(ord){
        //有序，需要创建keyPlist
        keyData = [[NSMutableDictionary alloc] init];
        keyFileName=[plistPath stringByAppendingPathComponent:plistPath];
        [keyData writeToFile:keyFileName atomically:YES];
    }
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    NSString *fileName=[plistPath stringByAppendingPathComponent:str];
    [data writeToFile:fileName atomically:YES];
    SharePlist *instance = [[self alloc]init];
    instance.currentPlistName = str;
    instance.isOrder = ord;
    return instance;
}

//是否存在该plist
+(BOOL)containPlist:(NSString*)str{
    CHECK_PLIST_SUFFIX(str)
    return HAS_PLIST_FILE(str);
}

//该plist是否已排序
+(BOOL)isOrderPlist:(NSString*)str{
    NSString* temp = [NSString stringWithFormat:@"%@%@",str,KEYSUFFIX];
    return HAS_PLIST_FILE(temp);
}

//删除plist
+(void)removePlist:(NSString*)str{
    [SharePlist deleteFile:str];
    NSString* keyFile = [NSString stringWithFormat:@"%@%@",str,KEYSUFFIX];
    [SharePlist deleteFile:keyFile];
}

+(BOOL)deleteFile:(NSString *)filePath{
    NSError *err = nil;
    if (nil == filePath) {
        return NO;
    }
    NSFileManager *appFileManager = [NSFileManager defaultManager];
    if (![appFileManager fileExistsAtPath:filePath]) {
        return YES;
    }
    if (![appFileManager isDeletableFileAtPath:filePath]) {
        return NO;
    }
    return [appFileManager removeItemAtPath:filePath error:&err];
}

-(PlistEditor*)editor{
    if(_editor ==nil){
        _editor = [[PlistEditor alloc]init];
        _editor.currentPlistName = _currentPlistName;
        _editor.isOrder = _isOrder;
    }
    return _editor;
}
@end

@implementation PlistEditor

-(PlistEditor*)initWithName:(NSString*)str isOrder:(BOOL)ord{
    return [[PlistEditor alloc]init];
}
-(void)pushStringWithKey:(NSString*)key value:(NSString*)value{
    NSMutableDictionary *dataDic = MDICTIONARY_FROM_PLIST_FILE_NAME(_currentPlistName);
    [dataDic setObject:value forKey:key];
    [dataDic writeToFile:PLIST_FILE_NAME(_currentPlistName) atomically:YES];
}

@end
