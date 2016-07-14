//
//  NetTool.h
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
@interface NetTool : NSObject

@property (nonatomic, assign, readonly) BOOL isReachable;

+ (instancetype)shareTool;

@end
