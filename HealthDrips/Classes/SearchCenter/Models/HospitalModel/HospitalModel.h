//
//  HospitalModel.h
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HospitalModel : NSObject

@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *img;
@property (nonatomic,copy) NSString *mtype;//是否属于医保
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *nature;//医院性质
@property (nonatomic,assign) float x;
@property (nonatomic,assign) float y;
@property (nonatomic,copy) NSString *idStr;
@property (nonatomic,copy) NSString *tel;

@end
