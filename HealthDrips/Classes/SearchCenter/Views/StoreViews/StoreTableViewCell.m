//
//  StoreTableViewCell.m
//  HealthDrips
//
//  Created by 尹宁 on 15/11/2.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "StoreTableViewCell.h"

@implementation StoreTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addModel:(StoreModel *)model{
    
    [self.img setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",API_PIC,model.img]]
             placeholderImage:[UIImage imageWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ImgDefaultSqure" ofType:@"png"]]]
     ];
    self.name.text = model.name;
    self.address.text = model.address;
    self.business.text = model.business;
    self.type.text = model.type;
}

@end
