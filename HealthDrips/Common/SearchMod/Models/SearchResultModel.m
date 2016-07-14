//
//  SearchResultModel.m
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "SearchResultModel.h"

@implementation SearchResultModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)fillModelWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"])
        _ids = value;
    
    if ([key isEqualToString:@"description"])
        _descript = value;
    
    if ([key isEqualToString:@"address"]) {
        _descript = value;
    }
}

- (id)valueForUndefinedKey:(NSString *)key{
    
    return nil;
}

- (NSString *)description{
    
    return _name;
}

@end
