//
//  LoginViewController.h
//  HealthDrips
//
//  Created by HY.
//  Copyright © 2015年 UpTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol passNicname <NSObject>

- (void)passNicName:(NSString *)nicname;

@end

@interface LoginViewController : UIViewController

@property (nonatomic,assign)id<passNicname>delegate;

- (NSString *)getNickName;

@end
