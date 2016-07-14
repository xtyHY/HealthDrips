//
//  SearchResultModel.h
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResultModel : NSObject

@property (nonatomic, copy) NSString * ids;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * descript;
@property (nonatomic, copy) NSString * img;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)fillModelWithDict:(NSDictionary *)dict;

@end
