//
//  InfoCell.h
//  HealthDrips
//
//  Created by Cedric.
//  Copyright © 2015年 UpTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsGeneralModel.h"

@interface InfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

- (void)addModel:(NewsGeneralModel *)model;

@end
