//
//  BDBNetworking.m
//  band
//
//  Created by Steven Yang on 14-9-16.
//  Copyright (c) 2014年 baidu. All rights reserved.
//

#import "BDBNetworking.h"
#import "Mantle.h"

@interface BDBNetworking()

@property (nonatomic, strong) AFHTTPRequestOperationManager* networkManager;

@end


@implementation BDBNetworking

-(instancetype) init
{
    self = [super init];
    if (self != nil)
    {
        self.networkManager = [[AFHTTPRequestOperationManager alloc] init];
        
        self.networkManager.responseSerializer = [AFJSONResponseSerializer serializer];
        NSMutableSet* newSet = [NSMutableSet setWithSet:self.networkManager.responseSerializer.acceptableContentTypes];
        [newSet addObject:@"text/html"];
        self.networkManager.responseSerializer.acceptableContentTypes = newSet;
    }
    
    return self;
}

+(instancetype) networking
{
    static BDBNetworking *networking = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networking = [[[self class] alloc] init];
    });
    return networking;
}

+(AFHTTPRequestOperation*) httpGetWithURL:(NSString*)url
                                  success:(BDBBlockHTTPRequestSuccess)success
                                  failure:(BDBBlockHTTPRequestFailure)failure
{
    return [[BDBNetworking networking].networkManager GET:url
                                               parameters:nil
                                                  success:^(AFHTTPRequestOperation *operation, id responseObject)
                                                    {
                                                        if (success != nil)
                                                        {
                                                            success(operation, responseObject);
                                                        }
                                                    }
                                                 failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                                    {
                                                    if (failure != nil)
                                                        {
                                                            failure(operation, error);
                                                        }
                                                    }];
}

+(AFHTTPRequestOperation*) httpPostWithURL:(NSString*)url
                                  httpBody:(id)httpBody
                                   success:(BDBBlockHTTPRequestSuccess)success
                                   failure:(BDBBlockHTTPRequestFailure)failure
{
    AFHTTPRequestOperation* requestOperation = nil;
    
    if ([httpBody isKindOfClass:[MTLModel class]])
    {
        MTLModel* httpBodyModel = (MTLModel*)httpBody;
        
        requestOperation = [[BDBNetworking networking].networkManager POST:url
                                                                parameters:httpBodyModel.dictionaryValue
                                                                   success:^(AFHTTPRequestOperation *operation, id responseObject)
                            {
                                if(success != nil)
                                {
                                    success(operation, responseObject);
                                }
                            }
                                                                   failure:^(AFHTTPRequestOperation *operation, NSError *error)
                            {
                                if(failure != nil)
                                {
                                    failure(operation, error);
                                }
                            }];
    }
    
    return requestOperation;
}

@end
