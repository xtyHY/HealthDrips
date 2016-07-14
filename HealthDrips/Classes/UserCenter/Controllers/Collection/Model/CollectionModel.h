//
//  CollectionModel.h
//  HealthDrips
//
//  Created by Arom.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionModel : NSObject

@property(nonatomic,copy)NSString * ids;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,assign)ShowDetailType TypeName;
@property(nonatomic,copy)NSString * icon;
@property(nonatomic,copy)NSString * userName;

//- (void)initWithDict:(NSDictionary *)dict;
//
//+ (void)AddWithDict:(NSDictionary *)dict;

@end
