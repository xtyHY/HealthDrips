//
//  DiseaseListCell.m
//  HealthDrips
//
//  Created by HY on 15-11-3.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "DiseaseListCell.h"
#import "DiseaseListModel.h"

@interface DiseaseListCell()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation DiseaseListCell

- (void)setModel:(DiseaseListModel *)model{
    
    _model = model;
    
    self.nameLabel.text = model.name;
    self.messageLabel.text = model.descript;
}

- (void)awakeFromNib {
    
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.borderWidth = 1.0f;
    self.contentView.layer.borderColor = THEME_LIGHT_GRAY.CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
