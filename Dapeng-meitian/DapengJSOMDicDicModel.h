//
//  DapengJSOMDicDicModel.h
//  Dapeng-meitian
//
//  Created by qianfeng on 15/12/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "JSONModel.h"
#import "DapengJSONDicModel.h"
#import "DapengJSONArrayModel.h"
#import "DapengJSONDicZuiNeiModel.h"
@protocol DapengJSOMDicDicModel

@end
@protocol  DapengJSOMDicDicModelCate

@end

@protocol DapengJSONDicDicModelArticle

@end
@protocol DapengJSONDicDicModelAuthor

@end
@protocol DapengJSONDicDicModelCategory

@end
@protocol DapengJSONDicDicModelImage

@end

@interface DapengJSOMDicDicModel : JSONModel

@property (nonatomic ,strong) NSString * comment;
@property (nonatomic ,strong) NSString * dislike;
@property (nonatomic ,strong) NSString * favorite;
@property (nonatomic ,strong) NSString * like;
@property (nonatomic ,strong) NSString * read;
@property (nonatomic ,strong) NSString * share;

@end
@interface DapengJSOMDicDicModelCate : JSONModel

@property (nonatomic ,strong) NSString * categoryGroupId;
@property (nonatomic ,strong) NSString * color;
@property (nonatomic ,strong) NSString * englishName;
@property (nonatomic ,strong) NSString * icon;
@property (nonatomic ,strong) NSString * image;
@property (nonatomic ,strong) NSString * largeIcon;
@property (nonatomic ,strong) NSString * name;
@end





#pragma mark -- 专栏

@interface DapengJSONDicDicModelArticle : JSONModel

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
@end

@interface DapengJSONDicDicModelAuthor : JSONModel
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
@interface DapengJSONDicDicModelCategory : JSONModel
//category
@property (nonatomic ,strong)NSDictionary * categoryGroup;
@property (nonatomic ,strong)NSString * categoryId;
@property (nonatomic ,strong)NSString * englishName;
@property (nonatomic ,strong)NSString * icon;
@property (nonatomic ,strong)NSString * image;
@property (nonatomic ,strong)NSString * name ;
@property (nonatomic ,strong)NSString * priority;
@end

@interface DapengJSONDicDicModelImage : JSONModel
//featuredArticle
@property (nonatomic ,strong)NSString * type;
@property (nonatomic ,strong)NSString * url;

@end

