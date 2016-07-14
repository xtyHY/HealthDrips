//
//  AppDelegate.m
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "UMSocial.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    [AMapServices sharedServices].apiKey = KEY_AMAP;
    [UMSocialData setAppKey:KEY_UMENG];
    
    MainTabBarViewController *mainVC = [[MainTabBarViewController alloc]init];
    self.window.rootViewController = mainVC;
    
    //设置状态栏字体颜色为白色
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    
    //    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"nickname"]==nil) {
    //
    //        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"nickname"];
    //    }
    ////[[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"nickname"]
    //    NSLog(@"====%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"nickname"]);
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    
    if(![NetTool shareTool].isReachable){
        
        UIAlertView * _alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"无网络访问,请检查网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [_alertView show];
        return;
    }
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
