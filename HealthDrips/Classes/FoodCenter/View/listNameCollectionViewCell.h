//
//  listNameCollectionViewCell.h
//  HealthDrips
//
//  Created by Arom.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CookListNameModel.h"
@interface listNameCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *name;
- (void)fillWithmodel:(CookListNameModel *)model;
@end
