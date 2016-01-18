//
//  DapengLimitCache.h
//  1556爱限免
//
//  Created by qianfeng on 15/12/15.
//  Copyright (c) 2015年 LHF. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DapengLimitCache : NSObject
{
    NSTimeInterval  _myTimer;//定义一个时间间隔 超过变个范围就不读取缓存文件
}

+ (DapengLimitCache *)defalutCache; //创建单利
- (void)saveWithData:(NSData *)data andNameString:(NSString *)urlString; //存缓存
- (NSData *)getDataWithNameString:(NSString *)stringUtl; //读取缓存

@end
