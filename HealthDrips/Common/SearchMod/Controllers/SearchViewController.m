//
//  SearchViewController.m
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "SearchViewController.h"

#import "SearchTypeListModel.h"
#import "SearchTypeListViewCell.h"

#import "SearchResultViewController.h"

@interface SearchViewController ()<UISearchBarDelegate>
{
    UISearchBar * _searchBar;
    NSMutableArray * _dataArray;
    MBProgressHUD * _HUD;
    UIAlertView *_alertView;
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    _alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [self creatUI];
}

#pragma mark 创建UI
- (void)creatUI{
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];

    _searchBar.delegate = self;
    _searchBar.placeholder = @"药品/疾病/食物/菜谱/医院";
    
    self.navigationItem.titleView = _searchBar;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(backTop)];
    
    [_searchBar becomeFirstResponder];
    
    self.tableView.sectionFooterHeight = 0;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchTypeListViewCell" bundle:nil] forCellReuseIdentifier:@"SearchTypeList"];
}

#pragma mark 搜索事件
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
    
    [_dataArray removeAllObjects];
    [self.tableView reloadData];
    
    static int index;
    NSLog(@"%@",searchBar.text);
    index = 0;
    
    NSArray * typeNameArr = @[@"药品",@"疾病",@"医院",@"菜谱",@"食品"];
    NSArray * typeIdentArr = @[@"drug",@"disease",@"hospital",@"cook",@"food"];
    
//    NSBlockOperation * preop;
//    NSMutableArray * opArr = [[NSMutableArray alloc] init];
//    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
//    
//    int i = 0;
//    for (NSString * name in typeIdentArr) {
//        
//        NSLog(@"%@",name);
//        
//        NSBlockOperation * op = [NSBlockOperation blockOperationWithBlock:^{
//            NSLog(@"...");
//            NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?keyword=%@&name=%@&rows=%@",API_Search,searchBar.text,name,@"1"]]];
//            
//            if (data == nil) {
//                
//                
//                for (int i = 0; i <3; i++) {
//                    NSLog(@"%@...重新加载",name);
//                    data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?keyword=%@&name=%@&rows=%@",API_Search,searchBar.text,name,@"1"]]];
//                    if (data != nil) {
//                        break;
//                    }
//                }
//                if (data == nil) {
//                    NSLog(@"%@,下载失败",name);
//                }
//            }
//            
//            if(data != nil){
//            
//                NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//                
//                if ([[dict objectForKey:@"total"] integerValue]>0) {
//                    
//                    SearchTypeListModel * model = [[SearchTypeListModel alloc] init];
//                    model.typeName = typeNameArr[i];
//                    model.typeIdentify = name;
//                    model.total = [[dict objectForKey:@"total"] integerValue];
//                    
//                    NSLog(@"%d==%@",i,model);
//                    [_dataArray addObject:model];
//                    
//                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                        NSLog(@"bbibi");
//                        [self.tableView reloadData];
//                    }];
//                }
//            }
//        }];
//        
//        if (preop != nil) {
//            [op addDependency:preop];
//        }
//        preop = op;
//        
//        [opArr addObject:op];
//        i++;
//    }
//    
//    [queue addOperations:opArr waitUntilFinished:YES];
    
    [self HUDStart];
    
    
    if(![NetTool shareTool].isReachable){
        
        _alertView.message = @"无网络访问,请检查网络";
        [_alertView show];
        [self HUDEnd];
        return;
    }
    
    for (int i=0; i<typeIdentArr.count; i++) {
        
        
        NSDictionary * paraDict = @{@"keyword"  :   searchBar.text,
                                    @"name"     :   typeIdentArr[i],
                                    @"rows"     :   @"1"};
        
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager GET:API_Search parameters:paraDict success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            SearchTypeListModel * model = [[SearchTypeListModel alloc] init];
            
            model.typeName = typeNameArr[i];
            model.typeIdentify = paraDict[@"name"];
            model.total = [[dict objectForKey:@"total"] integerValue];
            
            NSLog(@"%@",task.response.URL);
            if (model.total>0) {
                
                [_dataArray addObject:model];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.tableView reloadData];
                });
            }

            NSLog(@"第%d次下载=%@",i,model);
            
            [self HUDEnd];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            _alertView.message = @"获取数据失败,请稍后再试";
            [_alertView show];
            [self HUDEnd];
            return;
        }];
    }
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    _searchBar.text = @"";
    [_dataArray removeAllObjects];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SearchTypeListViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SearchTypeList"];
    
    cell.model = _dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.hidesBottomBarWhenPushed = YES;
    
    SearchResultViewController * srvc = [[SearchResultViewController alloc] init];
    srvc.title = [NSString stringWithFormat:@"%@相关",[_dataArray[indexPath.row] typeName]];
    srvc.keyword = _searchBar.text;
    srvc.typeIdentify = [_dataArray[indexPath.row] typeIdentify];
    
    [self.navigationController pushViewController:srvc animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}

#pragma mark - 取消按钮方法
- (void)backTop{
    
    [self.navigationController popViewControllerAnimated:NO];
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
