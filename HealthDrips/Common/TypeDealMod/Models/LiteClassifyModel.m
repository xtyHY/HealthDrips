//
//  LiteClassifyModel.m
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "LiteClassifyModel.h"

@implementation LiteClassifyModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        [self setValuesForKeysWithDictionary:dict];
        
    }
    return self;
}

+ (instancetype)fillModelWithDict:(NSDictionary *)dict{
    
    return [[LiteClassifyModel alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    DLOG
}

- (id)valueForUndefinedKey:(NSString *)key{
    
    DLOG    
    return nil;
}
//
//- (NSString *)description{
//    
//    return [NSString stringWithFormat:@"=name:%@ =id:%@",_name,_ids];
//}

@end
