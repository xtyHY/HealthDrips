//
//  InfoCell.m
//  HealthDrips
//
//  Created by Cedric.
//  Copyright © 2015年 UpTeam. All rights reserved.
//

#import "InfoCell.h"
#import "UIImageView+WebCache.h"
#import "HealthDrips.pch"
#import "InfoMacros.h"

@implementation InfoCell


- (void)addModel:(NewsGeneralModel *)model{

    [self.img setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@_400x240",API_PIC,model.img]] placeholderImage:[UIImage imageNamed:@"ImgDefaultNews.png"]];

    self.titleLab.text = model.title;
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[model.time doubleValue]/1000];
    NSDateFormatter * fm = [[NSDateFormatter alloc] init];
    [fm setDateFormat:@ "yyyy-MM-dd"];
    self.timeLab.text = [fm stringFromDate:date];
    
    //由于接口问题，本来应该是类型是1-7，通过-1后正好对应数组，现在接口数据出现了0
    //为避免这些问题，如果接口返回的类型<1则直接定为1，如果>7则直接定为7
    NSInteger infoClassType = [model.infoclass integerValue];
    infoClassType = infoClassType < 1 ? 1 : infoClassType;
    infoClassType = infoClassType > 7 ? 7 : infoClassType;
    
    //同理知识是1-13
    NSInteger loreClassType = [model.loreclass integerValue];
    loreClassType = loreClassType < 1 ? 1 : loreClassType;
    loreClassType = loreClassType > 13 ? 13 : loreClassType;
    
    NSInteger type = model.infoclass ? infoClassType : loreClassType;
    
    self.typeLab.text = model.infoclass ? INFO_TYPE[type-1] : model.author?model.author:0;
}

- (void)awakeFromNib {
    
    SCREEN_WIDTH<375?self.titleLab.font = [UIFont systemFontOfSize:14]:0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
