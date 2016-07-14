//
//  DiseaseListViewController.h
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

//过滤部位查询枚举
typedef enum : NSUInteger {
    
    DISEASE_CLASSIFY_DEPARTMENT,
    DISEASE_CLASSIFY_BODY
    
} DISEASE_CLASSIFY_FILTER;

@interface DiseaseListViewController : UITableViewController

@property (nonatomic,assign)DISEASE_CLASSIFY_FILTER type;
@property (nonatomic,copy)NSString * ids;

@end
