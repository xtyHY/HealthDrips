//
//  BookCoverCell.h
//  HealthDrips
//
//  Created by Cedric.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsGeneralModel.h"

@interface BookCoverCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

- (void)refreshCellWithModel:(NewsGeneralModel *)model;
@end
