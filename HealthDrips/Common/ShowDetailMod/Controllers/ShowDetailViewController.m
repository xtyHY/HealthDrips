//
//  ShowDetailViewController.m
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "ShowDetailViewController.h"
#import "MGTemplateEngine.h"
#import "ICUTemplateMatcher.h"
#import "ShowDetailModel.h"
#import "UMSocial.h"
#import "CollectionManager.h"
#import "CollectionModel.h"
#import "UserCenterViewController.h"
#import "LoginViewController.h"

@interface ShowDetailViewController ()<MGTemplateEngineDelegate, UMSocialUIDelegate>{
    
    UIWebView * _webView;
    MGTemplateEngine * _engine;
    NSString * _apiUrl;
    NSString * _webMoudle;
    MBProgressHUD * _HUD;
    UIAlertView * _alertView;
    ShowDetailModel * _model;
    BOOL _isSaved;
    UIButton * _favBtn;
    UIButton * _shareBtn;
    CollectionModel * _collectModel;
    NSString * _userName;
}

@end

@implementation ShowDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    _alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [self initWebView];
    [self initMGTempEngine];
    [self initInfo];
    [self initToolBar];
    [self downloadData];
    [self initFavModel];
    [self judgeFav];
}

#pragma mark - 初始化webView
- (void)initWebView{
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CONTENT_HEIGHT-40)];
    _webView.backgroundColor = [UIColor whiteColor];
    LoginViewController * logVc = [[LoginViewController alloc] init];
    
    
    _userName = [[NSUserDefaults standardUserDefaults] valueForKey:@"nickname"];
    
}

#pragma mark - 初始化控制模板显示的工具
- (void)initMGTempEngine{
    
    _engine = [MGTemplateEngine templateEngine];
    _engine.delegate = self;
    [_engine setMatcher:[ICUTemplateMatcher matcherWithTemplateEngine:_engine]];
}

#pragma mark - 初始化下载地址和模板地址
- (void)initInfo{
    
    _apiUrl = [[NSString alloc] init];
    _webMoudle = [[NSString alloc] init];
    
    
    NSArray * apiUrlArr = @[API_INFO_SHOW,API_LORE_SHOW,API_BOOK_SHOW,
                           API_FOOD_SHOW,API_COOK_SHOW,API_DRUG_SHOW,
                           API_DISEASE_SHOW,API_HOSPITAL_SHOW,API_STORE_SHOW];
    
    NSArray * moudleNameArr = @[@"webMoudle_news",@"webMoudle_news",
                                @"webMoudle_book",@"webMoudle_food_cook_drug",
                                @"webMoudle_food_cook_drug",@"webMoudle_food_cook_drug",
                                @"webMoudle_disease",@"webMoudle_hospital",@"webMoudle_store"];
    
    _apiUrl = apiUrlArr[self.typeName];
    _webMoudle = [[NSBundle mainBundle] pathForResource:moudleNameArr[self.typeName] ofType:@"html"];
}

#pragma mark - 下载数据
- (void)downloadData{
    
    [self HUDStart];
    
    if(![NetTool shareTool].isReachable){
        
        _alertView.message = @"无网络访问,请检查网络";
        [_alertView show];
        [self HUDEnd];
        return;
    }
    
    if (![_apiUrl isEqualToString:@""]) {
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager GET:_apiUrl parameters:@{@"id":self.ids} success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            _model = [ShowDetailModel fillModelWithDict:dict];
            
            _shareBtn.enabled = YES;
            _favBtn.enabled = YES;
            [self dealMould];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            NSLog(@"%@",error);
            _alertView.message = @"下载失败";
            [_alertView show];
            [self HUDEnd];
            return;
        }];
    }else{
        
        _alertView.message = @"加载地址失败";
        [_alertView show];
        [self HUDEnd];
        return;
    }
    
}

#pragma mark - 下载完成后通过model和改变模板
- (void)dealMould{
    
    [_engine setObject:[API_PIC stringByAppendingPathComponent:_model.img] forKey:@"img"];
    [_engine setObject:@(SCREEN_WIDTH-100) forKey:@"picWidth"];
    [_engine setObject:@((SCREEN_WIDTH-100)/16*9) forKey:@"picHeight"];
    
    if (self.typeName == ShowDetailNews || self.typeName ==  ShowDetailLore) {
        
        [_engine setObject:@(SCREEN_WIDTH-16) forKey:@"newPicWidth"];
        [_engine setObject:@((SCREEN_WIDTH-16)) forKey:@"newPicHeight"];
        [_engine setObject:_model.title forKey:@"title"];
        [_engine setObject:_model.descript forKey:@"descript"];
        [_engine setObject:_model.message forKey:@"message"];
        
    }
    else if (self.typeName == ShowDetailBook){
        
        [_engine setObject:@(SCREEN_WIDTH/2-16) forKey:@"bookPicWidth"];
        [_engine setObject:@((SCREEN_WIDTH/2-16)/7*10) forKey:@"bookPicHeight"];
        [_engine setObject:_model.name forKey:@"name"];
        [_engine setObject:_model.author forKey:@"author"];
        [_engine setObject:_model.summary forKey:@"summary"];
        
    }
    else if (self.typeName == ShowDetailFood || self.typeName ==  ShowDetailCook || self.typeName == ShowDetailDrug){
        
        [_engine setObject:_model.name forKey:@"name"];
        [_engine setObject:_model.descript forKey:@"descript"];
        [_engine setObject:_model.message forKey:@"message"];
        
    }else if (self.typeName == ShowDetailDisease){
        
        [_engine setObject:_model.name forKey:@"name"];
        [_engine setObject:_model.descript forKey:@"descript"];
        [_engine setObject:[self strIsNull:_model.department] forKey:@"department"];
        [_engine setObject:[self strIsNull:_model.causetext] forKey:@"causetext"];
        [_engine setObject:[self strIsNull:_model.symptomtext] forKey:@"symptomtext"];
        [_engine setObject:[self strIsNull:_model.foodtext] forKey:@"foodtext"];
        [_engine setObject:[self strIsNull:_model.drugtext] forKey:@"drugtext"];
        [_engine setObject:[self strIsNull:_model.checktext] forKey:@"checktext"];
    }
    else if (self.typeName == ShowDetailHospital){
        
        [_engine setObject:_model.name forKey:@"name"];
        [_engine setObject:_model.message forKey:@"message"];
        [_engine setObject:_model.address forKey:@"address"];
        [_engine setObject:_model.level forKey:@"level"];
        [_engine setObject:_model.tel forKey:@"tel"];
        
    }else if (self.typeName == ShowDetailStore){
        
        [_engine setObject:_model.name forKey:@"name"];
        [_engine setObject:_model.leader forKey:@"leader"];
        [_engine setObject:_model.legal forKey:@"legal"];
        [_engine setObject:_model.business forKey:@"business"];
        [_engine setObject:_model.address forKey:@"address"];
        [_engine setObject:_model.tel forKey:@"tel"];
    }
    
    NSString *html = [_engine processTemplateInFileAtPath:_webMoudle withVariables:nil];
    
//    NSLog(@"%@",html);
    
    [_webView loadHTMLString:html baseURL:nil];
    [self.view addSubview:_webView];
    
    [self HUDEnd];
}

- (NSString *)strIsNull:(NSString *)str{
    
    return [str isEqualToString:@""] ? @"暂无" : str;
}

- (void)initToolBar{
    
    self.navigationController.toolbarHidden = NO;
    [self.navigationController.toolbar setTranslucent:NO];
    
    //分享按钮
    _shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [_shareBtn setImage:[[UIImage imageNamed:@"setting-icon-share-black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_shareBtn addTarget:self action:@selector(shareClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * shareItem = [[UIBarButtonItem alloc] initWithCustomView:_shareBtn];
    
    _favBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [_favBtn setImage:[[UIImage imageNamed:@"setting-icon-fav-black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_favBtn setImage:[[UIImage imageNamed:@"setting-icon-fav-black-selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [_favBtn addTarget:self action:@selector(favClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * favItem = [[UIBarButtonItem alloc] initWithCustomView:_favBtn];
    
    UIBarButtonItem * space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    self.toolbarItems = @[space,shareItem,space,favItem,space];
    
    _shareBtn.enabled = NO;
    _favBtn.enabled = NO;
}

#pragma mark - 分享
- (void)shareClicked:(UIButton *)btn{
    
    if (_model==nil) {
        
        return;
    }
    
    UIImage * img = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"logo-text" ofType:@"png"]];
    NSString * title = [[NSString alloc] init];
    NSString * shareText = [[NSString alloc] init];
    
    NSArray * detailUrl = @[WEB_SHARE_NEWS,WEB_SHARE_LORE,
                            WEB_SHARE_BOOK,WEB_SHARE_FOOD,
                            WEB_SHARE_COOK,WEB_SHARE_DRUG,
                            WEB_SHARE_DISEASE,WEB_SHARE_HOSPITAL,
                            WEB_SHARE_STORE];
    
    if (self.typeName == ShowDetailNews || self.typeName ==  ShowDetailLore)
        title = _model.title;
    else
        title = _model.name;
    
    NSString * baseUrl = [NSString stringWithFormat:@"%@%@",detailUrl[self.typeName],_model.ids];
    
    shareText = [NSString stringWithFormat:@"我正在看:%@ %@ \n健康从点滴做起",title,baseUrl];
    
    [self shareWithText:shareText andImage:img];
    
}

- (void)shareWithText:(NSString *)text andImage:(UIImage *)image{
    
    NSArray * SNSArray = @[UMShareToSina,UMShareToTencent,
                           UMShareToDouban,UMShareToRenren,
                           UMShareToEmail,UMShareToSms];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:KEY_UMENG
                                      shareText:text
                                     shareImage:image
                                shareToSnsNames:SNSArray
                                       delegate:self];
}

- (void)favClicked:(UIButton *)btn{
    
    
      if (_userName==nil) {
        
        NSLog(@"9999999 %@",_userName);
        
        UIAlertView * NoLoginAlertVc = [[UIAlertView alloc] initWithTitle:@"您还没有登录，不能收藏" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [NoLoginAlertVc show];
        
    }else{
        
        _collectModel.icon = _model.img;
        
        NSLog(@"收藏");
        NSLog(@"11111--%@",_model.img);
        if (self.typeName == ShowDetailNews || self.typeName == ShowDetailLore) {
            _collectModel.title = _model.title;
        }
        if (self.typeName == ShowDetailStore || self.typeName == ShowDetailHospital || self.typeName == ShowDetailFood || self.typeName == ShowDetailDrug || self.typeName == ShowDetailDisease || self.typeName == ShowDetailCook || self.typeName == ShowDetailBook) {
            _collectModel.title = _model.name;
        }
        
        NSString * Alerttitle;
        NSString * AlertMsg;
        
        if (_isSaved) {
            Alerttitle =@"取消收藏";
            BOOL Success = [[CollectionManager shareManager] DropModel:_collectModel];
            
            if (Success) {
                AlertMsg =@"取消成功";
                _isSaved = NO;
                _favBtn.selected = _isSaved;
                
            }else{
                
                AlertMsg = @"取消失败";
                
            }
        }else{
            
            Alerttitle = @"添加收藏";
            NSLog(@"====%@",_collectModel);
            BOOL Success = [[CollectionManager shareManager] insertModel:_collectModel];
            
            if (Success) {
                AlertMsg = @"添加成功";
                _isSaved = YES;
                _favBtn.selected = _isSaved;
            }else{
                
                AlertMsg = @"添加失败";
                
            }
        }
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:Alerttitle message:AlertMsg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        
        [alert show];
    }
    
  
}

- (void)initFavModel{
    
    _collectModel = [[CollectionModel alloc] init];
    
    _collectModel.ids = self.ids;
    _collectModel.TypeName = self.typeName;
    _collectModel.userName = _userName;

}

- (void)judgeFav{
    
    _isSaved = [[CollectionManager shareManager] findModel:_collectModel];
    
    _favBtn.selected = _isSaved ? YES : NO;
}

#pragma mark - 加载栏
- (void)HUDStart{
    _HUD=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    _HUD.labelText=@"加载中";
    _HUD.labelColor=[UIColor whiteColor];
    _HUD.color=[UIColor grayColor];
    //    _HUD.dimBackground=YES;
}

- (void)HUDEnd{
    
    [_HUD hide:YES afterDelay:1];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.toolbarHidden = YES;
    self.hidesBottomBarWhenPushed = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
