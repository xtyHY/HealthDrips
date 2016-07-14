//
//  BookCell.h
//  HealthDrips
//
//  Created by Cedric.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsGeneralModel;
@protocol BookCellDelegate <NSObject>

- (void)getBookModel:(NewsGeneralModel *)model;

@end

@interface BookCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UICollectionView *bookCollection;
@property (weak, nonatomic) IBOutlet UILabel *tyoeLabel;
@property (weak , nonatomic) id <BookCellDelegate> delegate;
- (void)addModelArray:(NSArray *)array;

@end
