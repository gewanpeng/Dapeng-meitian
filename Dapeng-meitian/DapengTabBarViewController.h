//
//  DapengTabBarViewController.h
//  Dapeng-meitian
//
//  Created by qianfeng on 15/12/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DapengTabBarViewController : UITabBarController

-(void)addTabbarTitle:(NSString *)titleString andVCString:(NSString *)vcName image:(NSString *)imageName selectImage:(NSString *)selectImage;

@end
