//
//  StoreModel.h
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreModel : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *img;
@property (nonatomic,copy) NSString *charge;//企业负责人
@property (nonatomic,copy) NSString *type;//经营方式
@property (nonatomic,assign) int count;//访问数
@property (nonatomic,assign) int fcount;//收藏数
@property (nonatomic,copy) NSString *ids;
@property (nonatomic,copy) NSString *message;
@property (nonatomic,assign) float x;
@property (nonatomic,assign) float y;
@property (nonatomic,copy) NSString *tel;
@property (nonatomic,copy) NSString *zipcode;//邮编
@property (nonatomic,copy) NSString *url;//官方网站
@property (nonatomic,copy) NSString *number;//证号
@property (nonatomic,copy) NSString *leader;//质量负责人
@property (nonatomic,copy) NSString *legal;//法定代表人
@property (nonatomic,copy) NSString *business;//经营范围
@property (nonatomic,copy) NSString *waddress;//仓库地址
@property (nonatomic,assign) int supervise;//审核部门


@end
