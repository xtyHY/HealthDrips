//
//  foodNameCell.m
//  HealthDrips
//
//  Created by Arom.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "foodNameCell.h"
#import "UIImageView+AFNetworking.h"
#import "FoodNameModel.h"


@implementation foodNameCell

-(void)fillWithModel:(FoodNameModel *)model{

    [self.img setImageWithURL:[NSURL URLWithString:[API_PIC stringByAppendingPathComponent:model.img]]];
    self.name.text = model.name;
    self.food.text = model.food;
}

- (void)awakeFromNib {
    // Initialization code
    
    _ContainView.backgroundColor = [UIColor whiteColor];
    _ContainView.layer.masksToBounds = YES;
    
    _ContainView.layer.borderWidth = 1;
    
    _ContainView.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
