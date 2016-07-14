//
//  DiseaseListModel.m
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "DiseaseListModel.h"

@implementation DiseaseListModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        _ids = [dict objectForKey:@"id"];
        _name = [dict objectForKey:@"name"];
        _descript = [dict objectForKey:@"description"];
    }
    return self;
}

+ (instancetype)fillModelWithDict:(NSDictionary *)dict{
    
    return [[DiseaseListModel alloc] initWithDict:dict];
}

- (NSString *)description{
    
    return [NSString stringWithFormat:@"id:%@ 病名:%@ \n简介:%@",_ids,_name,_descript];
}

@end
