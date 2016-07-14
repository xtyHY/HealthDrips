//
//  DrugClassifyCell.m
//  HealthDrips
//
//  Created by HY on 15-11-2.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "DrugClassifyCell.h"
#import "LiteClassifyModel.h"

@interface DrugClassifyCell()

@property (nonatomic, strong)UILabel * label;

@end

@implementation DrugClassifyCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, frame.size.width-20, frame.size.height-10)];
        [self.contentView addSubview:self.label];
        
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setModel:(LiteClassifyModel *)model{
    
    _model = model;
    
    _label.text = _model.name;
    
    //设置外观
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = [UIColor blackColor];
    _label.font = [UIFont systemFontOfSize:14];
}

@end
