//
//  foodNameCell.h
//  HealthDrips
//
//  Created by Arom.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodNameModel.h"

@interface foodNameCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *ContainView;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *food;

- (void)fillWithModel:(FoodNameModel *)model;

@end
