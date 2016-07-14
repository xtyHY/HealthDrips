//
//  HospitalMainController.m
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "HospitalMainController.h"
#import "HospitalModel.h"
#import "HospitalTableViewCell.h"
#import "HospitalCityViewController.h"
#import "MBProgressHUD.h"
#import "ShowDetailViewController.h"
#import <MAMapKit/MAMapKit.h>
@interface HospitalMainController ()<UITableViewDataSource,UITableViewDelegate,MAMapViewDelegate,CLLocationManagerDelegate>{
    
    MAMapView *_mapView;
    MBProgressHUD *_HUD;
    UIAlertView * _alertView;
}

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation HospitalMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = [NSMutableArray array];
    _alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];

    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated{
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        _alertView.message = @"定位已关闭,请在[隐私]-[定位]中开启";
        [_alertView show];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    _mapView = [[MAMapView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //开启定位
    _mapView.showsUserLocation = YES;
    //实时更新用户的位置
    //_mapView.userTrackingMode = MAUserTrackingModeNone;
    _mapView.delegate = self;

    [self HUD];
    
    if(![NetTool shareTool].isReachable){
        
        [self.navigationController popToRootViewControllerAnimated:NO];
        _alertView.message = @"无网络访问,请检查网络";
        [_alertView show];
        [self HUDEnd];
    }
}

//定位的回调方法
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    
    [_dataArray removeAllObjects];
    
    [self HUD];
    if(![NetTool shareTool].isReachable){
        
        _alertView.message = @"无网络访问,请检查网络";
        [_alertView show];
        [self HUDEnd];
        return;
    }
    
//  实时打印 纬度:22.281976  经度:114.163166
//    NSLog(@"维度:%f  经度:%f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    
    NSString *path = [NSString stringWithFormat:@"%@?x=%f&y=%f",API_HOSPITAL_LOCATION,userLocation.coordinate.longitude,userLocation.coordinate.latitude] ;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = dic[@"tngou"];
        for (NSDictionary *dict in array) {
            HospitalModel *model = [[HospitalModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [_dataArray addObject:model];
            // NSLog(@"%@",_dataArray);
        }
        [_tableView reloadData];
        [self HUDEnd];
       
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        _alertView.message = @"获取数据失败,请稍后再试";
        [_alertView show];
        [self HUDEnd];
        return;
    }];

    _mapView.showsUserLocation = NO;
}

- (void)createUI{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, CONTENT_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"HospitalTableViewCell" bundle:nil] forCellReuseIdentifier:@"hospital"];
    
    UIButton *cityButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cityButton.frame = CGRectMake(0, 0, 40, 40);
    [cityButton setTitle:@"城市" forState:UIControlStateNormal];
    [cityButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:cityButton];
    self.navigationItem.rightBarButtonItem = rightButton;
    
}

-(void)HUD
{
    
    _HUD=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    _HUD.labelText=@"定位搜索中";
    _HUD.labelColor=[UIColor whiteColor];
    _HUD.color=[UIColor grayColor];
//    _HUD.dimBackground=YES;
    [_HUD hide:YES afterDelay:1];
}

- (void)HUDEnd{
    
    [_HUD hide:YES afterDelay:1];
}


- (void)buttonClick{
    
    HospitalCityViewController *hospitalCityVC = [[HospitalCityViewController alloc]init];
    hospitalCityVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:hospitalCityVC animated:YES];
    
    //返回上一层时影藏tabBar
    self.hidesBottomBarWhenPushed = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HospitalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hospital" forIndexPath:indexPath];
    
    HospitalModel *model = _dataArray[indexPath.row];
    [cell addHospitalModel:model];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ShowDetailViewController * showVc = [[ShowDetailViewController alloc] init];
    showVc.title = @"医院详情";
    showVc.ids = [_dataArray[indexPath.row] idStr];
    showVc.typeName = ShowDetailHospital;
    
    showVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:showVc animated:YES];
    
    //返回上一层时影藏tabBar
    self.hidesBottomBarWhenPushed = YES;
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
