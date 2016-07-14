//
//  DrugClassifyHeaderView.m
//  HealthDrips
//
//  Created by HY on 15-11-3.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "DrugClassifyHeaderView.h"

@implementation DrugClassifyHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //放置一个label
        UILabel * label = [[UILabel alloc] initWithFrame:self.bounds];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:16];
        [self addSubview:label];
    }
    return self;
}

//set的时候去替换text
- (void)setText:(NSString *)text{
    
    _text = text;
    ((UILabel *)[self subviews][0]).text = _text;
}

@end
