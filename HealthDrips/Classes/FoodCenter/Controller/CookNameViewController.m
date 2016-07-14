//
//  CookNameViewController.m
//  HealthDrips
//
//  Created by Arom.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "CookNameViewController.h"
#import "AFNetworking.h"
#import "dataDownload.h"
#import "CookNameModel.h"
#import "cookNameCell.h"
#import "SearchViewController.h"
#import "SDImageCache.h"
#import "MBProgressHUD.h"
#import "ShowDetailViewController.h"
#import "ShowDetailModel.h"

@interface CookNameViewController ()<UITableViewDelegate,UITableViewDataSource>
{

    NSMutableArray * _dataArray;
    UITableView * _tableView;
    UIAlertView * _alertView;
    
    MBProgressHUD * _HUD;
    
    
    
}
@end

@implementation CookNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _dataArray = [[NSMutableArray alloc] init];
    [self creatUI];
    [self downloadData];
    [self creatNavBar];
    _alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    //self.view.backgroundColor = [UIColor redColor];
}

- (void)downloadData{
    
//    NSArray * array = [[dataDownload ShareManager] DownloadWithUrl:API_COOK_NAME andWithName:_name];

    [self HUDStart];
    
    if(![NetTool shareTool].isReachable){
        
        _alertView.message = @"无网络访问,请检查网络";
        [self.navigationController popViewControllerAnimated:YES];
        [_alertView show];
        [self HUDEnd];
        return;
    }
    
    NSString * path = [NSString stringWithFormat:@"%@?name=%@",API_COOK_NAME,_name];
    
     path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
       
        NSArray * array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        for (NSDictionary * dict in array) {
            
            CookNameModel * model = [[CookNameModel alloc] initwithDict:dict];
            
            [_dataArray addObject:model];
        }
        [self HUDEnd];
    [_tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.description);
        _alertView.message = @"获取数据失败,请稍后再试";
        [_alertView show];
        [self HUDEnd];
        return;
    }];
    
}

- (void)creatUI{

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CONTENT_HEIGHT_TAB_BAR) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"cookNameCell" bundle:nil] forCellReuseIdentifier:@"isEnable"];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 104;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    cookNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"isEnable"];
    
    CookNameModel * model = [_dataArray objectAtIndex:indexPath.row];
    [cell fillWithModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [_tableView deselectRowAtIndexPath:_tableView.indexPathForSelectedRow animated:YES];
    
    ShowDetailViewController * detaiShow = [[ShowDetailViewController alloc] init];
    
    CookNameModel * model = [_dataArray objectAtIndex:indexPath.row];
    
    detaiShow.ids = model.ids;
    detaiShow.title = model.name;
    detaiShow.typeName = ShowDetailCook;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detaiShow animated:NO];
    self.hidesBottomBarWhenPushed = NO;
    
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

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    [[SDImageCache sharedImageCache] clearMemory];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
