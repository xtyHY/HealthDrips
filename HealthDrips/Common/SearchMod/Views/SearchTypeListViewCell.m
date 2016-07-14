//
//  SearchTypeListViewCell.m
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "SearchTypeListViewCell.h"
#import "SearchTypeListModel.h"
@interface SearchTypeListViewCell()

@property (weak, nonatomic) IBOutlet UILabel *typeName;
@property (weak, nonatomic) IBOutlet UILabel *resultCount;

@end

@implementation SearchTypeListViewCell

- (void)setModel:(SearchTypeListModel *)model{
    
    _model = model;
    
    _typeName.text = [NSString stringWithFormat:@"%@相关",model.typeName];
    _resultCount.text = [NSString stringWithFormat:@"约%d条",model.total];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
