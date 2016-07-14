//
//  CollectionManager.h
//  HealthDrips
//
//  Created by Arom.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@class CollectionModel;

@interface CollectionManager : NSObject
{

    NSLock * _lock;
    
    FMDatabase * _dataBase;
}

/**
 单例对象
 */
+ (instancetype)shareManager;

/**
 插入
 */
- (BOOL)insertModel:(CollectionModel *)model;
/**
 查询
 */
- (NSArray *)selectAll;
/**
 删除
 */
- (BOOL)DropModel:(CollectionModel *)model;

/**
 查询一条·
 */
- (BOOL)findModel:(CollectionModel *)model;



@end
