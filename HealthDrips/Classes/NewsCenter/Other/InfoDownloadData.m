//
//  InfoDownloadData.m
//  HealthDrips
//
//  Created by Cedric.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "InfoDownloadData.h"
#import "AFNetworking.h"
#import "ApisMacros.h"

@implementation InfoDownloadData

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (id)shareDownLoad{

    static InfoDownloadData * downLoad;
    
    if (downLoad == nil) {
        downLoad = [[InfoDownloadData alloc] init];
        
    }
    
    return downLoad;
}

- (NSMutableArray *)downLoadDataWithUrl:(NSString *)url{

    return [self downLoadDataWithUrl:url andWithId:-1];
}

- (NSMutableArray *)downLoadDataWithUrl:(NSString *)url andWithId:(NSInteger)Id{

    return [self downLoadDataWithUrl:url andWithId:Id andWithPage:-1];
}

- (NSMutableArray *)downLoadDataWithUrl:(NSString *)url andWithId:(NSInteger)Id andWithPage:(NSInteger)page{

    return [self downLoadDataWithUrl:url andWithId:Id andWithPage:page andWithRow:-1];
}

- (NSMutableArray *)downLoadDataWithUrl:(NSString *)url andWithId:(NSInteger)Id andWithPage:(NSInteger)page andWithRow:(NSInteger)row{

    NSString * path = Id == -1?url:page == -1?[NSString stringWithFormat:@"%@?id=%ld",url,Id]:row == -1?[NSString stringWithFormat:@"%@?id=%ld&page=%ld",url,Id,page]:[NSString stringWithFormat:@"%@?id=%ld&page=%ld&rows=%ld",url,Id,page,row];
    
    [_dataArray removeAllObjects];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSError * error = nil;
        
        id data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        
        [_dataArray removeAllObjects];
        
        if([data isKindOfClass:[NSArray class]]){//查询分类
        
            for (NSDictionary * dic in data) {
                [_dataArray addObject:dic];
            }
            
        }else{
            
            if(data[@"tngou"]){//查询资讯列表
            
                for (NSDictionary * dic in data[@"tngou"]) {
                    [_dataArray addObject:dic];
                }
                
            }else{//查询资讯内容
                
                [_dataArray addObject:data];
            }
        }
        
        [_delegate performSelector:@selector(getData:) withObject:_dataArray];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        UIAlertView * NoNetAlert = [[UIAlertView alloc] initWithTitle:@"网络链接出错" message:@"无法连接至服务器..." delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil];
        [NoNetAlert show];
        
    }];

    return _dataArray;
}


@end
