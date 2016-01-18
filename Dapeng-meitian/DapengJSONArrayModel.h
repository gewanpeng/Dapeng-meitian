//
//  DapengJSONArrayModel.h
//  Dapeng-meitian
//
//  Created by qianfeng on 15/12/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "JSONModel.h"
#import "DapengJSONDicModel.h"
@protocol DapengJSONArrayModel

@end
@protocol dapengJSONArrayMediaModel

@end

@interface DapengJSONArrayModel : JSONModel


@property (nonatomic ,strong)NSString * type;
@property (nonatomic ,strong)NSString * url;

@end

#pragma mark -- 发现-话题
@interface DapengJSOMArrayMediaModel : JSONModel
@property (nonatomic ,strong)NSString * mimeType;
@property (nonatomic ,strong)NSString * value;
@property (nonatomic ,strong)NSString * originalUrl;
@end




