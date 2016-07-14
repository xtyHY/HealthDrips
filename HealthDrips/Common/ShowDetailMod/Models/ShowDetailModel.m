//
//  ShowDetailModel.m
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "ShowDetailModel.h"

@implementation ShowDetailModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)fillModelWithDict:(NSDictionary *)dict{
    
    return [[[self class] alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"])
        _ids = value;
    
    if ([key isEqualToString:@"description"])
        _descript = value;
}

- (id)valueForUndefinedKey:(NSString *)key{
    
    return nil;
}

- (NSString *)description{
    
    NSLog(@"--model--%@ %@ %@",_ids,_name,_title);
    
    return nil;
}

@end
