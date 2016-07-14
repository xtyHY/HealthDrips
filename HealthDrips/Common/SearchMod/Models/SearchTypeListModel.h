//
//  SearchTypeListModel.h
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchTypeListModel : NSObject

@property (nonatomic, copy) NSString * typeName;        //<?类型名称
@property (nonatomic, copy) NSString * typeIdentify;    //<?类型标识
@property (nonatomic, assign) NSInteger total;          //<?结果数量

@end
