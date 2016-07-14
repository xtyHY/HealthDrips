//
//  FoodNameModel.h
//  HealthDrips
//
//  Created by Arom.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodNameModel : NSObject

//@property(nonatomic,assign)NSInteger id;

@property(nonatomic,copy)NSString * name;

@property(nonatomic,copy)NSString * img;

@property(nonatomic,copy)NSString * food;

@property(nonatomic,copy)NSString * ids;

@property(nonatomic,copy)NSString * message;

@property(nonatomic,copy)NSString * symptom;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end
