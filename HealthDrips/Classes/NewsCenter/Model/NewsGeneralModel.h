//
//  InfoGeneralModel.h
//  HealthDrips
//
//  Created by Cedric.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//
//咨询 通用Model

#import <Foundation/Foundation.h>

@interface NewsGeneralModel : NSObject

/*
 ID编码
 */
@property(nonatomic, copy) NSString * genID;

/*
 关键词
 */
@property(nonatomic, copy) NSString * keywords;

/*
 标题
 */
@property(nonatomic, copy) NSString * title;

/*
 简介
 */
@property(nonatomic, copy) NSString * des;

/*
 图片
 */
@property(nonatomic, copy) NSString * img;

/*
 内容
 */
@property(nonatomic, copy) NSString * message;

/*
 分类ID
 */
@property(nonatomic, copy) NSString * infoclass;

/*
 访问数
 */
@property(nonatomic, copy) NSString * count;

/*
 评论数
 */
@property(nonatomic, copy) NSString * rcount;

/*
 收藏数
 */
@property(nonatomic, copy) NSString * fcount;

/*
 发布时间
 */
@property(nonatomic, copy) NSString * time;

/*
 分类的排序，从小到大的递增排序
 */
@property(nonatomic, copy) NSString *seq;

/*
 作者
 */
@property (nonatomic , copy) NSString * author;


@property (nonatomic , copy) NSString * loreclass;

@end
