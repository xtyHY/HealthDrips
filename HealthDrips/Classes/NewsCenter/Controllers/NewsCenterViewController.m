//
//  NewsCenterViewController.m
//  HealthDrips
//
//  Created by Cedric.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "NewsCenterViewController.h"

#import "HealthDrips.pch"
#import "InfoMacros.h"

#import "InfoViewController.h"
#import "LoreViewController.h"
#import "BookViewController.h"


@interface NewsCenterViewController ()<UIScrollViewDelegate>{

    InfoViewController * infoVC;
    LoreViewController * loreVC;
    BookViewController * bookVC;
}

//标题按钮的数组
@property (nonatomic , strong) NSMutableArray * items;
//控制器数组
@property (nonatomic , strong) NSArray * controllers;
//标题视图
@property (nonatomic , strong) UIView * titleView;
//分页视图
@property (nonatomic , strong) UIScrollView * pagingView;
//当前视图
@property (nonatomic , strong) UIViewController * currentViewController;

@end

@implementation NewsCenterViewController


#pragma mark --生命周期--
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark --创建界面--
- (void)createUI{
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self setNavItem];
    
    [self createPaging];
    
    [self loadController];
}

#pragma mark 自定制navigationItem
- (void)setNavItem{
    
    _items = [[NSMutableArray alloc] init];

    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/4.0f*3, 40)];
    CGFloat btnW = _titleView.bounds.size.width/3.0f;
    self.navigationItem.titleView = _titleView;
    
    NSArray * titleArr = @[@"资讯",@"知识",@"图书"];
    
    for (int i = 0; i < 3; i++) {
        
        UIButton * titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(btnW*i, 0, btnW, 35)];
        [titleBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [titleBtn setTitleColor:RGB(0, 0, 0) forState:UIControlStateSelected];
        titleBtn.tag = INFO_BUTTON_TAG+i;
        titleBtn.selected = i?0:1;
        [titleBtn addTarget:self action:@selector(clickTitle:) forControlEvents:UIControlEventTouchUpInside];
        [_titleView addSubview:titleBtn];
        [_items addObject:titleBtn];
    }
    
    //指示条
    UIView * strip = [[UIView alloc] initWithFrame:CGRectMake(0, 39, btnW, 3)];
    strip.tag = STRIP_TAG;
    strip.backgroundColor = RGB(0, 0, 0);
    [_titleView addSubview:strip];
}

//标题点击事件
- (void)clickTitle:(UIButton *)button{
    
    [_controllers[button.tag - INFO_BUTTON_TAG] isDown] ?0:[_controllers[button.tag - INFO_BUTTON_TAG] downLoadData];
    [_controllers[button.tag - INFO_BUTTON_TAG] setIsDown:YES];
    
    for (UIButton * item in _items) {
        
        if(item.tag == button.tag){
            //拿到点击后的控制器
            
            item.selected = YES;
            UIView * strip = [self.titleView viewWithTag:STRIP_TAG];
            [UIView animateWithDuration:0.2f animations:^{
                strip.frame = CGRectMake(button.frame.origin.x, 37, button.frame.size.width, strip.frame.size.height);
            }];
            
            //切换界面
            [self.pagingView setContentOffset:CGPointMake(SCREEN_WIDTH*(button.tag - 100), 0) animated:YES];
            
        }else{
        
            item.selected = NO;
        }
    }
}


#pragma mark 创建分页
- (void)createPaging{

    self.pagingView = [[UIScrollView alloc] initWithFrame:SCREEN_RECT];
    
    self.pagingView.contentSize = CGSizeMake(SCREEN_WIDTH*3, SCREEN_HEIGHT);
    self.pagingView.pagingEnabled = YES;
    self.pagingView.showsHorizontalScrollIndicator = NO;
    self.pagingView.bounces = NO;
    self.pagingView.delegate = self;
    
    [self.view addSubview:self.pagingView];
}

//滚动监听
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    float offset = scrollView.contentOffset.x;
    int page = (offset + SCREEN_WIDTH/2)/SCREEN_WIDTH;
    
    
    
    [_controllers[page] isDown]?:[_controllers[page] downLoadData];
    [_controllers[page] setIsDown:YES];
    
    for (UIButton * item in _items) {
        
        if(item.tag == page+100){
            
            
            item.selected = YES;
            UIView * strip = [self.titleView viewWithTag:STRIP_TAG];
            [UIView animateWithDuration:0.2f animations:^{
                strip.frame = CGRectMake(item.frame.origin.x, 37, item.frame.size.width, strip.frame.size.height);
            }];
            
        }else{
            
            item.selected = NO;
        }
    }
}

#pragma mark 在主控制器中加载控制器
- (void)loadController{

    infoVC = [[InfoViewController alloc] init];
//    UINavigationController * nvc1 = [[UINavigationController alloc] initWithRootViewController:infoVC];
    infoVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.pagingView.bounds.size.height);
    infoVC.requestType = Enum_InfoPage;
    
    loreVC = [[LoreViewController alloc] init];
//    UINavigationController * nvc2 = [[UINavigationController alloc] initWithRootViewController:loreVC];
    loreVC.view.frame = CGRectMake(SCREEN_WIDTH, 0,SCREEN_WIDTH, self.pagingView.bounds.size.height);
    loreVC.requestType = Enum_LorePage;
    
    bookVC = [[BookViewController alloc] init];
//    UINavigationController * nvc3 = [[UINavigationController alloc] initWithRootViewController:bookVC];
    bookVC.view.frame = CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, self.pagingView.bounds.size.height);
    
    _controllers = [[NSArray alloc] initWithObjects:infoVC, loreVC, bookVC, nil];
    [self.pagingView addSubview:infoVC.view];
    [self.pagingView addSubview:loreVC.view];
    [self.pagingView addSubview:bookVC.view];
    
    
    [self addChildViewController:infoVC];
    [self addChildViewController:loreVC];
    [self addChildViewController:bookVC];
}


@end
