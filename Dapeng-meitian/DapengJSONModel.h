//
//  DapengJSONModel.h
//  Dapeng-meitian
//
//  Created by qianfeng on 15/12/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "JSONModel.h"
#import "DapengJSONDicModel.h"
#import "DapengJSONArrayModel.h"
@interface DapengJSONModel : JSONModel


#pragma mark -- 发现
@property (nonatomic ,strong) NSDictionary * article;
@property (nonatomic ,strong) NSDictionary * author;
@property (nonatomic ,strong) NSDictionary * category;
@property (nonatomic ,strong) NSDictionary * featuredArticle;
@property (nonatomic ,strong) NSArray<DapengJSONArrayModel> * image;
@property (nonatomic ,strong) NSNumber * priority;


@end


@interface DapengBiaoModel : JSONModel

//标题
@property (nonatomic ,strong)NSString * categoryGroupId;
@property (nonatomic ,strong)NSString * color;
@property (nonatomic ,strong)NSString * englishName;
@property (nonatomic ,strong)NSString * icon;
@property (nonatomic ,strong)NSString * image;
@property (nonatomic ,strong)NSString * largeIcon;
@property (nonatomic ,strong)NSString * name;

@end


#pragma mark -- 专栏
@interface DapengZhuanLanModel : JSONModel

@property (nonatomic ,strong) NSDictionary * article;
@property (nonatomic ,strong) NSDictionary * author;
@property (nonatomic ,strong) NSArray * category;
@property (nonatomic ,strong) NSDictionary * featuredArticle;
@property (nonatomic ,assign) Boolean latest;
@property (nonatomic ,strong) NSNumber * priority;

@end
#pragma mark -- 专栏活动
@interface DapengZhuanLanHuoDongModel : JSONModel

@property (nonatomic ,strong) NSString * backgroundImage;

@property (nonatomic ,strong) NSString * introduction;
@property (nonatomic ,strong) NSString * title;
@property (nonatomic ,strong) NSString * url;
@end
#pragma mark -- 专栏活动内容
@interface DapengZhuanLanHuoDongNeiModel : JSONModel

@property (nonatomic ,strong) NSDictionary * article;
@property (nonatomic ,strong) NSDictionary * author;
@property (nonatomic ,strong) NSDictionary * category;
@property (nonatomic ,strong) NSArray * image;
@property (nonatomic ,strong) NSArray * relatedArticle;

@end

#pragma mark -- 话题

@interface DapengHuaTiModel : JSONModel
@property (nonatomic ,strong)NSDictionary * activity;
@property (nonatomic ,strong)NSDictionary * post;
@property (nonatomic ,strong)NSString * sequenceId;
@property (nonatomic ,strong)NSDictionary * user;
@property (nonatomic ,strong)NSArray * voteUsers;

@end


#pragma mark -- 话题头部

@interface DapengHutTiTopModel : JSONModel
@property (nonatomic ,strong)NSDictionary * activity;
@property (nonatomic ,strong)NSString * sequenceId;

@end


