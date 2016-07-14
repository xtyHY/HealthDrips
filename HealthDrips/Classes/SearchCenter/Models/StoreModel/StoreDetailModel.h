//
//  StoreDetailModel.h
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapSearchKit/AMapSearchKit.h>
@interface StoreDetailModel : NSObject

@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *where;
@property (nonatomic, copy) AMapGeoPoint *location;

@property (nonatomic, copy) NSString *address;  //!< 地址
@property (nonatomic, copy) NSString *tel;  //!< 电话

@end
