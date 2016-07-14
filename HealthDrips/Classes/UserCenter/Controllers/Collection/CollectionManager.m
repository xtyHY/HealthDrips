//
//  CollectionManager.m
//  HealthDrips
//
//  Created by Arom.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "CollectionManager.h"
#import "CollectionModel.h"

@implementation CollectionManager

- (instancetype)init{

    if (self == [super init]) {
        
        //锁初始化
        _lock = [[NSLock alloc] init];
        
        NSString * dbPath = [NSString stringWithFormat:@"%@/Documents/DB",NSHomeDirectory()];
        _dataBase = [[FMDatabase alloc] initWithPath:dbPath];
        NSLog(@"-----%@",NSHomeDirectory());
        //判断数据库是否打开
        BOOL isOpen = [_dataBase open];
        if (isOpen) {
            
            NSString * SQL = @"create table if not exists  DB(id integer primary key autoincrement, ids varchar(256) , title varchar(256), TypeName varchar(256), icon varchar(256),userName varchar(256))";
            //判断数据库是否创建成功
            BOOL Success = [_dataBase executeUpdate:SQL];
            if (!Success) {
                NSLog(@"数据库创建失败");
            }
        }
        
    }
    return self;
}

//拿到单例管理对象
+ (instancetype)shareManager{

    static CollectionManager * manager = nil;
    
    if (manager == nil ) {
    
        manager = [[CollectionManager alloc] init];
    }
    return manager;
}

//判断插入是否成功
- (BOOL)insertModel:(CollectionModel *)model{

    [_lock lock];
    
    NSLog(@"%@ %@ %ld %@",model.ids,model.title,model.TypeName,model.icon);
    
    NSString * SQL = @"insert into DB(ids,title,TypeName,icon,userName) values(?,?,?,?,?)";
    BOOL Success = [_dataBase executeUpdate:SQL,model.ids,model.title,[NSString stringWithFormat:@"%ld",model.TypeName],model.icon,model.userName];
    
    NSLog(@"insert%@",model.userName);
    
    if (Success) {
        NSLog(@"插入成功");
    }else{
    
        NSLog(@"插入失败");
    }
    
    [_lock unlock];
    return Success;
}

//判断删除是否成功
- (BOOL)DropModel:(CollectionModel *)model{

    [_lock lock];
    
    NSString * SQL = @"delete from DB where ids = ? and TypeName = ? and userName = ?";
    
    BOOL Success = [_dataBase executeUpdate:SQL,model.ids,[NSString stringWithFormat:@"%ld",model.TypeName],model.userName];
    
    if (Success) {
        NSLog(@"删除成功");
    }else{
    
        NSLog(@"删除失败");
    }
    [_lock unlock];
    return Success;
}

//判断是否收藏
- (BOOL)findModel:(CollectionModel *)model{

    BOOL extit = NO;
    [_lock lock];
    
    NSString * SQL = @"select * from DB where ids = ? and TypeName = ? and userName = ?";
    FMResultSet * result = [_dataBase executeQuery:SQL,model.ids,[NSString stringWithFormat:@"%ld",model.TypeName],model.userName];
    while ([result next]) {
        extit = YES;
        break;
    }
    
    [_lock unlock];
    return extit;
}

- (NSArray *)selectAll{

    NSString *user = [[NSUserDefaults standardUserDefaults] valueForKey:@"nickname"];
    NSLog(@"%@",user);
    [_lock lock];
    
    NSString * SQL = @"select * from DB where userName = ? order by TypeName asc";
    
    FMResultSet * resust = [_dataBase executeQuery:SQL,user];
    
    NSMutableArray * marray = [[NSMutableArray alloc] init];
    while ([resust next]) {
        CollectionModel * model = [[CollectionModel alloc] init];
        
        model.ids = [resust objectForColumnName:@"ids"];
        model.title = [resust objectForColumnName:@"title"];
        model.icon = [resust objectForColumnName:@"icon"];
        model.TypeName = [[resust objectForColumnName:@"TypeName"] integerValue];
        model.userName = [resust objectForColumnName:@"userName"];
        
//        switch ([typeStr integerValue]) {
//            case ShowDetailNews:
//                model.TypeName = ShowDetailNews;
//                break;
//            case ShowDetailLore:
//                model.TypeName = ShowDetailLore;
//                break;
//            case ShowDetailBook:
//                model.TypeName = ShowDetailBook;
//                break;
//            case ShowDetailNews:
//                model.TypeName = ShowDetailNews;
//                break;
//            case ShowDetailNews:
//                model.TypeName = ShowDetailNews;
//                break;
//            case ShowDetailNews:
//                model.TypeName = ShowDetailNews;
//                break;
//            case ShowDetailNews:
//                model.TypeName = ShowDetailNews;
//                break;
//            case ShowDetailNews:
//                model.TypeName = ShowDetailNews;
//                break;
//            case ShowDetailNews:
//                model.TypeName = ShowDetailNews;
//                break;
//                
//            default:
//                break;
//        }
        
        model.icon = [resust objectForColumnName:@"icon"];
        
        [marray addObject:model];
    }
    
    [_lock unlock];
    
    return marray;
}


@end
