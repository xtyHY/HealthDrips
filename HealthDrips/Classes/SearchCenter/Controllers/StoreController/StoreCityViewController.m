//
//  StoreCityViewController.m
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "StoreCityViewController.h"
#import "StoreViewController.h"
#import "BigClassifyModel.h"
#import "LiteClassifyModel.h"
@interface StoreCityViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *cityArray;

@end

@implementation StoreCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"城市列表";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}

//懒加载
- (NSArray *)cityArray{
    if (_cityArray == nil) {
        //取路径
        NSString *path = [[NSBundle mainBundle]pathForResource:@"Area.plist" ofType:nil];
        //解plist文件
        NSArray *rootArray = [NSArray arrayWithContentsOfFile:path];
        
        //将rootArray里面的所有字典转成模型对象,放到新的数组中
        NSMutableArray *groupArray = [NSMutableArray array];
        for (NSDictionary *dict in rootArray) {
            BigClassifyModel *pModel = [BigClassifyModel fillModelWithDict:dict];
            
            [groupArray addObject:pModel];
        }
        _cityArray = groupArray;
        
    }
    return _cityArray;
}


- (void)createUI{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.cityArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    BigClassifyModel *proModel = self.cityArray[section];
    return proModel.liteArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cityID = @"cityID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cityID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cityID];
    }
    //设置数据
    BigClassifyModel *pModel = self.cityArray[indexPath.section];
    LiteClassifyModel *cModel = pModel.liteArr[indexPath.row];
    
    cell.textLabel.text = cModel.name;
    return cell;
}
//段头文字
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    
    BigClassifyModel *pModel = self.cityArray[section];
    return pModel.name;
    //    return _tableHeadTitleArr[section];
}

/**
 *  返回右边索引条显示的字符串数据
 */
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    //索引的背景颜色
//    //    _tableView.sectionIndexBackgroundColor = [UIColor lightGrayColor];
//    return [self.cityArray valueForKeyPath:@"name"];
//    //    return  _tableHeadTitleArr;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    StoreViewController *storeVC = [[StoreViewController alloc]init];
    
    BigClassifyModel *pModel = self.cityArray[indexPath.section];
    LiteClassifyModel *cModel = pModel.liteArr[indexPath.row];
    storeVC.name = cModel.name;
    storeVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:storeVC animated:YES];
    
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
