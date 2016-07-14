//
//  listNameCollectionViewCell.m
//  HealthDrips
//
//  Created by Arom.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//


#import "listNameCollectionViewCell.h"
#import "CookListNameModel.h"
#import "UIImageView+AFNetworking.h"
@implementation listNameCollectionViewCell

-(void)fillWithmodel:(CookListNameModel *)model{

    self.name.text = model.name;
    [self.img setImageWithURL:[NSURL URLWithString:[API_PIC stringByAppendingPathComponent:model.img]] placeholderImage:[UIImage imageNamed:@"ImgDefaultSqure.png"]];
}

- (void)awakeFromNib {
    
    self.name.backgroundColor = THEME_SECTION_HEARD;
    self.name.textColor = [UIColor whiteColor];
    
    self.contentView.backgroundColor = [UIColor whiteColor];
}

@end
