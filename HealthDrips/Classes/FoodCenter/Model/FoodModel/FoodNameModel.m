//
//  FoodNameModel.m
//  HealthDrips
//
//  Created by Arom.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "FoodNameModel.h"

@implementation FoodNameModel

-(instancetype)initWithDict:(NSDictionary *)dict{

    if (self == [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)modelWithDict:(NSDictionary *)dict{

    return [[self alloc]initWithDict:dict];
    
}

//没有写全部属性时需要写这个
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

    if ([key isEqualToString:@"id"]) {
        _ids = value;
    }
}

-(id)valueForUndefinedKey:(NSString *)key{
    
    return nil;
    
}

@end
