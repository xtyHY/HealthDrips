//
//  CookListNameModel.m
//  HealthDrips
//
//  Created by Arom.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "CookListNameModel.h"

@implementation CookListNameModel

- (instancetype)initwithDict:(NSDictionary *)dict{

    if (self == [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+ (instancetype)ModelwithDict:(NSDictionary *)dict{

    return [[self alloc] initwithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

    if ([key isEqualToString:@"id"]) {
        _ids = value;
    }
    
}
- (id)valueForUndefinedKey:(NSString *)key{

    return nil;
}

@end
