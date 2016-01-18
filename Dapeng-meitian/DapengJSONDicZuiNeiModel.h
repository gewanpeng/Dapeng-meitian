//
//  DapengJSONDicZuiNeiModel.h
//  Dapeng-meitian
//
//  Created by qianfeng on 15/12/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "JSONModel.h"
@protocol DapengJSONDicZuiNeiModel

@end
@protocol  DapengJSOMDicZuiNeiModelCate

@end

@interface DapengJSONDicZuiNeiModel : JSONModel


@property (nonatomic ,strong) NSString * comment;
@property (nonatomic ,strong) NSString * dislike;
@property (nonatomic ,strong) NSString * favorite;
@property (nonatomic ,strong) NSString * like;
@property (nonatomic ,strong) NSString * read;
@property (nonatomic ,strong) NSString * share;

@end
@interface DapengJSOMDicZuiNeiModelCate : JSONModel

@property (nonatomic ,strong) NSString * categoryGroupId;
@property (nonatomic ,strong) NSString * color;
@property (nonatomic ,strong) NSString * englishName;
@property (nonatomic ,strong) NSString * icon;
@property (nonatomic ,strong) NSString * image;
@property (nonatomic ,strong) NSString * largeIcon;
@property (nonatomic ,strong) NSString * name;
@end


