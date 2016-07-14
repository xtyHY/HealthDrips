//
//  BigClassifyModel.h
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//  大分类对象

#import <Foundation/Foundation.h>

@interface BigClassifyModel : NSObject

@property (nonatomic, copy) NSString * name;   //<?大分类名称
@property (nonatomic, strong) NSArray * liteArr; //<?大分类下的小分类对象数组

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)fillModelWithDict:(NSDictionary *)dict;

@end
