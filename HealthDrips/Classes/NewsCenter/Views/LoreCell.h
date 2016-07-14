//
//  LoreCell.h
//  HealthDrips
//
//  Created by Cedric.
//  Copyright © 2015年 UpTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NewsGeneralModel.h"

@protocol LoreCellDelegate <NSObject>

- (void)getModel:(NewsGeneralModel *)model;

@end

@interface LoreCell : UITableViewCell

@property (nonatomic , copy) NSString * type;

@property (nonatomic , copy) void(^dataBlock)(NewsGeneralModel * model);

@property (nonatomic , weak) id <LoreCellDelegate> delegate;

- (void)addModelArray:(NSArray *)array;


@end
