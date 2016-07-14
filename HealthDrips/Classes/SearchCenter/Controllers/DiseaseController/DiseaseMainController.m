//
//  DiseaseMainController.m
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "DiseaseMainController.h"

#import "LoadClassifyManager.h"

#import "BigClassifyModel.h"
#import "LiteClassifyModel.h"

#import "DiseaseListViewController.h"

@interface DiseaseMainController ()<UITableViewDataSource , UITableViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _dataArr;
    DISEASE_CLASSIFY_FILTER _currentType;
    UIBarButtonItem * _switchFilter;
}
@end

@implementation DiseaseMainController

#pragma mark 通过filter读取数据
- (void)loadDataWithType:(DISEASE_CLASSIFY_FILTER)filter{
    
    [_dataArr removeAllObjects];
    
    NSArray * typeArr = @[HD_Classify_Department,HD_Classify_Place];
    
    [_dataArr setArray:[[LoadClassifyManager shareManager] getClassifyModelWithClassifyName:typeArr[filter]]];
    
    [_tableView reloadData];
}

#pragma mark - 创建UI
- (void)creatUI{
    
    //NavBar右上角
    _switchFilter = [[UIBarButtonItem alloc] initWithTitle:@"切换模式" style:UIBarButtonItemStyleDone target:self action:@selector(switchFilter)];
    self.navigationItem.rightBarButtonItem = _switchFilter;
    
    //tableView搭建
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CONTENT_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _tableView.sectionFooterHeight = 0;
    _tableView.backgroundColor = THEME_LIGHT_GRAY;
    
}

#pragma mark 切换分类模式
- (void)switchFilter{
    
    //切换
    if (_currentType==DISEASE_CLASSIFY_DEPARTMENT) {
        
        self.title = @"疾病(按部位)";
        _currentType=DISEASE_CLASSIFY_BODY;
    }else{
        
        self.title = @"疾病(按科室)";
        _currentType=DISEASE_CLASSIFY_DEPARTMENT;
    }
    
    //刷新数据
    [self loadDataWithType:_currentType];
}

#pragma mark - 协议方法
#pragma mark 分组个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArr.count;
}
#pragma mark 每组cell数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_dataArr[section] liteArr].count;
}
#pragma mark 返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text = [[_dataArr[indexPath.section] liteArr][indexPath.row] name];
    
    return cell;
}

#pragma mark 设置头尾视图
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    view.backgroundColor = THEME_LIGHT_GRAY;

    
    UILabel * label = [[UILabel alloc] initWithFrame:view.bounds];
    label.textColor = [UIColor blackColor];

    label.text = [_dataArr[section] name];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    return view;
}

#pragma mark 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
    
    self.hidesBottomBarWhenPushed = YES;
    
    DiseaseListViewController * lVc = [[DiseaseListViewController alloc] init];
    lVc.title = [[_dataArr[indexPath.section] liteArr][indexPath.row] name];
    lVc.ids = [[_dataArr[indexPath.section] liteArr][indexPath.row] ids];
    lVc.type = _currentType;
    [self.navigationController pushViewController:lVc animated:YES];
    
    self.hidesBottomBarWhenPushed = YES;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"疾病(按科室)";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArr = [[NSMutableArray alloc] init];
    _currentType = DISEASE_CLASSIFY_DEPARTMENT;
    [self loadDataWithType:_currentType];
    
    [self creatUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
