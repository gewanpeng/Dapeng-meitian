//
//  DapengFactory.h
//  Dapeng-meitian
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DapengFactory : NSObject
//判断安装
+ (BOOL)getInstall;
//设置安装
+ (void)setInstall:(NSString *)str;
@end
