//
//  InfoDownloadData.h
//  HealthDrips
//
//  Created by Cedric.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsGeneralModel.h"

@protocol GetDataDelegate <NSObject>

- (void)getData:(NSMutableArray *)dataArr;

@end

@interface InfoDownloadData : NSObject

/*
 咨询接口返回数据数组
 */
@property(nonatomic, strong)NSMutableArray * dataArray;

@property(nonatomic, weak)id <GetDataDelegate> delegate;

+ (id)shareDownLoad;

/*
 分类下载
 */
- (NSMutableArray *)downLoadDataWithUrl:(NSString *)url;

/*
 通过id 下载数据 id为：分类id或咨询id
 */
- (NSMutableArray *)downLoadDataWithUrl:(NSString *)url andWithId:(NSInteger)Id;

/*
 通过id 和page 下载数据
 */
- (NSMutableArray *)downLoadDataWithUrl:(NSString *)url andWithId:(NSInteger)Id andWithPage:(NSInteger)page;

/*
 通过id page row 下载数据
 */
- (NSMutableArray *)downLoadDataWithUrl:(NSString *)url andWithId:(NSInteger)Id andWithPage:(NSInteger)page andWithRow:(NSInteger)row;


@end
