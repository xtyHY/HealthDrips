//
//  BookCoverCell.m
//  HealthDrips
//
//  Created by Cedric.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "BookCoverCell.h"
#import "UIImageView+AFNetworking.h"

@implementation BookCoverCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)refreshCellWithModel:(NewsGeneralModel *)model{
    
    self.titleLabel.text = model.title;
    self.authorLabel.text = model.author;
    [self.coverImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",API_PIC,model.img]] placeholderImage:[UIImage imageNamed:@"ImgDefaultBook"]];
}

@end
