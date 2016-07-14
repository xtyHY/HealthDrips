//
//  HospitalViewController.m
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "HospitalViewController.h"
#import "LiteClassifyModel.h"
#import "HospitalModel.h"
#import "HospitalTableViewCell.h"
#import "ShowDetailViewController.h"
#import "MBProgressHUD.h"
@interface HospitalViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    MBProgressHUD *_HUD;
    int _page;
    UIAlertView * _alertView;
}

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation HospitalViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataArray = [NSMutableArray array];
    _page = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"医院列表";
    _alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [self createUI];
    [self loadData];
    
}

- (void)loadData{
    
//    [_dataArray removeAllObjects];
    [self HUD];
    if(![NetTool shareTool].isReachable){
        
        NSLog(@"无网");
        
        _alertView.message = @"无网络访问,请检查网络";
        [_alertView show];
        [self HUDEnd];
        return;
    }
    
    NSString *path = [NSString stringWithFormat:@"%@?id=%@&page=%d",API_HOSPITAL_LIST,_ids,_page] ;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *array = dic[@"tngou"];

        for (NSDictionary *dict in array) {
            HospitalModel *model = [[HospitalModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            
            [_dataArray addObject:model];
        }
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
        [_tableView reloadData];
        [self HUDEnd];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        _alertView.message = @"获取数据失败,请稍后再试";
        [_alertView show];
        [self HUDEnd];
        return;
    }];
    
}

- (void)createUI{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"HospitalTableViewCell" bundle:nil] forCellReuseIdentifier:@"hospital"];
    
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downRefresh)];
    [_tableView.header beginRefreshing];//一进入页面就进行刷新
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upRefresh)];
}

- (void)downRefresh{
    
    [self loadData];
}

- (void)upRefresh{
    _page++;
    [self loadData];
}

-(void)HUD
{
    
    _HUD=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    _HUD.labelText=@"加载中...";
    _HUD.labelColor=[UIColor whiteColor];
    _HUD.color=[UIColor grayColor];
//    _HUD.dimBackground=YES;
}

- (void)HUDEnd{
    
    [_HUD hide:YES afterDelay:1];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HospitalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hospital" forIndexPath:indexPath];
    
    HospitalModel *model = self.dataArray[indexPath.row];
    [cell addHospitalModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];

    ShowDetailViewController * showVc = [[ShowDetailViewController alloc] init];
    showVc.title = @"医院详情";
    showVc.ids = [_dataArray[indexPath.row] idStr];
    showVc.typeName = ShowDetailHospital;

    showVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:showVc animated:YES];
    
    //返回上一层时影藏tabBar
    self.hidesBottomBarWhenPushed = YES;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
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
