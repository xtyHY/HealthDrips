//
//  MainTabBarViewController.m
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "NewsCenterViewController.h"
#import "FoodCenterViewController.h"
#import "SearchCenterViewController.h"
#import "UserCenterViewController.h"
@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createTabBar];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)createTabBar{
    
    NewsCenterViewController *newsVC = [[NewsCenterViewController alloc]init];
    FoodCenterViewController *foodVC = [[FoodCenterViewController alloc]init];
    SearchCenterViewController *searchVC = [[SearchCenterViewController alloc]init];
    UserCenterViewController *userVC = [[UserCenterViewController alloc]init];
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:newsVC,foodVC,searchVC,userVC, nil];
    NSArray *titleArray = @[@"资讯",@"饮食",@"发现",@"个人"];
    for (int i = 0; i < 4; i++) {
        //分别找到每一个视图控制器
        UIViewController *vc = array[i];
        //添加标题
        vc.title = titleArray[i];
        //将根控制器的视图转换器转换为导航控制器
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        //将数组array中的视图控制器分别替换为导航控制器
        [array replaceObjectAtIndex:i withObject:nav];
        
        //设置navBar的背景颜色为主题颜色
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBarBgColor.png"] forBarMetrics:UIBarMetricsDefault];
        //设置文字的颜色
        [nav.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
        
        //去除navBar下面的黑线
        [nav.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    }
    self.viewControllers = array;
    
    //==定制tabBarItem
    //设置选中颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:THEME_TAB_BAR_TEXT_COLOR} forState:UIControlStateSelected];
    //设置图标填充颜色
    [self.tabBar setTintColor:THEME_TAB_BAR_TEXT_COLOR];
    //关闭背景色
    self.tabBar.translucent = NO;
    
    //资讯
    newsVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"资讯" image:[UIImage imageNamed:@"TabBarIcon-News.png"] selectedImage:[UIImage imageNamed:@"TabBarIcon-News-Sel.png"] ];
    //饮食
    foodVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"饮食" image:[UIImage imageNamed:@"TabBarIcon-Food.png"] selectedImage:[UIImage imageNamed:@"TabBarIcon-Food-Sel.png"]];
    //发现
    searchVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:[UIImage imageNamed:@"TabBarIcon-Search.png"] selectedImage:[UIImage imageNamed:@"TabBarIcon-Search-Sel.png"]];
    //个人
    userVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"个人" image:[UIImage imageNamed:@"TabBarIcon-User.png"] selectedImage:[UIImage imageNamed:@"TabBarIcon-User-Sel.png"]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
