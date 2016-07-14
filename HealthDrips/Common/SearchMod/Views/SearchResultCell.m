//
//  SearchResultCell.m
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "SearchResultCell.h"
#import "SearchResultModel.h"

@interface SearchResultCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;

@end

@implementation SearchResultCell

- (void)setModel:(SearchResultModel *)model{
    
    _model = model;
    
    [_iconImageView setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
    
    _titleLabel.text = _model.name;
    _desLabel.text = _model.descript;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
