//
//  LoadClassifyManager.m
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "LoadClassifyManager.h"
#import "BigClassifyModel.h"

@implementation LoadClassifyManager

+ (instancetype)shareManager{
    
    static LoadClassifyManager * manager = nil;
    
    if (manager==nil) {
        
        manager = [[LoadClassifyManager alloc] init];
    }
    
    return manager;
}

- (NSArray *)getClassifyModelWithClassifyName:(NSString *)classifyName{
    
    NSMutableArray * result = [[NSMutableArray alloc] init];
    
    NSString * path = [[NSBundle mainBundle] pathForResource:classifyName ofType:@"plist"];
    NSArray * dataArray = [[NSArray alloc] initWithContentsOfFile:path];
    
    for (NSDictionary * dataDict in dataArray) {
        
        [result addObject:[BigClassifyModel fillModelWithDict:dataDict]];
    }
    
    return result;
}

@end
