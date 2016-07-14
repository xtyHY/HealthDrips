//
//  ClassifyModel.h
//  HealthDrips
//
//  Created by Arom.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassifyModel : NSObject

@property(nonatomic,assign)NSInteger id;

@property(nonatomic,copy)NSString * name;

- (instancetype)initwithDict:(NSDictionary *)dict;

+ (instancetype)ModelwithDict:(NSDictionary *)dict;

@end
