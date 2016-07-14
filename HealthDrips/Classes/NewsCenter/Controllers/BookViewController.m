//
//  BookViewController.m
//  HealthDrips
//
//  Created by Cedric.
//  Copyright © 2015年 UpTeam. All rights reserved.
//

#import "BookViewController.h"

#import "BookCell.h"
#import "NewsGeneralModel.h"

@interface BookViewController ()

@end

@implementation BookViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    
    self.requestType = Enum_BookPage;
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
