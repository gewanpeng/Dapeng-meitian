//
//  AppDelegate.m
//  Dapeng-meitian
//
//  Created by qianfeng on 15/12/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AppDelegate.h"
#import "DapengGuidanceViewController.h"
#import "DapengTabBarViewController.h"
#import "WMPageController.h"
#import "DapengFoundViewController.h"
#import "DapengEveryViewController.h"
#import "DapengFactory.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setTabbarCtrlc) name:@"tabbar1" object:nil];
    BOOL isSue = [DapengFactory getInstall];
    if (isSue) {
        self.window.rootViewController = [self setTabbarCtrl];
    }else{
        [self setGuidance];
    }
    [self.window makeKeyAndVisible];
    

    return YES;
}
- (void)setTabbarCtrlc{
    self.window.rootViewController = [self setTabbarCtrl];
}
- (void)setGuidance{
    DapengGuidanceViewController * guidan = [[DapengGuidanceViewController alloc]init];
    self.window.rootViewController = guidan;
}
- (DapengTabBarViewController *)setTabbarCtrl{
    DapengTabBarViewController * tabBar = [[DapengTabBarViewController alloc]init];
    [tabBar addTabbarTitle:@"每天" andVCString:@"DapengEveryViewController" image:@"qr_tabbar_bookshelf@2x" selectImage:@"qr_tabbar_bookshelf_hl@2x"];
    [tabBar addTabbarTitle:@"发现" andVCString:@"DapengFoundViewController" image:@"iconfont-iconfontzhubaoshipin" selectImage:@"iconfont-iconfontzhubaoshipin_lh"];
    [tabBar addTabbarTitle:@"专栏" andVCString:@"DapengSpecialViewController" image:@"iconfont-1376zhuanti" selectImage:@"iconfont-1376zhuanti_lh"];
    
//    self.window.rootViewController = tabBar;
    return tabBar;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
