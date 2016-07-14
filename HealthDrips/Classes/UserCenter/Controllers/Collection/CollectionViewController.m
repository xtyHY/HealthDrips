//
//  CollectionViewController.m
//  HealthDrips
//
//  Created by Arom.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionModel.h"
#import "CollectionCell.h"
#import "CollectionManager.h"
#import "ShowDetailViewController.h"

@interface CollectionViewController ()<UITableViewDataSource,UITableViewDelegate>{

    NSMutableArray * _dataArray;
    
    UITableView * _tableView;
    
}

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initArray];
    
    [self prepareData];
    
    [self initUI];
    
}

#pragma 初始化

- (void)initArray{

    _dataArray = [[NSMutableArray alloc] init];
}

#pragma mark 数据准备
- (void)prepareData{

    NSArray * array = [[CollectionManager shareManager] selectAll];
    
    if (array.count == 0) {
        
        [self.navigationController popViewControllerAnimated:YES];
        UIAlertView * alertVc = [[UIAlertView alloc] initWithTitle:@"您还没有收藏任何文章！" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertVc show];
        
    }else{
    
        for (CollectionModel * model in array) {
            
            
            [_dataArray addObject:model];
            
        }
        [_tableView reloadData];
    }
    
   
    
}

#pragma mark ui设计
- (void)initUI{

    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CONTENT_HEIGHT) style:(UITableViewStylePlain)];
    
    //没有数据的时候tableView的下划线消失
    _tableView.tableFooterView=[[UIView alloc]init];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"CollectionCell" bundle:nil] forCellReuseIdentifier:@"isEnable"];
}

#pragma mark 协议方法

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (_dataArray.count == 0) {
        return 0;
    }else{
    
        return _dataArray.count;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CollectionCell * cell = [tableView dequeueReusableCellWithIdentifier:@"isEnable"];
    
    CollectionModel * model = _dataArray[indexPath.row];
    
    [cell fillWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.hidesBottomBarWhenPushed = YES;
    ShowDetailViewController * detailVc = [[ShowDetailViewController alloc] init];
    
    CollectionModel * model = _dataArray[indexPath.row];
    
    detailVc.ids = model.ids;
    detailVc.typeName = model.TypeName;
    
    [self.navigationController pushViewController:detailVc animated:NO];
    self.hidesBottomBarWhenPushed = NO;
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
