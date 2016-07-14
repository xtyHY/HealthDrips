//
//  HospitalTableViewCell.m
//  HealthDrips
//
//  Created by 尹宁 on 15/11/2.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "HospitalTableViewCell.h"

@implementation HospitalTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addHospitalModel:(HospitalModel *)model{
    
    self.name.text = model.name;
    self.address.text = model.address;
    self.mtype.text = model.mtype;

    if ([model.tel isEqualToString:@""]) {
        self.tel.text = @"暂无";
    }else{
        self.tel.text = model.tel;
    }
    [self.img setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",API_PIC,model.img]]
             placeholderImage:[UIImage imageWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ImgDefaultSqure" ofType:@"png"]]]];
    self.tel.text = model.tel;
}

@end
