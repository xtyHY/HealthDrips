//
//  LoadClassifyManager.h
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//
//  用于从plist中读取类型文件，并返回分类模型对象的数组

#import <Foundation/Foundation.h>

@interface LoadClassifyManager : NSObject

/**
 创建[读取分类信息]的单例对象
 */
+ (instancetype)shareManager;

/**
 通过分类名称(如:HD_Classify_Area)获取分类的模型
 */
- (NSArray *)getClassifyModelWithClassifyName:(NSString *)classifyName;

@end
