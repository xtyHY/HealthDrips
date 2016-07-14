//
//  dataDownload.m
//  HealthDrips
//
//  Created by Arom.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "dataDownload.h"
#import "AFNetworking.h"

@implementation dataDownload

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

+(instancetype)ShareManager{

    static dataDownload * manager = nil;
    
    if (manager == nil) {
        
        manager = [[dataDownload alloc] init];
        
    }
    
    return manager;
}


-(id)DownloadWithUrl:(NSString *)url{

    return [self DownloadWithUrl:url andWithId:-1 ];
}

-(id)DownloadWithUrl:(NSString *)url andWithId:(NSInteger)Id{
    
    NSString * path = Id==-1 ? url : [NSString stringWithFormat:@"%@?id=%ld",url,Id];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSError * error = nil;
        
        id data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        
        if ([data isKindOfClass:[NSArray class]]) {
            
            _dataArray =[NSMutableArray arrayWithArray:data];
            
        }else if([data isKindOfClass:[NSDictionary class]]){
        
            [_dataArray addObject:data];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"success" object:_dataArray];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"网络请求错误----%@",error.description);
    }];
    
    return _dataArray;
}

- (id)DownloadWithUrl:(NSString *)url andWithName:(NSString *)name{
    
    NSString * path = [NSString stringWithFormat:@"%@?name=%@",url,name];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString * path1 = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [manager GET:path1 parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        NSError * error = nil;
        
        _dataArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.description);
    }];
    
    
    
//    [manager GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        NSError * error = nil;
//        _dataArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
//        
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//        NSLog(@"网络请求错误----%@",error.description);
//    
//    }];
    
    return _dataArray;
}

@end
