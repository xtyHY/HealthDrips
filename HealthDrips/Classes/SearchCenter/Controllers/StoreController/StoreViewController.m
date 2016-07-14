//
//  StoreViewController.m
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "StoreViewController.h"
#import "StoreDetailModel.h"
#import "StoreMapViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>
@interface StoreViewController ()<UITableViewDataSource,UITableViewDelegate,AMapSearchDelegate>{
    
    AMapSearchAPI *_mapSearchAPI;
}

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"药店列表";

    [self createUI];
    
    if(![NetTool shareTool].isReachable){
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message: @"无网络访问,请检查网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        
        [self search];
    }
    
}

//提示搜索
-(void)search
{
    
    AMapPOIKeywordsSearchRequest *requst=[[AMapPOIKeywordsSearchRequest alloc]init];
    
    requst.city = self.name;
    
//    NSLog(@"%@",requst.city);
    
    requst.keywords = @"药店";
    
    requst.requireExtension = YES;
    
    [_mapSearchAPI AMapPOIKeywordsSearch:requst];
}


- (void)createUI{
    
    _mapSearchAPI=[[AMapSearchAPI alloc]init];
    _mapSearchAPI.delegate=self;
    
    _dataArray = [NSMutableArray array];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

//实现提示搜索的回调函数
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    
    for (AMapPOI *tip in response.pois) {
        
        StoreDetailModel *model = [[StoreDetailModel alloc]init];
        model.city = tip.name;
        model.location = tip.location;
        model.where = [NSString stringWithFormat:@"%@,%@,%@,%@",tip.province,tip.city,tip.district,tip.address];
        [self.dataArray addObject:model];
        
//         NSLog(@"%@",tip.name);
    }
    
    [_tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    StoreDetailModel *model = _dataArray[indexPath.row];
    cell.textLabel.text = model.city;
    cell.detailTextLabel.text = model.where;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    StoreMapViewController *storeMapVC = [[StoreMapViewController alloc]init];
    StoreDetailModel *model = _dataArray[indexPath.row];
    storeMapVC.location = model.location;
    storeMapVC.name = model.city;
    storeMapVC.where = model.where;
    storeMapVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:storeMapVC animated:YES];
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
