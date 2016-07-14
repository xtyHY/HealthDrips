//
//  LiteClassifyModel.h
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//  小分类对象

#import <Foundation/Foundation.h>

@interface LiteClassifyModel : NSObject

@property (nonatomic, copy)NSString * name; //<?小分类名称
@property (nonatomic, copy)NSString * ids;  //<?分类对应api的id

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)fillModelWithDict:(NSDictionary *)dict;

@end
