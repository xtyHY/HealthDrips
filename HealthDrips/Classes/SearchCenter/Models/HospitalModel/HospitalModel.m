//
//  HospitalModel.m
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "HospitalModel.h"

@implementation HospitalModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        self.idStr = value;
    }
}

- (id)valueForUndefinedKey:(NSString *)key{
    
    return nil;
}
@end
