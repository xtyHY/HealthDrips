//
//  LoreCell.m
//  HealthDrips
//
//  Created by Cedric.
//  Copyright © 2015年 UpTeam. All rights reserved.
//

#import "LoreCell.h"
#import "NewsGeneralModel.h"

#import "InfoMacros.h"

@interface LoreCell()


@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UIImageView *firstImage;
@property (weak, nonatomic) IBOutlet UIImageView *secondImage;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImage;
@property (weak, nonatomic) IBOutlet UIImageView *fourthImage;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;
@property (weak, nonatomic) IBOutlet UILabel *fourthLabel;
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIView *thirdView;
@property (weak, nonatomic) IBOutlet UIView *fourthView;

@property (nonatomic , strong) NSArray * array;

@end

@implementation LoreCell

- (void)awakeFromNib {
    
    int i = 0;
    //给视图添加点击事件
    NSArray * viewArr = @[self.firstView, self.secondView, self.thirdView, self.fourthView];
    for (UIView * view in viewArr) {
    
        UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView:)];
        [view addGestureRecognizer:tapGestureRecognizer];
        view.tag = 100+i;
        i++;
        

    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//点击跳转到详情
- (void)clickView:(UITapGestureRecognizer *)tap{

    NewsGeneralModel * model = [[NewsGeneralModel alloc] init];
    
    model = _array[tap.view.tag - 100];
    
    if ([self.delegate respondsToSelector:@selector(getModel:)]) {
        [self.delegate getModel:model];
    }
}

- (void)addModelArray:(NSArray *)array{

    self.array = array.copy;
    
    NSArray * imgArr = @[self.firstImage, self.secondImage, self.thirdImage, self.fourthImage];
    NSArray * labArr = @[self.firstLabel, self.secondLabel, self.thirdLabel, self.fourthLabel];
    
    //给tabView填充数据
    for (int i = 0; i < 4; i++) {
        
        
        NewsGeneralModel * model = array[i];
        [imgArr[i] setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@_200x120",API_PIC,model.img]] placeholderImage:[UIImage imageNamed:@"ImgDefaultLore"]];
        [imgArr[i] setFrame:CGRectMake([imgArr[i] frame].origin.x, [imgArr[i] frame].origin.y, [imgArr[i] frame].size.width, [imgArr[i] frame].size.width * 0.618)];
        [labArr[i] setText:model.title];
    }
    
    self.typeLab.text = LORE_TYPE[[array[4] intValue]];
    self.typeLab.tintColor = Srand_Color;
}

@end
