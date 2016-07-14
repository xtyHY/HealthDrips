//
//  DiseaseListCell.h
//  HealthDrips
//
//  Created by HY on 15-11-3.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DiseaseListModel;

@interface DiseaseListCell : UITableViewCell

@property (nonatomic, strong) DiseaseListModel * model;

@end
