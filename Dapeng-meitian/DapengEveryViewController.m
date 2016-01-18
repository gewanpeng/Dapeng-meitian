//
//  DapengEveryViewController.m
//  Dapeng-meitian
//
//  Created by qianfeng on 15/12/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//
#import "PathHeader.h"
#import "DapengEveryViewController.h"
#import "DapengHttpRequest.h"
#import "DapengJSONModel.h"
#import "DapengTableViewCell.h"
#import "DapengFoundConnterViewController.h"
#import "DapengEveryContentViewController.h"

#import "DapengWheelView.h"
#import "MBProgressHUD.h"
@interface DapengEveryViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int top;
}
@property (nonatomic ,strong)UITableView * tableView;//整体的table
@property (nonatomic ,strong)NSMutableArray * dataNameArray;
@end

@implementation DapengEveryViewController
@synthesize dataNameArray = _dataNameArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self hideNavigationBar];
    top = 10;
    _dataNameArray = [NSMutableArray array];
    [self initHttpRequest];
    UIView * viewHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
    viewHeader.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewHeader];
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30, 20, 60, 30)];
    title.text = @"每天";
    title.font = [UIFont systemFontOfSize:15 weight:5];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor blackColor];
    [viewHeader addSubview:title];


}
//隐藏系统导航条
- (void)hideNavigationBar{
    self.navigationController.navigationBar.hidden = YES;
}
- (void)initHttpRequest{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    DapengHttpRequest * request = [[DapengHttpRequest alloc]init];
    [request downloadDataWithUrlString:[NSString stringWithFormat:Day_Wangqi,top] finished:^(NSData *data) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * array = dic[@"result"];
        _dataNameArray = [DapengJSONModel arrayOfModelsFromDictionaries:array error:nil];
        [self createImage];
        
        [hud hide:YES];
    } failed:^(NSString *error) {
        NSLog(@"请求错误");
        NSLog(@"%@",error);
    }];
}

- (void)createImage{
    NSMutableArray * imageArray = [NSMutableArray array];
    for (int i=0; i< _dataNameArray.count; i++) {
        DapengJSONModel * model = _dataNameArray[i];
        DapengJSONArrayModel * arrModel = model.image[0];
        UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:arrModel.url]]];
        [imageArray addObject:image];
    }
    DapengWheelView * wheelView = [[DapengWheelView alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height - 49 - 65)];
    wheelView.images = imageArray;
    wheelView.backgroundColor = [UIColor clearColor];
    wheelView.click = ^(int i){
        if (i != 0) {
        DapengEveryContentViewController * every = [[DapengEveryContentViewController alloc]init];
        every.model = _dataNameArray[i-1];
        every.isFen = @"tupian";
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:every animated:YES];
        self.hidesBottomBarWhenPushed=NO;
        }else{
            DapengEveryContentViewController * every = [[DapengEveryContentViewController alloc]init];
            every.model = _dataNameArray[(_dataNameArray.count + 1)/2];
            every.isFen = @"tupian";
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:every animated:YES];
            self.hidesBottomBarWhenPushed=NO;
        }
    };
    [self.view addSubview:wheelView];
    
    
    
    
}


















#pragma mark -- 行信息
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 65, self.view.bounds.size.width, self.view.bounds.size.height-49-65) style:UITableViewStylePlain];
    _tableView.bounces = YES;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[DapengTableViewCell class] forCellReuseIdentifier:@"cell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataNameArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPat{
    DapengTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPat];
    
    if (_dataNameArray.count>1) {
        
        DapengJSONModel * model = _dataNameArray[indexPat.row];
        //        NSLog(@"%@",model.author[@"name"]);
        cell.model = model;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    DapengFoundConnterViewController * connter =[[DapengFoundConnterViewController alloc]init];
    DapengJSONModel * model = _dataNameArray[indexPath.row];
    connter.model = model;
    connter.isFen = @"Cell";
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:connter animated:YES];
    self.hidesBottomBarWhenPushed=NO;
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
