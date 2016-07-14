//
//  ClassifyModel.m
//  HealthDrips
//
//  Created by Arom.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "ClassifyModel.h"

@implementation ClassifyModel

-(instancetype)initwithDict:(NSDictionary *)dict{

    if (self == [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
    }
    return self;
}

+(instancetype)ModelwithDict:(NSDictionary *)dict{

    return [[self alloc] initwithDict:dict];
    
}


//没有写全部属性时需要写这个
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

-(id)valueForUndefinedKey:(NSString *)key{

    return nil;
    
}


@end
