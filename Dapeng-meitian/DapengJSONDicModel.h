//
//  DapengJSONDicModel.h
//  Dapeng-meitian
//
//  Created by qianfeng on 15/12/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "JSONModel.h"
#import "DapengJSOMDicDicModel.h"
@protocol DapengJSONDicModel

@end
@protocol DapengJSONDicModelAuthor

@end
@protocol DapengJSONDicModelCategory

@end
@protocol DapengJSONDicModelFea

@end
@protocol DapengJSONDicModelImage

@end

@interface DapengJSONDicModel : JSONModel

//article
@property (nonatomic ,strong)NSString * articleId;
@property (nonatomic ,strong)NSDictionary * articleStats;
@property (nonatomic ,strong)NSNumber * createdTime;
@property (nonatomic ,strong)NSNumber * modifiedTime;
@property (nonatomic ,strong)NSNumber * renderType;
@property (nonatomic ,strong)NSString * summary;
@property (nonatomic ,strong)NSArray * tags;
@property (nonatomic ,strong)NSString * title;
@property (nonatomic ,strong)NSString * url;
@property (nonatomic ,strong)NSString * weblink;

#pragma mark -- 专栏
@property (nonatomic ,strong)NSDictionary * article;
@property (nonatomic ,strong)NSDictionary * author;
@property (nonatomic ,strong)NSDictionary * category;
@property (nonatomic ,strong)NSArray * image;

@end


@interface DapengJSONDicModelAuthor : JSONModel
//author
@property (nonatomic ,strong)NSString * authorId;
@property (nonatomic ,strong)NSString * avatar;
@property (nonatomic ,strong)NSString * contactId;
@property (nonatomic ,strong)NSString * contactType;
@property (nonatomic ,strong)NSString * contract;
@property (nonatomic ,strong)NSString * gender;
@property (nonatomic ,strong)NSString * image;
@property (nonatomic ,strong)NSString * introduction;
@property (nonatomic ,strong)NSString * name;
@property (nonatomic ,strong)NSString * serviceParam;
@property (nonatomic ,strong)NSString * serviceType;
@end



@interface DapengJSONDicModelCategory : JSONModel
//category
@property (nonatomic ,strong)NSDictionary * categoryGroup;
@property (nonatomic ,strong)NSString * categoryId;
@property (nonatomic ,strong)NSString * englishName;
@property (nonatomic ,strong)NSString * icon;
@property (nonatomic ,strong)NSString * image;
@property (nonatomic ,strong)NSString * name ;
@property (nonatomic ,strong)NSString * priority;
@end



@interface DapengJSONDicModelFea : JSONModel
//featuredArticle
@property (nonatomic ,strong)NSString * priority;
@property (nonatomic ,strong)NSString * publishTime;

@end

@interface DapengJSONDicModelImage : JSONModel
//featuredArticle
@property (nonatomic ,strong)NSString * type;
@property (nonatomic ,strong)NSString * url;

@end



#pragma mark -- 话题















