//
//  DapengLimitCache.m
//  1556爱限免
//
//  Created by qianfeng on 15/12/15.
//  Copyright (c) 2015年 LHF. All rights reserved.
//

#import "DapengLimitCache.h"
#import "NSString+Hashing.h"
static DapengLimitCache * dataCache = nil;

@implementation DapengLimitCache

/*
 读取速度更快 节省用户流量 提高用户体验
 
 */

+ (DapengLimitCache *)defalutCache{
    @synchronized(self){ //给 self 加锁 防止数据混乱 产生新的实例
        if (!dataCache) {
            dataCache = [[DapengLimitCache alloc]init];
        }
    }
    return dataCache;
}
+ (id)allocWithZone:(struct _NSZone *)zone{
    @synchronized(self){ //给 self 加锁 防止数据混乱 产生新的实例
        if (!dataCache ) {
            dataCache = [super allocWithZone:zone];
        }
    }
    return dataCache;
}
- (id)init{
    if (self =[super init]) {
        _myTimer = 60;
    }
    return self;
}
//存缓存
- (void)saveWithData:(NSData *)data andNameString:(NSString *)urlString{
    //设置缓存路径
    NSString * cachePath = [NSString stringWithFormat:@"%@/Documents/Cache/",NSHomeDirectory()];
    NSFileManager * manager = [NSFileManager defaultManager];
    
   BOOL isSuc = [manager createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
//    if (isSuc) {
//        NSLog(@"创建成功");
//    }else{
//        NSLog(@"创建失败");
//    }
    
    urlString = [urlString MD5Hash];
    
    NSString * filePath = [NSString stringWithFormat:@"%@%@",cachePath,urlString];
    
    BOOL isWirteSuc = [data writeToFile:filePath atomically:YES];
//    if (isWirteSuc) {
//        NSLog(@"写入成功");
//    }else{
//        NSLog(@"写入失败");
//    }
}

//读取缓存
- (NSData *)getDataWithNameString:(NSString *)stringUtl{
    
   
    stringUtl = [stringUtl MD5Hash];
    
    NSString * path = [NSString stringWithFormat:@"%@/Documents/Cache/%@",NSHomeDirectory(),stringUtl];
    
    
    NSFileManager * manager = [NSFileManager defaultManager];
    //如果路径不存在 返回nil 读取接口数据
    if ([manager fileExistsAtPath:path]) {
        
        return nil;
    }
    //如果存在缓存 判断是否符合读取要求 符合就读取 不符合 返回nil 继续读取接口数据
    
    NSTimeInterval timeInaterval = [[NSDate date]timeIntervalSinceDate:[self getLastWriteFileDate:path]];
    if (timeInaterval > 60) {
        return nil;
    }
    NSData * data = [NSData dataWithContentsOfFile:path];
    
    return data;
}
//获取路径下的文件是最后更新时间
- (NSDate *)getLastWriteFileDate:(NSString *)path{
    
    NSFileManager * manager = [NSFileManager defaultManager];

    //获取path 路径下文件的属性
    NSDictionary * dic = [manager attributesOfItemAtPath:path error:nil];
    //根据key 返回文件最后更新的时间
    return dic[NSFileModificationDate];
}




@end
