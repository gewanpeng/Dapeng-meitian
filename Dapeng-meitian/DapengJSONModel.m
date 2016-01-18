//
//  DapengJSONModel.m
//  Dapeng-meitian
//
//  Created by qianfeng on 15/12/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DapengJSONModel.h"

@implementation DapengJSONModel

+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end

@implementation DapengBiaoModel

+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end

@implementation DapengZhuanLanModel
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end
@implementation DapengZhuanLanHuoDongModel

+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end

@implementation DapengZhuanLanHuoDongNeiModel


+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end
@implementation DapengHuaTiModel


+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end
@implementation DapengHutTiTopModel


+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end

