//
//  StoreMapViewController.h
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
@interface StoreMapViewController : UIViewController

@property (nonatomic, copy) AMapGeoPoint *location;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *where;

@end
