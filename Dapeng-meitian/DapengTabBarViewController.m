//
//  DapengTabBarViewController.m
//  Dapeng-meitian
//
//  Created by qianfeng on 15/12/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DapengTabBarViewController.h"
#import "DapengNavigationController.h"

@interface DapengTabBarViewController ()
{
    NSMutableArray *array;
}
@end

@implementation DapengTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    array = [NSMutableArray array];
}
-(void)addTabbarTitle:(NSString *)titleString andVCString:(NSString *)vcName image:(NSString *)imageName selectImage:(NSString *)selectImage
{
    //vc的类名转成类
    Class class = NSClassFromString(vcName);
    
    UIViewController *vc  = [[class alloc]init];
    vc.title = titleString;
    
//    DapengNavigationController *nav  = [[DapengNavigationController alloc]initWithRootViewController:vc];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
    //普通状态的图片
    vc.tabBarItem.image = [[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //选中状态的图片
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [array addObject:nav];
    self.viewControllers = array;
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
