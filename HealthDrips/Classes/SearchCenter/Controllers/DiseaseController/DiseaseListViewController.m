//
//  DiseaseListViewController.m
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "DiseaseListViewController.h"
#import "DiseaseListModel.h"
#import "DiseaseListCell.h"
#import "ShowDetailViewController.h"

@interface DiseaseListViewController ()
{
    int _page;
    NSMutableArray * _dataArr;
    UIAlertView * _alertView;
    MBProgressHUD * _HUD;
}

@end

@implementation DiseaseListViewController

- (void)downloadData{
    
    [self HUDStart];
    if(![NetTool shareTool].isReachable){
        
        [self.navigationController popViewControllerAnimated:YES];
        _alertView.message = @"无网络访问,请检查网络";
        [_alertView show];
        [self HUDEnd];
        return;
    }
    NSString * pageVal = [NSString stringWithFormat:@"%d",_page];
    
    NSString * path;
    if (self.type==DISEASE_CLASSIFY_BODY)
        path = API_DISEASE_PLACE;
    else
        path = API_DISEASE_DEPART;
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:@{@"id":self.ids, @"page":pageVal, @"rows":@10} success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray * array = [[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"list"];
        
        for (NSDictionary * dict in array) {
            
            [_dataArr addObject:[DiseaseListModel fillModelWithDict:dict]];
        }
        
        [self.tableView reloadData];
        [self.tableView.footer endEditing:YES];
        
        [self HUDEnd];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        _alertView.message = @"获取数据失败,请稍后再试";
        [_alertView show];
        [self HUDEnd];
        return;
    }];
}

- (void)creatUI{
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DiseaseListCell" bundle:nil] forCellReuseIdentifier:@"diseaseListCell"];
    
    //去除线
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        _page++;
        [self downloadData];
    }];
}

#pragma mark cell数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

#pragma mark cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DiseaseListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"diseaseListCell"];
    
    cell.model = _dataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark 设置cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //先获取文字在固定宽高下的高度，然后加上一些固定控件的高度即可计算动态cell高度
    CGRect messageRect = [[_dataArr[indexPath.row] descript] boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16], NSFontAttributeName, nil] context:nil];
    
    //45是固定的一些控件的高度(上面的标题和间距)
    return 80+messageRect.size.height;
}

#pragma mark 选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //获取到indePath的cell然后让他点击后的选中取消
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
    
    self.hidesBottomBarWhenPushed = YES;
    
    ShowDetailViewController * showVc = [[ShowDetailViewController alloc] init];
    showVc.title = @"疾病详情";
    showVc.ids = [_dataArr[indexPath.row] ids];
    showVc.typeName = ShowDetailDisease;
    
    [self.navigationController pushViewController:showVc animated:NO];
    
    self.hidesBottomBarWhenPushed = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArr = [[NSMutableArray alloc] init];
    _page = 1;
    _alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [self downloadData];
    
    [self creatUI];
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
    //    _HUD.dimBackground=YES;
}

- (void)HUDEnd{
    
    [_HUD hide:YES afterDelay:1];
}



@end
