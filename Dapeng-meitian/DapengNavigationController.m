//
//  DapengNavigationController.m
//  Dapeng-meitian
//
//  Created by qianfeng on 15/12/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DapengNavigationController.h"
#import "RGBColor.h"
@interface DapengNavigationController ()

@end

@implementation DapengNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"#FFFFFF"],NSFontAttributeName:[UIFont systemFontOfSize:21.0f]};
    
    //设置全局导航栏颜色
//    [[UINavigationBar appearance]setBarTintColor:[RGBColor colorWithHexString:@"#4b95f2"]];
    
    //设置可以更新状态栏的风格
    [self setNeedsStatusBarAppearanceUpdate];
}
//返回状态栏的风格
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
