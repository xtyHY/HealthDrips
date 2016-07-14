//
//  DrugListCell.m
//  HealthDrips
//
//  Created by HY on 15-11-3.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "DrugListCell.h"
#import "DrugListModel.h"
#import "UIImageView+WebCache.h"

@interface DrugListCell()

@property (weak, nonatomic) IBOutlet UIImageView *drugImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptTextView;

@end

@implementation DrugListCell

- (void)setModel:(DrugListModel *)model{
    
    _model = model;
    
    [_drugImage setImageWithURL:[NSURL URLWithString:[API_PIC stringByAppendingPathComponent:_model.img]]
               placeholderImage:[UIImage imageWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ImgDefaultSqure" ofType:@"png"]]]
     ];
    
    _nameLabel.text = model.name;
    
    _descriptTextView.text = model.descript;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
