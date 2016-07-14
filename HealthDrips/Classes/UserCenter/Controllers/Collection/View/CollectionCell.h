//
//  CollectionCell.h
//  HealthDrips
//
//  Created by Arom.
//  Copyright © 2015年 UpTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CollectionModel;

@interface CollectionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)fillWithModel:(CollectionModel *)model;

@end
