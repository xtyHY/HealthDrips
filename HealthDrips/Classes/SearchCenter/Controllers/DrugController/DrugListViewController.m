//
//  DrugListViewController.m
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "DrugListViewController.h"

#import "DrugListModel.h"
#import "DrugListCell.h"
#import "ShowDetailViewController.h"


@interface DrugListViewController ()<UITableViewDataSource , UITableViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _dataArr;
    int _page;
    
    UIAlertView * _alertView;
    
    MBProgressHUD * _HUD;
}

@end

@implementation DrugListViewController

#pragma mark 初始化数据
- (void)downloadData{
    
    [self HUDStart];
    
    if(![NetTool shareTool].isReachable){
        
        _alertView.message = @"无网络访问,请检查网络";
        [self.navigationController popViewControllerAnimated:YES];
        [_alertView show];
        [self HUDEnd];
        return;
    }
    
    NSString * pageStr = [NSString stringWithFormat:@"%d",_page];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:API_DRUG_LIST parameters:@{@"id":self.classifyId,@"page":pageStr,@"rows":@10} success:^    (NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSArray * conArr = [dict objectForKey:@"tngou"];
        
        for (NSDictionary * dict in conArr) {
                
            [_dataArr addObject:[DrugListModel filleModelWithDict:dict]];
        }
        
        [self HUDEnd];
        
        //结束刷新
        [_tableView.footer endRefreshing];
        
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        _alertView.message = @"获取数据失败,请稍后再试";
        [_alertView show];
        [self HUDEnd];
        return;
    }];
}

#pragma mark 创建界面
- (void)creatUI{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CONTENT_HEIGHT) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        _page++;
        [self downloadData];
        [_tableView reloadData];
    }];
    
    [_tableView registerNib:[UINib nibWithNibName:@"DrugListCell" bundle:nil] forCellReuseIdentifier:@"listCell"];
    
    [self.view addSubview:_tableView];
}

#pragma mark cell数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

#pragma mark 显示cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DrugListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
    
    cell.model = _dataArr[indexPath.row];
    
    return cell;
}

#pragma mark cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

#pragma mark 点击cell事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
    
    //弹页面
    self.hidesBottomBarWhenPushed = YES;
    
    ShowDetailViewController * sdvc = [[ShowDetailViewController alloc] init];
    sdvc.title = @"药品详情";
    sdvc.typeName = ShowDetailDrug;
    sdvc.ids = [_dataArr[indexPath.row] ids];
    [self.navigationController pushViewController:sdvc animated:NO];

    self.hidesBottomBarWhenPushed = YES;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArr = [[NSMutableArray alloc] init];
    _page = 1;
    _alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [self creatUI];
    [self downloadData];
    
    NSLog(@"00");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [[SDImageCache sharedImageCache] clearMemory];
}

#pragma mark - 加载栏
- (void)HUDStart{
    
    _HUD=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    _HUD.labelText=@"加载中";
    _HUD.labelColor=[UIColor whiteColor];
    _HUD.color=[UIColor grayColor];
}

- (void)HUDEnd{
    
    [_HUD hide:YES afterDelay:1];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [[SDImageCache sharedImageCache] clearMemory];
}
@end
