//
//  NewsRootViewController.m
//  HealthDrips
//
//  Created by Cedric.
//  Copyright © 2015年 UpTeam. All rights reserved.
//

#import "NewsRootViewController.h"
#import "HealthDrips.pch"

#import "NewsGeneralModel.h"

#import "InfoCell.h"
#import "LoreCell.h"
#import "BookCell.h"

#import "ShowDetailViewController.h"
#import "NewsDetailViewController.h"

@interface NewsRootViewController ()<UITableViewDataSource , UITableViewDelegate , LoreCellDelegate , BookCellDelegate>{
    
    NSMutableArray * _arrayDS;
    NSMutableArray * _arrayMD;  //模型数组
    NSMutableDictionary * _maxIds;  //本地最新的id
    MBProgressHUD * _HUD;
    NSInteger _page;
    BOOL _isUp;
}

@property (nonatomic , strong) UITableView * tableView;

@end

@implementation NewsRootViewController

#pragma mark - 生命周期

- (void)viewWillAppear:(BOOL)animated{

    [self parentViewController].hidesBottomBarWhenPushed = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - 初始化

- (void)initData{

    _arrayDS = [[NSMutableArray alloc] init];
    _arrayMD = [[NSMutableArray alloc] init];
    
    _page = 1;
    _isUp = NO;
    
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    
    if (![userDefault objectForKey:@"maxIds"]) {
        
        _maxIds = [[NSMutableDictionary alloc] init];
    }else{
    
        _maxIds = [[NSMutableDictionary alloc] initWithDictionary:[userDefault objectForKey:@"maxIds"]];
    }
}

- (void)initUI{
    

    self.parentViewController.navigationItem.hidesBackButton = YES;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
    switch (self.requestType) {
        case Enum_InfoPage:
             [_tableView registerNib:[UINib nibWithNibName:@"InfoCell" bundle:nil]forCellReuseIdentifier:@"infocell"];
            [self addTableRefresh];
            break;
        case Enum_LorePage:
            _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [_tableView registerNib:[UINib nibWithNibName:@"LoreCell" bundle:nil]forCellReuseIdentifier:@"lorecell"];
            break;
        case Enum_BookPage:
            _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
            [_tableView registerNib:[UINib nibWithNibName:@"BookCell" bundle:nil] forCellReuseIdentifier:@"bookcell"];
            break;
        case Enum_DetailPage:
            [_tableView registerNib:[UINib nibWithNibName:@"InfoCell" bundle:nil]forCellReuseIdentifier:@"infocell"];
            [self addTableRefresh];
            break;
        default:
            break;
    }
    
    
}

- (void)addTableRefresh{
    
    //添加头部刷新
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        _isUp = NO;
        _page = 1;
        
        //请求数据
        [self downLoadData];
    }];
    _tableView.header = header;
    
    [self.tableView.header beginRefreshing];
    
    //添加尾部刷新
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        _isUp = YES;
        _page++;
        
        //请求数据
        [self downLoadData];
    }];
    _tableView.footer = footer;
}

#pragma mark - UItableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _arrayDS.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    //边距高度
    float distance = 36;
    //图片的宽度
    float imgViewW = (SCREEN_WIDTH-22-12)/2;
    //图片的高度
    float imgViewH = imgViewW * 0.618;
    float textViewH = 56;
    
    switch (self.requestType) {
        case Enum_InfoPage:
            return 100;
            break;
        case Enum_LorePage:
            return distance + (imgViewH + textViewH) * 2;
            break;
        case Enum_BookPage:
            return 220;
            break;
        case Enum_DetailPage:
            return 100;
            break;
        default:
            
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    InfoCell * infoCell;
    LoreCell * loreCell;
    BookCell * bookCell;
    
    switch (self.requestType) {
        case Enum_InfoPage:
            
            infoCell = [tableView dequeueReusableCellWithIdentifier:@"infocell"];
            [infoCell addModel:_arrayDS[indexPath.row]];
            infoCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return infoCell;
            break;
        case Enum_LorePage:
            
            loreCell = [tableView dequeueReusableCellWithIdentifier:@"lorecell"];
            loreCell.selectionStyle = UITableViewCellSelectionStyleNone;
            loreCell.delegate = self;
            [loreCell addModelArray:_arrayDS[indexPath.row]];
            return loreCell;
            break;
        case Enum_BookPage:
            
            bookCell = [tableView dequeueReusableCellWithIdentifier:@"bookcell"];
            [bookCell addModelArray:_arrayDS[indexPath.row]];
            bookCell.delegate = self;
            bookCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return bookCell;
            break;
        case Enum_DetailPage:
            
            infoCell = [tableView dequeueReusableCellWithIdentifier:@"infocell"];
            [infoCell addModel:_arrayDS[indexPath.row]];
            infoCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return infoCell;
            break;
        default:
            return nil;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    if (self.requestType == Enum_InfoPage) {
        
        ShowDetailViewController * showVc = [[ShowDetailViewController alloc] init];
        showVc.ids = [_arrayDS[indexPath.row] genID];
        showVc.typeName = ShowDetailNews;
        [self parentViewController].hidesBottomBarWhenPushed = YES;
        
        self.navigationItem.hidesBackButton = YES;
        [self.navigationController pushViewController:showVc animated:NO];
        [self parentViewController].hidesBottomBarWhenPushed = NO;
    }else if(self.requestType == Enum_LorePage){
    
        NewsDetailViewController * NDetailVc = [[NewsDetailViewController alloc] init];
        NDetailVc.isBook = NO;
        NDetailVc.loreId = [_arrayDS[indexPath.row][4] intValue]+1;
        [self.parentViewController.navigationController pushViewController:NDetailVc animated:NO];
    }else if (self.requestType == Enum_DetailPage){
    
        ShowDetailViewController * showVc = [[ShowDetailViewController alloc] init];
        showVc.ids = [_arrayDS[indexPath.row] genID];
        showVc.typeName = ShowDetailLore;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:showVc animated:NO];
        self.hidesBottomBarWhenPushed = NO;
    }else if (self.requestType == Enum_BookPage){
    
        NewsDetailViewController * NDetailVc = [[NewsDetailViewController alloc] init];
        NDetailVc.isBook = YES;
        NDetailVc.loreId = [_arrayDS[indexPath.row][6] intValue]+1;
        [self.parentViewController.navigationController pushViewController:NDetailVc animated:NO];
    }
}


#pragma mark - 下载数据

- (void)downLoadData{
    
    [self HUDStart];
    
    NSString * urlStr;
    NSString * key;
    NSString * baseStr;
    //本地最大的Id
    int maxId;
    int count;
    count = self.requestType == Enum_LorePage? 13:self.requestType == Enum_BookPage?10: 1;
    
    for (int i = 0; i < count; i++) {
    switch (self.requestType) {
            
//当前视图控制器是资讯控制器
        case Enum_InfoPage:
            urlStr = [NSString stringWithFormat:@"%@?page=%ld&rows=10",API_INFO_LIST,_page];
            break;
            

//当前视图控制器是知识控制器
        case Enum_LorePage:

            //从UserDafault中查找存储的类别的最大id
            key = [NSString stringWithFormat:@"Lore-%d",i];
            maxId = [[_maxIds allKeys] containsObject:key]?[_maxIds[key] intValue ]:1;
            maxId = arc4random()%maxId-4;
            urlStr = [NSString stringWithFormat:@"%@?id=%d&rows=4&classify=%d",API_LORE_NEWS,maxId,i+1];
            break;
          
//当前视图控制器是图书控制器
        case Enum_BookPage:
            
            //从UserDafault中查找存储的类别的最大id
            key = [NSString stringWithFormat:@"Book-%d",i];
            maxId = [[_maxIds allKeys] containsObject:key]?[_maxIds[key] intValue]:1;
            maxId =  arc4random()%(maxId-6);
            urlStr = [NSString stringWithFormat:@"%@?id=%d&rows=6",API_BOOK_LIST,i+1];
            break;
            
//当前视图控制器是详情列表控制器
        case Enum_DetailPage:
            baseStr = self.isBook?API_BOOK_LIST:API_LORE_LIST;      //判断是书籍列表还是知识列表
            urlStr = [NSString stringWithFormat:@"%@?page=%ld&rows=10&id=%ld",baseStr,_page,self.loreId];
            break;
        default:
            break;
    }
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self parseData:responseObject andClassfy:i];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error.description);
    }];
        
    }
}

#pragma mark 解析数据

- (void)parseData:(NSData *)responseObject andClassfy:(long)class{
    
    if (!responseObject) {
        
        return;
    }
    
    if (!_isUp&&(self.requestType == Enum_InfoPage||self.requestType == Enum_DetailPage)) {
        
        [_arrayDS removeAllObjects];
    }
    
    [_arrayMD removeAllObjects];
    
    NSDictionary * jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    
    NSArray * jsonArr = self.requestType == Enum_LorePage||self.requestType == Enum_BookPage?jsonDic[@"list"]:jsonDic[@"tngou"];
    
    if(jsonArr == NULL){
    
        return;
    }
    
    
    for (NSDictionary * dic in jsonArr) {
        
        NewsGeneralModel * model = [[NewsGeneralModel alloc] init];
        
        //通用属性<id，标题，图片，时间>
        model.genID = [NSString stringWithFormat:@"%@",dic[@"id"]];
        self.requestType != Enum_BookPage? model.title =dic[@"title"]:0;
        model.img = dic[@"img"];
        model.time = [NSString stringWithFormat:@"%@",dic[@"time"]];
        
        //非图书属性<所属类型>
        self.requestType == Enum_InfoPage ?model.infoclass = [NSString stringWithFormat:@"%@",dic[@"infoclass"]]:0;
        self.requestType == Enum_LorePage ?model.loreclass = [NSString stringWithFormat:@"%@",dic[@"loreclass"]]:0;
        
        //图书的属性
        self.requestType == Enum_BookPage||self.isBook?model.author = dic[@"author"]:0;
        self.requestType == Enum_BookPage||self.isBook?model.title = dic[@"name"]:0;
        
        //判断控制器，来决定装载数据的方式
        self.requestType == Enum_LorePage||self.requestType == Enum_BookPage?[_arrayMD addObject:model]:[_arrayDS addObject:model];
    }
    
    //添加数据类别
    self.requestType == Enum_LorePage||self.requestType == Enum_BookPage?[_arrayMD addObject:[NSString stringWithFormat:@"%ld",class]]:0;
    
    //添加最大的id
    [self saveMaxId:jsonDic Classify:class];
    
    //判断是不是Lore控制器，如果是，把Model数组添加到DS数组中
    self.requestType == Enum_LorePage||self.requestType == Enum_BookPage?[_arrayDS addObject:_arrayMD.copy]:0;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self HUDEnd];
        //停止动画
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
        
        [_tableView reloadData];

    });
    
}

#pragma mark - 跳转详情页

- (void)LorePush:(NewsGeneralModel *)model andIsBook:(NSInteger) isBook{
    ShowDetailViewController * showVc = [[ShowDetailViewController alloc] init];
    showVc.ids = model.genID;
    
    showVc.typeName = isBook?ShowDetailBook:ShowDetailLore;
    
    [self parentViewController].hidesBottomBarWhenPushed = YES;
    [[self parentViewController].navigationController pushViewController:showVc animated:NO];
    [self parentViewController].hidesBottomBarWhenPushed = NO;
}

- (void)getModel:(NewsGeneralModel *)model{

    [self LorePush:model andIsBook:0];
}

- (void)getBookModel:(NewsGeneralModel *)model{
    
    [self LorePush:model andIsBook:1];
    
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
    
    [_HUD hide:YES afterDelay:0.2];
}

#pragma mark - 存储最大的id
- (void)saveMaxId:(NSDictionary *)jsonDic Classify:(long)class{

    NSString * total = [NSString stringWithFormat:@"%@",jsonDic[@"total"]];
    
    if ([total isEqualToString:@"0"]) {
        return;
    }
    
    if (self.requestType == Enum_LorePage){
        
        [_maxIds setObject:total forKey:[NSString stringWithFormat:@"Lore-%ld",class]];
    }else if (self.requestType == Enum_BookPage){
        
        [_maxIds setObject:total forKey:[NSString stringWithFormat:@"Book-%ld",class]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:_maxIds forKey:@"maxIds"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
