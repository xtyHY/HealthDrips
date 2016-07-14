//
//  UtilsMacros.h
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//  工具宏

#ifndef HealthDrips_UtilsMacros_h
#define HealthDrips_UtilsMacros_h

//打印函数信息和行数
#define DLOG NSLog(@"[FUNCTION]:%s [LINE]:%d",__FUNCTION__,__LINE__);

//设置RBGA（红、绿、蓝、透明度）
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
//设置RGB（红、绿、蓝、不透明）
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//==判断ios版本，用于处理不同版本问题
//大于等于7.0的ios版本
#define iOS7_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")
//大于等于8.0的iOS版本
#define iOS8_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")
//大于等于9.0的iOS版本
#define iOS9_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")


//获取系统时间戳（1970为起点）
#define getCurentTime [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]]

//==主题配色
//主色调，icon、启动界面都是这个色值
#define THEME_MAIN_COLOR RGBA(0,230,173,1)
//TabBar的颜色
#define THEME_TAB_BAR_TEXT_COLOR RGBA(0,160,100,1)
//随机颜色
#define Srand_Color RGB(arc4random()%256,arc4random()%256,arc4random()%256)
//浅灰的线或者背景
#define THEME_LIGHT_GRAY RGB(244, 244, 244)
//
#define THEME_SECTION_HEARD RGB(244, 167, 65)

//==TAG
//==SearchCenter
#define SearchCenter_Btn_Tag 100 

#endif
