//
//  cookNameCell.m
//  HealthDrips
//
//  Created by Arom.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "cookNameCell.h"
#import "UIImageView+WebCache.h"

@implementation cookNameCell

- (void)fillWithModel:(CookNameModel *)model{

    [self.img setImageWithURL:[NSURL URLWithString:[API_PIC stringByAppendingPathComponent:model.img]] placeholderImage:[UIImage imageNamed:@"ImgDefaultSqure.png"]];
    self.name.text = model.name;
    self.food.text = model.food;
}

- (void)awakeFromNib {
    // Initialization code
    self.img.layer.masksToBounds = YES;
    self.img.layer.cornerRadius = 10;
    self.img.layer.borderWidth = 1;
    self.img.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
