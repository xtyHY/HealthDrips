//
//  FoodCenterViewController.m
//  HealthDrips
//
//  Created by Arom.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "FoodCenterViewController.h"
#import "dataDownload.h"
#import "ApisMacros.h"
#import "MBProgressHUD.h"
#import "SDImageCache.h"

#import "BigClassifyModel.h"
#import "LiteClassifyModel.h"
#import "LoadClassifyManager.h"

#import "CookClassifyModel.h"
#import "CookListNameModel.h"

#import "listNameCollectionViewCell.h"

#import "CookNameViewController.h"
#import "SearchViewController.h"
#import "ShowDetailViewController.h"


@interface FoodCenterViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    
    UIView * _cookView; //!<菜谱视图
    
    UITableView * _classfyTableView;       //!<分类导航条
    
    UICollectionView * _listCollectionView;//!<小分类视图
    
    NSMutableArray * _classifyDataArray1;//!<分类视图数据源数组
    
    NSMutableArray * _listDataArray1;    //!<小分类视图数据源数组

    NSMutableArray * _sectionStateArray; //!< 存储分组状态的数组
    
    int _state;
    
    MBProgressHUD * _HUD; //!<加载状态控件
    
    NSInteger _tag;   //!<判断分类的id
    
    UIAlertView * _alertView;
    UIView * headView;
}

@end

@implementation FoodCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tag = 0;
    _state=1;
    //数据源数组初始化
    _classifyDataArray1 = [[NSMutableArray alloc] init];
    _sectionStateArray = [[NSMutableArray alloc] init];
    _listDataArray1 = [[NSMutableArray alloc] init];
    
    [self downloadData];
    [self creatCookView];
    [self creatUI];
    
    [self creatNavBar];
    
    _classfyTableView.showsVerticalScrollIndicator = NO;
    _listCollectionView.showsVerticalScrollIndicator = NO;
     _alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [self HUDStart];
    
    if(![NetTool shareTool].isReachable){
        
        _alertView.message = @"无网络访问,请检查网络";
        [self.navigationController popViewControllerAnimated:YES];
        [_alertView show];
        [self HUDEnd];
        return;
    }
}


#pragma mark =====导航条数据下载=====
- (void)downloadData{

    NSArray * array = [[LoadClassifyManager shareManager] getClassifyModelWithClassifyName:HD_Classify_Food];
    
    for (BigClassifyModel * bigClassifyModel in array) {
        
//        NSString * bigName = bigClassifyModel.name;
//        
//        //NSLog(@"==%@",bigName);
//        
//        for (LiteClassifyModel * liteClassifyModel in bigClassifyModel.liteArr) {
//            
//            NSString * liteName = liteClassifyModel.name;
//            NSString * ids = liteClassifyModel.ids;
//            //NSLog(@"====%@ %@",liteName,ids);
//        }
        if (bigClassifyModel.liteArr.count != 0) {
            [_classifyDataArray1 addObject:bigClassifyModel];
        }else{
        
            continue;
        }
        
        [_sectionStateArray addObject:@NO];
    }
    [_classfyTableView reloadData];
    
   
}

#pragma mark =====主界面搭建=====
- (void)creatUI{
    
    //设置navigationitem 的titleView
    UISegmentedControl * segment = [[UISegmentedControl alloc] initWithItems:@[@"食品",@"菜谱"]];
    //segment.backgroundColor = [UIColor whiteColor];
    segment.layer.frame = CGRectMake(0, 0, 150, 30);
    segment.tintColor = [UIColor whiteColor];
    segment.layer.masksToBounds = YES;
    segment.layer.cornerRadius = 10;
    segment.layer.borderWidth = 1;
    segment.tag = 10;
    segment.layer.borderColor = [UIColor whiteColor].CGColor;
    [segment addTarget:self action:@selector(changValues:) forControlEvents:UIControlEventValueChanged];
    
    segment.selectedSegmentIndex = 0;
    self.navigationItem.titleView = segment;
    
    //创建tableView
    _classfyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, CONTENT_HEIGHT_TAB_BAR) style:(UITableViewStylePlain)];
    
    _classfyTableView.delegate = self;
    
    _classfyTableView.dataSource = self;
    
    
    [self.view addSubview: _classfyTableView];
    
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    _classfyTableView.sectionFooterHeight = 0;
    
    [self downloadCollectionViewData:@"2"];
    
    [self creatListUI];
    
    //设置导航栏左右视图位子颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

#pragma mark 创建导航条按钮
- (void)creatNavBar{

    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clickSearch)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)clickSearch{
    
    SearchViewController * searchVc = [[SearchViewController alloc] init];
    
    [self.navigationController pushViewController:searchVc animated:NO];
    
}


#pragma mark segment值改变
- (void)changValues:(UISegmentedControl *)segment{
    [_listDataArray1 removeAllObjects];
    [_classifyDataArray1 removeAllObjects];
    [_sectionStateArray removeAllObjects];
    if (segment.selectedSegmentIndex == 0) {
        //显示的是食品界面
        _state=1;
        NSArray * array = [[LoadClassifyManager shareManager] getClassifyModelWithClassifyName:HD_Classify_Food];
        
        for (BigClassifyModel * bigClassifyModel in array) {

            [_classifyDataArray1 addObject:bigClassifyModel];
            
            [_sectionStateArray addObject:@NO];
            
            [[dataDownload ShareManager] DownloadWithUrl:API_FOOD_LIST andWithId:2];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadSuccess:) name:@"success" object:nil];
        }
        
        _cookView.hidden = YES;
        
    }else if(segment.selectedSegmentIndex == 1){
        _state = 2;
        NSArray * array = [[LoadClassifyManager shareManager] getClassifyModelWithClassifyName:HD_Classify_Cook];
        for (BigClassifyModel * bigClassifyModel in array) {
            
            if (bigClassifyModel.liteArr.count !=0) {
                
                [_classifyDataArray1 addObject:bigClassifyModel];
            }else{
                
                continue;
            }
            [_sectionStateArray addObject:@NO];
            
            [[dataDownload ShareManager] DownloadWithUrl:API_COOK_LIST andWithId:2];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadSuccess:) name:@"success" object:nil];
        }
        _cookView.hidden = NO;
    }
    [_classfyTableView reloadData];
    [_listCollectionView reloadData];
}


#pragma mark ======tableView协议方法=====
#pragma mark 组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _classifyDataArray1.count;
}

#pragma mark 每组的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    if (![_sectionStateArray[section] boolValue]) {
        return 0;
    }else{
    
        NSArray * array = [_classifyDataArray1[section] liteArr];
        return array.count;
    }
    
}

#pragma _classifyTableViewcell的刷新
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"isEnable"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"isEnable"];
        
    }
    
    BigClassifyModel * bigModel = [_classifyDataArray1 objectAtIndex:indexPath.section];
    LiteClassifyModel * liteModel = bigModel.liteArr[indexPath.row];
    cell.textLabel.text =liteModel.name;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.textColor = RGB(100, 100,100);
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

#pragma mark 设置分组的头视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    
    return 50;
}
/**
 设置脚视图高度，但是没用，需要在创建界面时就为0
 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44;
    
}

#pragma mark 设置头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    headView = [[UIView alloc] init];
    headView.layer.masksToBounds = YES;
    headView.layer.borderWidth = 1;
    headView.layer.borderColor = RGBA(231, 231, 231, 1).CGColor;
    headView.backgroundColor = [UIColor whiteColor];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 70, 50)];
    label.text = [_classifyDataArray1[section] name];
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:label];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
//    [button setBackgroundColor:[UIColor orangeColor]];
//    [button addTarget:self action:@selector(preClick:) forControlEvents:(UIControlEventTouchDown)];
    [button addTarget:self action:@selector(onClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    button.tag = section+100;
    [headView addSubview:button];
    
    if ([[_sectionStateArray objectAtIndex:section]  isEqual: @YES]) {
        headView.backgroundColor = RGB(239, 239, 239);
    }else{
    
        headView.backgroundColor = [UIColor whiteColor];
    }
    return headView;
}



#pragma mark 点击按钮打开以及收回菜单
- (void)onClicked:(UIButton *)btn{
    
    if (btn.tag != _tag+100 ) {
        
        [_sectionStateArray replaceObjectAtIndex:_tag withObject:@NO];
        
        [_classfyTableView reloadSections:[NSIndexSet indexSetWithIndex:_tag] withRowAnimation:UITableViewRowAnimationAutomatic];
        _tag = btn.tag-100;
    }
    
        if ([_sectionStateArray[btn.tag-100] boolValue] == YES ) {
            
            [_sectionStateArray replaceObjectAtIndex:btn.tag-100 withObject:@NO];
            
            //NSLog(@"%ld------guan",btn.tag);
        }else {
            
            [_sectionStateArray replaceObjectAtIndex:btn.tag-100 withObject:@YES];
            
            _tag = btn.tag-100;
            
           // NSLog(@"------kai");
        }
        
        [_classfyTableView reloadSections:[NSIndexSet indexSetWithIndex:btn.tag-100] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
  // tableView.contentOffset = CGPointMake(0, [indexPath row] * [self tableView:tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]);
}

#pragma mark 创建菜谱界面
- (void)creatCookView{

    _cookView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    //[_cookView addSubview:_classfyTableView];
    [self.view addSubview:_cookView];
    _cookView.hidden = YES;
    
}

#pragma mark 点击classifyTableViewcell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    //[[[tableView subviews] objectAtIndex:indexPath] selectRowAtIndexPath:indexPath animated:YES scrollPosition:(UITableViewScrollPositionTop)];
     [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
     //tableView.contentOffset = CGPointMake(0, [indexPath row] * [self tableView:tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]);
    BigClassifyModel * bigModel = [_classifyDataArray1 objectAtIndex:indexPath.section];
    LiteClassifyModel * liteModel = bigModel.liteArr[indexPath.row];
    NSString * ID = liteModel.ids;
    [self.view bringSubviewToFront:_classfyTableView];
    
    [self HUDStart];
    [self downloadCollectionViewData:ID];
    
    if (arc4random()%2 == 0) {
        [[SDImageCache sharedImageCache] clearMemory];
        
    }
    
}

#pragma mark 下载collection数据
-(void)downloadCollectionViewData:(NSString *)ID{
    NSInteger ids = [ID integerValue];
    if (_state == 1) {
        [[dataDownload ShareManager] DownloadWithUrl:API_FOOD_LIST andWithId:ids];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadSuccess:) name:@"success" object:nil];
//        NSLog(@"88888");
    }else if (_state == 2){
    
        [[dataDownload ShareManager] DownloadWithUrl:API_COOK_LIST andWithId:ids];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadSuccess:) name:@"success" object:nil];
//        NSLog(@"99999");
        
    }
}

#pragma 接收消息，下载成功
- (void)downloadSuccess:(NSNotification *)notif{

    [_listDataArray1 removeAllObjects];
    NSArray * array = notif.object;
    NSDictionary * dict = [array lastObject];
    NSArray * array2 = [dict objectForKey:@"tngou"];
    
    for (NSDictionary *dict2 in array2) {
        
        CookListNameModel * listNameModel = [[CookListNameModel alloc] initwithDict:dict2];
       
        [_listDataArray1 addObject:listNameModel];
    }
    [self HUDEnd];
    [_listCollectionView reloadData];
}

#pragma  mark 创建Collection界面
- (void)creatListUI{

    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    
    _listCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(100, 0, SCREEN_WIDTH-100, CONTENT_HEIGHT_TAB_BAR) collectionViewLayout:layout];
    
    _listCollectionView.delegate = self;
    _listCollectionView.dataSource = self;
    _listCollectionView.backgroundColor = THEME_LIGHT_GRAY;
    [self.view addSubview:_listCollectionView];
    
    [_listCollectionView registerNib:[UINib nibWithNibName:@"listNameCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"isEnable"];
    
}

#pragma mark 设置cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return _listDataArray1.count;
}

- (UICollectionViewCell * )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    listNameCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"isEnable" forIndexPath:indexPath];
    
    CookListNameModel * model = [_listDataArray1 objectAtIndex:indexPath.row];
    [cell fillWithmodel:model];
    
    cell.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.2];
    
    
    return cell;
}

#pragma mark 设置collection间的距离
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    float width = (([UIScreen mainScreen].bounds.size.width-100) - 3*5)/2.0f;
    return CGSizeMake(width, width);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5;
}

#pragma mark 设置每个cell边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    float margin = 5;
    
    return UIEdgeInsetsMake(margin,margin,margin,margin);
}

#pragma mark 点击了collectionCell跳转下层界面
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
  //  [collectionView deselectRowAtIndexPath:indexPath animated:NO];
    if (_state == 1) {
        ShowDetailViewController * FoodShowVc = [[ShowDetailViewController alloc] init];
        CookListNameModel * model = [_listDataArray1 objectAtIndex:indexPath.row];
        FoodShowVc.ids = model.ids;
        FoodShowVc.title = model.name;
        FoodShowVc.typeName = ShowDetailFood;
       // NSLog(@"%@",FoodShowVc.ids);
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:FoodShowVc animated:NO];
        self.hidesBottomBarWhenPushed = NO;
    }else if(_state == 2){
        ShowDetailViewController * FoodShowVc = [[ShowDetailViewController alloc] init];
        CookListNameModel * model = [_listDataArray1 objectAtIndex:indexPath.row];
        FoodShowVc.ids = model.ids;
        FoodShowVc.title = model.name;
        FoodShowVc.typeName = ShowDetailFood;
        // NSLog(@"%@",FoodShowVc.ids);
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:FoodShowVc animated:NO];
        self.hidesBottomBarWhenPushed = NO;

    }
}

#pragma mark MBProgress加载
- (void)HUDStart{
    
    _HUD=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    _HUD.labelText=@"加载中";
    _HUD.labelColor=[UIColor whiteColor];
    _HUD.color=[UIColor grayColor];
}

- (void)HUDEnd{
    
    [_HUD hide:YES afterDelay:1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] clearMemory];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:animated];
    [[SDImageCache sharedImageCache] clearMemory];
}

//设置分割线从顶端开始 适配ios7和ios8
- (void)viewDidLayoutSubviews{
    
    if ([_classfyTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_classfyTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([_classfyTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_classfyTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
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