//
//  DrugListModel.m
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "DrugListModel.h"

@implementation DrugListModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        _ids = [dict objectForKey:@"id"];
        _name = [dict objectForKey:@"name"];
        _img = [dict objectForKey:@"img"];
        _descript = [dict objectForKey:@"description"];
    }
    return self;
}

+ (instancetype)filleModelWithDict:(NSDictionary *)dict{
    
    return [[DrugListModel alloc] initWithDict:dict];
}

@end
