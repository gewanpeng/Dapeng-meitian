
//
//  DapengFoundViewController.m
//  Dapeng-meitian
//
//  Created by qianfeng on 15/12/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DapengFoundViewController.h"
#import "DapengFoundTowViewController.h"
#import "DapengFoundThreeViewController.h"
#import "DapengFoundFourViewController.h"
@interface DapengFoundViewController ()

@end

@implementation DapengFoundViewController


-(instancetype)init{
    if (self = [super init]) {
        self = [self createPagCtr];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 25)];
//    view1.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view1];
    self.navigationController.navigationBar.hidden = YES;
    
}

-(DapengFoundViewController *)createPagCtr{
    NSMutableArray * viewArray = [NSMutableArray array];
    NSMutableArray * titleArray = [NSMutableArray array];
    for (int i = 0; i<2; i++) {
        Class vcClass;
        NSString * title;
        
        switch (i) {
            case 0:
            {
                vcClass = [DapengFoundTowViewController class];
                title = @"推荐";
            } break;
                case 1:
            {
                vcClass = [DapengFoundThreeViewController class];
                title = @"话题";
            } break;
//                case 2:
//            {
//                vcClass = [DapengFoundFourViewController class];
//                title = @"闪购";
//            }break;
        }
        [viewArray addObject:vcClass];
        [titleArray addObject:title];
    }
    DapengFoundViewController * pageVC = [[DapengFoundViewController alloc]initWithViewControllerClasses:viewArray andTheirTitles:titleArray];
    pageVC.menuViewStyle = WMMenuViewStyleLine;
    pageVC.pageAnimatable = YES;
    pageVC.menuItemWidth = [UIScreen mainScreen].bounds.size.width /4;
    pageVC.postNotification = NO;
    pageVC.bounces = YES;
    pageVC.titleColorSelected = [UIColor colorWithRed:109/255.0 green:140/255.0 blue:240/255.0 alpha:1];
    pageVC.titleSizeNormal = 15;
    pageVC.titleSizeSelected = 15;
    
    return pageVC;
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
