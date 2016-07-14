//
//  ShowDetailViewController.h
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ShowDetailViewController : UIViewController

@property (nonatomic, copy) NSString * ids; //<?文章id
@property (nonatomic, assign) ShowDetailType typeName; //<?所属模块分类ShowDetailType

@end