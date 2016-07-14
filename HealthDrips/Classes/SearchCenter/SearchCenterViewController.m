//
//  SearchCenterViewController.m
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "SearchCenterViewController.h"

#import "DrugMainController.h"
#import "DiseaseMainController.h"
#import "StoreMainController.h"
#import "HospitalMainController.h"

#import "SearchViewController.h"
#import "ScanQRCodeViewController.h"


@interface SearchCenterViewController ()<UISearchControllerDelegate, UISearchBarDelegate>



@end

@implementation SearchCenterViewController

- (void)creatUI{
    
    self.view.backgroundColor = THEME_LIGHT_GRAY;
    
    //===创建搜索样式
    [self customNavBar];
    
    [self creatMainView];
}
#pragma mark 创建搜索界面
- (void)customNavBar{
    self.title = @"发现";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

#pragma mark 创建主要元素
- (void)creatMainView{
    
    //==1==创建搜索区域
    UIView * searchView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    searchView.backgroundColor = THEME_MAIN_COLOR;
    [self.view addSubview:searchView];
    
    //=跳转搜索界面
    UIButton * searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 30)];
    searchBtn.layer.masksToBounds = YES;
    searchBtn.layer.borderColor = RGB(230, 230, 230).CGColor;
    searchBtn.layer.borderWidth = 1.0f;
    searchBtn.backgroundColor = [UIColor whiteColor];
    [searchBtn addTarget:self action:@selector(clickSearch) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:searchBtn];
    
    //=文字和图标
    UIImageView * searchImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 15, 15)];
    searchImage.image = [UIImage imageNamed:@"NavBarIcon-Search"];
    [searchBtn addSubview:searchImage];
    UILabel * searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, self.view.bounds.size.width-70, 20)];
    searchLabel.text = @"药品/疾病/食物/菜谱/医院";
    searchLabel.textColor = RGB(200, 200, 200);
    searchLabel.font = [UIFont systemFontOfSize:14];
    [searchBtn addSubview:searchLabel];
    
    //=扫描二维码
    UIButton * scanQRCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-50, 2, 26, 26)];
    [scanQRCodeBtn setImage:[UIImage imageNamed:@"scanQRCodeBlack"] forState:UIControlStateNormal];
    [scanQRCodeBtn addTarget:self action:@selector(scanQRCode) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn addSubview:scanQRCodeBtn];
    
    //==2==创建主要功能按钮
    float margin = 10;
    float marginView = 4;
    float width = (SCREEN_WIDTH-margin*2-marginView)/2.0f;
    float height = width;
    //药品
    UIButton * drugBtn = [[UIButton alloc] initWithFrame:CGRectMake(margin, 30+margin*2, width, height)];
    //疾病
    UIButton * diseaseBtn = [[UIButton alloc] initWithFrame:CGRectMake(margin+marginView+width, 30+margin*2, width, height)];
    //药店
    UIButton * storeBtn = [[UIButton alloc] initWithFrame:CGRectMake(margin, 30+margin*2+marginView+height, width, height)];
    //医院
    UIButton * hospitalBtn = [[UIButton alloc] initWithFrame:CGRectMake(margin+marginView+width, 30+margin*2+marginView+height, width, height)];
    
    //==放置图片和标题
    NSArray * titleArr = @[@"药品",@"疾病",@"药店",@"医院"];
    NSArray * btnArr = @[drugBtn,diseaseBtn,storeBtn,hospitalBtn];
    NSArray * picArr = @[[UIImage imageNamed:@"SearchCenterDrug2"],
                         [UIImage imageNamed:@"SearchCenterDisease2"],
                         [UIImage imageNamed:@"SearchCenterStore2"],
                         [UIImage imageNamed:@"SearchCenterHospital2"]];
    
    for (int i=0; i<4; i++) {
        
        UIButton * btn = btnArr[i];
        btn.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:btn];
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 30, btn.frame.size.width-100, btn.frame.size.height-100)];
        imageView.image = picArr[i];
        [btn addSubview:imageView];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(35, 30 + imageView.frame.size.height, btn.frame.size.width-70, btn.frame.size.height - imageView.frame.size.height - 40)];
        label.text = titleArr[i];
        label.textAlignment = NSTextAlignmentCenter;
        [btn addSubview:label];
        
        
        btn.tag = SearchCenter_Btn_Tag + i;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark 响应点击事件
- (void)clickBtn:(UIButton *)btn{
    
    if (btn.tag-SearchCenter_Btn_Tag==0) {
        //药品
        self.hidesBottomBarWhenPushed = YES;
        DrugMainController * drugC = [[DrugMainController alloc] init];
        drugC.title = @"药品";
        [self.navigationController pushViewController:drugC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        
    }else if (btn.tag-SearchCenter_Btn_Tag==1){
        //疾病
        self.hidesBottomBarWhenPushed = YES;
        DiseaseMainController * diseaseC = [[DiseaseMainController alloc] init];
        diseaseC.title = @"疾病";
        [self.navigationController pushViewController:diseaseC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        
    }else if (btn.tag-SearchCenter_Btn_Tag==2){
        //药店
        self.hidesBottomBarWhenPushed = YES;
        StoreMainController * storeC = [[StoreMainController alloc] init];
        storeC.title = @"药店";
        [self.navigationController pushViewController:storeC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        
    }else if (btn.tag-SearchCenter_Btn_Tag==3){
        //医院
        self.hidesBottomBarWhenPushed = YES;
        HospitalMainController * hospitalC = [[HospitalMainController alloc] init];
        hospitalC.title = @"医院";
        [self.navigationController pushViewController:hospitalC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        
    }
}

#pragma mark 跳转扫描二维码
- (void)scanQRCode{
    
    self.hidesBottomBarWhenPushed = YES;
    ScanQRCodeViewController * sqrc = [[ScanQRCodeViewController alloc] init];
    sqrc.title = @"扫描条码搜索";
    
    [self.navigationController pushViewController:sqrc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark 跳转搜索中心
- (void)clickSearch{
    
    self.hidesBottomBarWhenPushed = YES;
    SearchViewController * svc = [[SearchViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:svc animated:NO];
    self.hidesBottomBarWhenPushed = NO;

}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
