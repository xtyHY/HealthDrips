//
//  ShowDetailModel.h
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 @brief 显示详情
 药品:ids、img、message、name、descript
 疾病:ids、img、message、name、descript[department(所属科室)、causetext(致病原因)、symptom(症状)、symptomtext(症状详情)、food(食疗)、foodtext(食疗详情)、drug(用药)、drugtext(用药详情)、checks(检查)、checktext(检查详情)]
 资讯/知识:ids、img、message、title、descript
 书籍:ids、img、name[author(作者)、summary(简介)]
 食品:ids、img、name、descript、message
 菜谱:ids、img、name、descript、message、[food(食材)]
 医院:ids、img、message、name、address、tel[level（医院等级）]
 药店:ids、img、name、address、tel[business(经营范围)、legal(法人)、leader(管理者)]
 */
@interface ShowDetailModel : NSObject

//==券通用
@property (nonatomic, copy) NSString * ids;     //!<id:医院、药品、疾病、资讯、知识、图书、食品、菜谱
@property (nonatomic, copy) NSString * img;     //!<图片:医院、药品、疾病、资讯、知识、图书、食品、菜谱

//==个别通用
@property (nonatomic, copy) NSString * message; //!<内容:医院、药品、疾病、资讯、知识、食品、菜谱
@property (nonatomic, copy) NSString * name;    //!<名称:医院、药品、疾病、图书、食品、菜谱
@property (nonatomic, copy) NSString * title;   //!<标题:资讯、知识
@property (nonatomic, copy) NSString * descript;//!<简介:药品、疾病、资讯、知识、食品、菜谱
@property (nonatomic, copy) NSString * address; //!<地址:医院、药店
@property (nonatomic, copy) NSString * tel;     //!<电话:医院、药店

//==疾病专用
@property (nonatomic, copy) NSString * department;  //!<疾病:医院所属科室
@property (nonatomic, copy) NSString * causetext;   //!<疾病:致病原因
@property (nonatomic, copy) NSString * symptomtext; //!<疾病:症状详情
@property (nonatomic, copy) NSString * foodtext;    //!<疾病:食疗详情
@property (nonatomic, copy) NSString * drugtext;    //!<疾病:用药详情
@property (nonatomic, copy) NSString * checktext;   //!<疾病:检查详情

//==图书专用
@property (nonatomic, copy) NSString * author;  //!<图书:作者
@property (nonatomic, copy) NSString * summary; //!<图书:简介

//==医院专用
@property (nonatomic, copy) NSString * level;   //!<医院:等级

//==药店专用
@property (nonatomic, copy) NSString * business;    //!<药店:经营范围
@property (nonatomic, copy) NSString * legal;       //!<药店:法人代表
@property (nonatomic, copy) NSString * leader;      //!<药店:管理者

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)fillModelWithDict:(NSDictionary *)dict;

@end
