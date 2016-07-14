//
//  dataDownload.h
//  HealthDrips
//
//  Created by Arom.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dataDownload : NSObject

@property(nonatomic,strong,readonly)NSMutableArray * dataArray; //!<数据源数组
@property(nonatomic,strong,readonly)NSMutableDictionary * dataDictionnary;//<!数据源字典

+ (instancetype)ShareManager;


- (id )DownloadWithUrl:(NSString *)url; //!<大分类搜索

- (id )DownloadWithUrl:(NSString *)url andWithId:(NSInteger)Id;  //!<根据ID搜索

- (id )DownloadWithUrl:(NSString *)url andWithName:(NSString *)name;//!<根据名字搜索

@end

