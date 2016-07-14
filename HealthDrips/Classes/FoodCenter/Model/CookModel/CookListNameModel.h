//
//  CookListNameModel.h
//  HealthDrips
//
//  Created by Arom.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CookListNameModel : NSObject

@property(nonatomic,copy)NSString * img;

@property(nonatomic,copy)NSString * name;

@property(nonatomic,copy)NSString * ids;

- (instancetype)initwithDict:(NSDictionary *)dict;

+ (instancetype)ModelwithDict:(NSDictionary *)dict;


@end
