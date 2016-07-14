//
//  ApisMacros.h
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//  接口宏
//  文档地址http://www.tngou.net/doc/#medical

#ifndef HealthDrips_ApisMacros_h
#define HealthDrips_ApisMacros_h

//基本api地址
#define API_BASE_URL    @"http://www.tngou.net/api/"

//图片接口
#define API_PIC         @"http://tnfs.tngou.net/image"
//搜索接口
#define API_Search      @"http://www.tngou.net/api/search"

//==健康资讯
//取得健康资讯分类，可以通过分类id取得资讯列表
#define API_INFO_CLASSIFY   [API_BASE_URL stringByAppendingPathComponent:@"info/classify"]
//取得健康资讯列表，也可以用分类id作为参数取得列表
#define API_INFO_LIST       [API_BASE_URL stringByAppendingPathComponent:@"info/list"]
//取得最新的健康资讯，通过id取得大于该id的新闻
#define API_INFO_NEWS       [API_BASE_URL stringByAppendingPathComponent:@"info/news"]
//取得资讯详情，通过热点id取得该对应详细内容信息
#define API_INFO_SHOW       [API_BASE_URL stringByAppendingPathComponent:@"info/show"]

//==健康知识
//取得健康知识分类，可以通过分类id取得问答列表
#define API_LORE_CLASSIFY   [API_BASE_URL stringByAppendingPathComponent:@"lore/classify"]
//取得健康知识列表，也可以用分类id作为参数
#define API_LORE_LIST       [API_BASE_URL stringByAppendingPathComponent:@"lore/list"]
//取得最新的健康知识，通过id取得大于该id的知识
#define API_LORE_NEWS       [API_BASE_URL stringByAppendingPathComponent:@"lore/news"]
//取得健康知识，通过热点id取得该对应详细内容信息
#define API_LORE_SHOW       [API_BASE_URL stringByAppendingPathComponent:@"lore/show"]

//==健康图书
//取得健康知识列表，也可以用分类id作为参数
#define API_BOOK_LIST       [API_BASE_URL stringByAppendingPathComponent:@"book/list"]
//取得健康知识，通过健康图书id取得该对应详细内容信息
#define API_BOOK_SHOW       [API_BASE_URL stringByAppendingPathComponent:@"book/show"]

//==药品信息
//取得药品分类，可以通过分类id取得药品列表(已有本地plist)
#define API_DRUG_CLASSIFY   [API_BASE_URL stringByAppendingPathComponent:@"drug/classify"]
//取得药品列表，也可以用分类id作为参数
#define API_DRUG_LIST       [API_BASE_URL stringByAppendingPathComponent:@"drug/list"]
//取得药品名称详情，通过name取得药品详情
#define API_DRUG_NAME       [API_BASE_URL stringByAppendingPathComponent:@"drug/name"]
//取得药品信息，通过id取得该对应详细内容信息
#define API_DRUG_SHOW       [API_BASE_URL stringByAppendingPathComponent:@"drug/show"]
//通过国药准字查询药品信息
#define API_DRUG_NUMBER     [API_BASE_URL stringByAppendingPathComponent:@"drug/number"]
//通过条形码查询药品信息
#define API_DRUG_CODE       [API_BASE_URL stringByAppendingPathComponent:@"drug/code"]

//==疾病信息
//取得疾病列表，也可以用分类id作为参数(已有本地plist)
#define API_DISEASE_LIST    [API_BASE_URL stringByAppendingPathComponent:@"disease/list"]
//取得身体部位疾病，也可以用身体id作为参数
#define API_DISEASE_PLACE   [API_BASE_URL stringByAppendingPathComponent:@"disease/place"]
//取得科室疾病，也可以用科室id作为参数
#define API_DISEASE_DEPART  [API_BASE_URL stringByAppendingPathComponent:@"disease/department"]
//取得疾病名称详情，通过name取得疾病详情
#define API_DISEASE_NAME    [API_BASE_URL stringByAppendingPathComponent:@"disease/name"]
//取得疾病信息，id取得该对应详细内容信息
#define API_DISEASE_SHOW    [API_BASE_URL stringByAppendingPathComponent:@"disease/show"]

//==医院信息
//取得医院列表，可以通过地域城市id取得医院列表
#define API_HOSPITAL_LIST   [API_BASE_URL stringByAppendingPathComponent:@"hospital/list"]
//通过位置坐标 x,y取得周边医院
#define API_HOSPITAL_LOCATION  [API_BASE_URL stringByAppendingPathComponent:@"hospital/location"]
//取得医院，id取得该对应详细内容信息
#define API_HOSPITAL_SHOW   [API_BASE_URL stringByAppendingPathComponent:@"hospital/show"]
//医院名称，取得医院信息
#define API_HOSPITAL_NAME   [API_BASE_URL stringByAppendingPathComponent:@"hospital/name"]
//医院科室，取得医院特色科室
#define API_HOSPITAL_FEATURE   [API_BASE_URL stringByAppendingPathComponent:@"hospital/feature"]

//==药店信息
//取得药店列表，可以通过地域城市id取得药店列表
#define API_STORE_LIST      [API_BASE_URL stringByAppendingPathComponent:@"store/list"]
//通过位置坐标 x,y取得周边药店
#define API_STORE_LOCATION  [API_BASE_URL stringByAppendingPathComponent:@"store/location"]
//取得药房药店，id取得该对应详细内容信息
#define API_STORE_SHOW      [API_BASE_URL stringByAppendingPathComponent:@"store/show"]
//药店名称，取得药店信息
#define API_STORE_NAME      [API_BASE_URL stringByAppendingPathComponent:@"store/name"]

//==食品信息
//取得食品分类，可以通过分类id取得问答列表(已有本地plist)
#define API_FOOD_CLASSIFY   [API_BASE_URL stringByAppendingPathComponent:@"food/classify"]
//取得食品列表，也可以用分类id作为参数
#define API_FOOD_LIST       [API_BASE_URL stringByAppendingPathComponent:@"food/list"]
//取得食品名称详情，通过name取得食品详情
#define API_FOOD_NAME       [API_BASE_URL stringByAppendingPathComponent:@"food/name"]
//取得食品信息，通过食物id取得该对应详细内容信息
#define API_FOOD_SHOW       [API_BASE_URL stringByAppendingPathComponent:@"food/show"]

//==菜谱信息
//取得菜谱分类，可以通过分类id取得问答列表(已有本地plist)
#define API_COOK_CLASSIFY   [API_BASE_URL stringByAppendingPathComponent:@"cook/classify"]
//取得菜谱列表，也可以用分类id作为参数
#define API_COOK_LIST       [API_BASE_URL stringByAppendingPathComponent:@"cook/list"]
//取得菜谱名称详情，通过name取得菜谱详情
#define API_COOK_NAME   [API_BASE_URL stringByAppendingPathComponent:@"cook/name"]
//取得菜谱信息，菜谱id取得该对应详细内容信息
#define API_COOK_SHOW   [API_BASE_URL stringByAppendingPathComponent:@"cook/show"]

//==地市信息(已有本地plist)
//取得地域信息
#define API_AREA_REGION     [API_BASE_URL stringByAppendingPathComponent:@"area/region"]
//取得省份信息
#define API_AREA_PROVINCE   [API_BASE_URL stringByAppendingPathComponent:@"area/province"]
//取得城市信息
#define API_AREA_CITY       [API_BASE_URL stringByAppendingPathComponent:@"area/city"]

//==获取科室(已有本地plist)
//取得全部科室
#define API_DEPARTMENT_ALL  [API_BASE_URL stringByAppendingPathComponent:@"department/all"]
//取得科室列表
#define API_DEPARTMENT_CLASSIFY  [API_BASE_URL stringByAppendingPathComponent:@"department/classify"]

//==身体部位(已有本地plist)
//取得全部部位（两层)
#define API_PLACE_ALL       [API_BASE_URL stringByAppendingPathComponent:@"place/all"]
//传入模糊部分id获得详细部位，不传则获取模糊部位
#define API_PLACE_CLASSIFY  [API_BASE_URL stringByAppendingPathComponent:@"place/classify"]

//==用户接口[长度限制account(20),password(20),nickname(20),email(40)]
//注册接口[必填account、password、nickname(昵称)选填email(邮箱)、icon(头像)]
//调用实例 http://www.devhy.com/myApi/HealthDripsUser.php?action=add&account=devhy&password=123456&nickname=hy&email=442312699@qq.com&icon=v.png
#define API_USER_REGISTER   @"http://www.devhy.com/myApi/HealthDripsUser.php?action=add"
//登陆接口[必填account、password]
//调用实例http://www.devhy.com/myApi/HealthDripsUser.php?action=login&account=hy123&password=123
#define API_USER_LOGIN      @"http://www.devhy.com/myApi/HealthDripsUser.php?action=login"
//查询用户接口[必填项account]
//调用实例http://www.devhy.com/myApi/HealthDripsUser.php?action=find&account=hy123
#define API_USER_FIND       @"http://www.devhy.com/myApi/HealthDripsUser.php?action=find"

//==ApiKey
#define KEY_UMENG   @"56468f0fe0f55aa55e007ddf"

//徐天宇xcode7真机Amap com.devhy.HealthDrips5
#define KEY_AMAP    @"be8f6319d7569866b04e07893e34115d"

//上架用的AMAP
//#define KEY_AMAP    @"3c158d4e21fc7bbcddfed7a827b9ecd8"

//==详情网址
#define WEB_SHARE_NEWS       @"http://www.tngou.net/news/show/"
#define WEB_SHARE_LORE       @"http://www.tngou.net/lore/show/"
#define WEB_SHARE_BOOK       @"http://www.tngou.net/book/show/"
#define WEB_SHARE_FOOD       @"http://www.tngou.net/food/show/"
#define WEB_SHARE_COOK       @"http://www.tngou.net/cook/show/"
#define WEB_SHARE_DRUG       @"http://www.tngou.net/drug/show/"
#define WEB_SHARE_DISEASE    @"http://www.tngou.net/disease/show/"
#define WEB_SHARE_HOSPITAL   @"http://www.tngou.net/hospital/show/"
#define WEB_SHARE_STORE      @"http://www.tngou.net/store/show/"

typedef enum : NSInteger {
    ShowDetailNews = 0,  //!<新闻
    ShowDetailLore,      //!<知识
    ShowDetailBook,      //!<图书
    ShowDetailFood,      //!<食物
    ShowDetailCook,      //!<菜谱
    ShowDetailDrug,      //!<药品
    ShowDetailDisease,   //!<疾病
    ShowDetailHospital,  //!<医院
    ShowDetailStore      //!<药店
    
} ShowDetailType;

#endif
