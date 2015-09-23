//
//  BDBNetworking.h
//  band
//
//  Created by Steven Yang on 14-9-16.
//  Copyright (c) 2014年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetWorking.h"



typedef void (^BDBBlockHTTPRequestSuccess)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^BDBBlockHTTPRequestFailure)(AFHTTPRequestOperation *operation, NSError *error);

/**
 * 封装网络请求
 * 
 * 包括HTTP GET/POST 请求
 */
@interface BDBNetworking : NSObject

+(instancetype) networking;


+(AFHTTPRequestOperation*) httpGetWithURL:(NSString*)url
                                  success:(BDBBlockHTTPRequestSuccess)success
                                  failure:(BDBBlockHTTPRequestFailure)failure;

+(AFHTTPRequestOperation*) httpPostWithURL:(NSString*)url
                                  httpBody:(id)httpBody
                                   success:(BDBBlockHTTPRequestSuccess)success
                                   failure:(BDBBlockHTTPRequestFailure)failure;

@end
