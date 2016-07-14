//
//  SearchTypeListModel.m
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "SearchTypeListModel.h"

@implementation SearchTypeListModel

- (NSString *)description{
    
    return [NSString stringWithFormat:@"%@ %i",self.typeIdentify,self.total];
}

@end
