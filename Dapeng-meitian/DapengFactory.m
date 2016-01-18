//
//  DapengFactory.m
//  Dapeng-meitian
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "DapengFactory.h"

@implementation DapengFactory
//设置安装
+ (void)setInstall:(NSString *)str{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    
    [ud setObject:str forKey:@"tall"];
}
//判断安装
+ (BOOL)getInstall{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    
    return [[ud objectForKey:@"tall"] boolValue];
    
}

@end
