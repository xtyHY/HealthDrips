//
//  StoreModel.m
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "StoreModel.h"

@implementation StoreModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        self.ids = value;
    }
}

- (id)valueForUndefinedKey:(NSString *)key{
    
    return nil;
}


@end
