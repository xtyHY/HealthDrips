//
//  CollectionCell.m
//  HealthDrips
//
//  Created by Arom.
//  Copyright © 2015年 UpTeam. All rights reserved.
//

#import "CollectionCell.h"
#import "CollectionModel.h"


@implementation CollectionCell

- (void)fillWithModel:(CollectionModel *)model{

    if (model.icon != [NSNull null]) {
       [self.img setImageWithURL:[NSURL URLWithString:[API_PIC stringByAppendingPathComponent:model.icon]] placeholderImage:[UIImage imageNamed:@"ImgDefaultSqure.png"]];
    }else{
    
        self.img.image = [UIImage imageNamed:@"ImgDefaultSqure.png"];
    }
    
    
    self.titleLabel.text = model.title;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
