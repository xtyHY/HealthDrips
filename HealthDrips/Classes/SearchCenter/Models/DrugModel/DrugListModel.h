//
//  DrugListModel.h
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrugListModel : NSObject

@property (nonatomic, copy)NSString * ids; //<? 药品id
@property (nonatomic, copy)NSString * img; //<? 药品图片
@property (nonatomic, copy)NSString * name;//<? 药品名称
@property (nonatomic, copy)NSString * descript; //<?描述

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)filleModelWithDict:(NSDictionary *)dict;

@end
