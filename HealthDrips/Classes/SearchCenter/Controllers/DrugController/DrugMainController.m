//
//  DrugMainController.m
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "DrugMainController.h"

#import "LoadClassifyManager.h"
#import "BigClassifyModel.h"
#import "LiteClassifyModel.h"

#import "DrugClassifyCell.h"
#import "DrugClassifyHeaderView.h"

#import "DrugListViewController.h"

@interface DrugMainController ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    UICollectionView * _collectionView;
    NSArray * _dataArr;
}
@end

@implementation DrugMainController

#pragma mark - 加载数据
- (void)loadData{
    
    _dataArr = [[NSArray alloc] initWithArray:[[LoadClassifyManager shareManager] getClassifyModelWithClassifyName:HD_Classify_Drug]];
}

#pragma mark - 创建界面
- (void)creatUI{
    
    //创建collectionView的布局对象
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((SCREEN_WIDTH-6)/2.0f, 40);
    layout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
    
    //初始化collectionView
    _collectionView = [[UICollectionView alloc] initWithFrame:SCREEN_RECT collectionViewLayout:layout];
    _collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, CONTENT_HEIGHT);
    _collectionView.backgroundColor = THEME_LIGHT_GRAY;
    [self.view addSubview:_collectionView];
    
    //设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    //注册复用cell
    [_collectionView registerClass:[DrugClassifyCell class] forCellWithReuseIdentifier:@"cell"];
    //注册头视图复用
    [_collectionView registerClass:[DrugClassifyHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"view"];
}

#pragma mark - 协议方法
#pragma mark 分组个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return _dataArr.count;
}
#pragma mark 行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [_dataArr[section] liteArr].count;
}
#pragma mark cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //获取复用cell,没有就自动创建
    DrugClassifyCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.model = [_dataArr[indexPath.section] liteArr][indexPath.row];
    
    return cell;
}
#pragma mark 复用头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    //headerview和fooderview不用自己去创建，直接复用
    DrugClassifyHeaderView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"view" forIndexPath:indexPath];
    view.backgroundColor = THEME_SECTION_HEARD;
    
    view.text = [_dataArr[indexPath.section] name];
    
    return view;
}

#pragma mark 设置header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_WIDTH, 40);
}

#pragma mark 设置最小边距(配合layout.sectionInset使用)
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}
#pragma mark 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //    NSLog(@"%ld %ld",indexPath.section,indexPath.row);
    
    self.hidesBottomBarWhenPushed = YES;
    
    LiteClassifyModel * model = [_dataArr[indexPath.section] liteArr][indexPath.row];
    
    DrugListViewController * listView = [[DrugListViewController alloc] init];
    listView.title = model.name;
    listView.classifyId = model.ids;
    
    [self.navigationController pushViewController:listView animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    [self creatUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
