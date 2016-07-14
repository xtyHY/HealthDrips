//
//  BigClassifyModel.m
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "BigClassifyModel.h"
#import "LiteClassifyModel.h"
@implementation BigClassifyModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        _name = [dict objectForKey:@"name"];
        
        
        NSMutableArray * marr = [[NSMutableArray alloc] init];
        
        for (NSDictionary * liteDict in [dict objectForKey:@"liteClassify"]) {
            
            [marr addObject:[LiteClassifyModel fillModelWithDict:liteDict]];
        }
        
        _liteArr = [[NSArray alloc] initWithArray:marr];
        
    }
    
    return self;
}

+ (instancetype)fillModelWithDict:(NSDictionary *)dict{
    
    return [[BigClassifyModel alloc] initWithDict:dict];
}

- (NSString *)description{
    
    return [NSString stringWithFormat:@"number of liteArr :%ld",_liteArr.count];
}

@end
