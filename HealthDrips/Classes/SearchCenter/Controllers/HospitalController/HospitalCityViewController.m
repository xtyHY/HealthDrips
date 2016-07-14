//
//  HospitalCityViewController.m
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "HospitalCityViewController.h"
#import "HospitalViewController.h"
#import "BigClassifyModel.h"
#import "LiteClassifyModel.h"
//#import "PinYinForObjc.h"
@interface HospitalCityViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *cityArray;

//@property (nonatomic,strong) NSMutableArray *tableHeadTitleArr;

@end

@implementation HospitalCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"城市列表";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    
    //将Model中的名字转换为拼音
//    [self nameToPinYin];
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

/*
#pragma mark 名字转拼音
- (void)nameToPinYin{
    //创建一个元素个数为26的数组 分别进行存储以A~Z开头的省份
    NSMutableArray * proArray = [[NSMutableArray alloc]init];
    
    for (int i = 'a'; i <= 'z'; i++) {
        //创建小数组 小数组分别存储统一拼音开头的省份
        NSMutableArray * array = [NSMutableArray array];
        [proArray addObject:array];
    }
    
    //依次找到所有名字
    for (int i = 0; i < self.cityArray.count; i++) {
        //找到所有Model
        BigClassifyModel * model = self.cityArray[i];
        
        NSString * str = [PinYinForObjc chineseConvertToPinYinHead:model.name];
        
        //找到首字母
        char c = [str characterAtIndex:0];
        //将首字母转换为数字 刚好与创建的HeroArray对应
        int arrNum = c - 'a';
        //将英雄信息存入到HeroArray中
        [proArray[arrNum] addObject:model];
    }
    //_heroArray 26 只存了 A B C ->返回段数3;
    //将空数组删除
    
    _tableHeadTitleArr = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < proArray.count; i++) {
        [proArray removeObject:[NSArray array]];
        //将每段的标题获取出来 存储在数组中
        //获取标题首字母
        BigClassifyModel * model = proArray[i][0];
        
        NSString * headTitle = [NSString stringWithFormat:@"%c",[[PinYinForObjc chineseConvertToPinYinHead:model.name] characterAtIndex:0]];
        
        [_tableHeadTitleArr addObject:headTitle];
    }
}
*/

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
////    _tableView.sectionIndexBackgroundColor = [UIColor lightGrayColor];
//    return [self.cityArray valueForKeyPath:@"name"];
////    return  _tableHeadTitleArr;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HospitalViewController *hospitalVC = [[HospitalViewController alloc]init];
    
    BigClassifyModel *pModel = self.cityArray[indexPath.section];
    LiteClassifyModel *cModel = pModel.liteArr[indexPath.row];
    hospitalVC.ids = cModel.ids;
    hospitalVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:hospitalVC animated:YES];
    
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
