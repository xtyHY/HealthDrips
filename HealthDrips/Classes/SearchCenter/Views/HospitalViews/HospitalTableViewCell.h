//
//  HospitalTableViewCell.h
//  HealthDrips
//
//  Created by 尹宁 on 15/11/2.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HospitalModel.h"
#import "LiteClassifyModel.h"
@interface HospitalTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *mtype;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *tel;

- (void)addHospitalModel:(HospitalModel *)model;


@end
