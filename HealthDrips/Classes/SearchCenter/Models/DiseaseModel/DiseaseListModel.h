//
//  DiseaseListModel.h
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiseaseListModel : NSObject

@property (nonatomic, copy) NSString * ids;         //<? id
@property (nonatomic, copy) NSString * name;        //<? 名称
@property (nonatomic, copy) NSString * descript;     //<? 简介

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)fillModelWithDict:(NSDictionary *)dict;

@end
