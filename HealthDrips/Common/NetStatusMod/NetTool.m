//
//  NetTool.m
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "NetTool.h"

@implementation NetTool

+ (instancetype)shareTool{
    
    static NetTool * tool = nil;
    
    if (tool==nil) {
        
        tool = [[NetTool alloc] init];
    }
    
    return tool;
}

- (BOOL)isReachable{
    
    BOOL isExistenceNetwork = YES;
    
    static NSString * hostName = @"www.tngou.net";
    
    Reachability * r = [Reachability reachabilityWithHostName:hostName];
    
    switch ([r currentReachabilityStatus]) {
            
        case NotReachable:
            isExistenceNetwork=NO;
            NSLog(@"无网络访问");
            break;
        
        case ReachableViaWWAN:
            isExistenceNetwork=YES;
            NSLog(@"使用3G");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork=YES;
            NSLog(@"使用WIFI");
            break;
    }
    
    return isExistenceNetwork;
}

@end
