//
//  SearchResultViewController.m
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "SearchResultViewController.h"
#import "SearchResultCell.h"
#import "SearchResultModel.h"
#import "ShowDetailViewController.h"

@interface SearchResultViewController ()
{
    NSMutableArray * _dataArray;
    MBProgressHUD * _HUD;
    UIAlertView *_alertView;
}
@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [[NSMutableArray alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchResultCell" bundle:nil] forCellReuseIdentifier:@"SearchResultCell"];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    _alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [self downloadData];
}

- (void)downloadData{
    
    [self HUDStart];
    
    if(![NetTool shareTool].isReachable){
        
        _alertView.message = @"无网络访问,请检查网络";
        [_alertView show];
        [self HUDEnd];
        return;
    }
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:API_Search parameters:@{@"keyword":self.keyword, @"name":self.typeIdentify,@"rows":@10 } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        for (NSDictionary * detailDict in dict[@"tngou"]) {
            
            [_dataArray addObject:[SearchResultModel fillModelWithDict:detailDict]];
        }
        
        [self.tableView reloadData];
        
        [self HUDEnd];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        _alertView.message = @"获取数据失败,请稍后再试";
        [_alertView show];
        [self HUDEnd];
        return;
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultCell" forIndexPath:indexPath];
    
    cell.model = _dataArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    ShowDetailViewController * sdvc = [[ShowDetailViewController alloc] init];
    
    sdvc.ids = [_dataArray[indexPath.row] ids];
    
    if([self.typeIdentify isEqualToString:@"hospital"])
        sdvc.typeName = ShowDetailHospital;
    else if ([self.typeIdentify isEqualToString:@"drug"])
        sdvc.typeName = ShowDetailDrug;
    else if ([self.typeIdentify isEqualToString:@"disease"])
        sdvc.typeName = ShowDetailDisease;
    else if ([self.typeIdentify isEqualToString:@"food"])
        sdvc.typeName = ShowDetailFood;
    else
        sdvc.typeName = ShowDetailCook;
    
    [self.navigationController pushViewController:sdvc animated:NO];
    
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

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    [[SDImageCache sharedImageCache] clearMemory];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] clearMemory];
}

@end
