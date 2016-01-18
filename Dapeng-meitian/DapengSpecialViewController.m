//
//  DapengSpecialViewController.m
//  Dapeng-meitian
//
//  Created by qianfeng on 15/12/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DapengSpecialViewController.h"
#import "PathHeader.h"
#import "DapengHttpRequest.h"
#import "DapengJSONModel.h"
#import "UIImageView+WebCache.h"
#import "DapengSpecialTableViewCell.h"
#import "DapengSpecialHuodongTableViewCell.h"
#import "DapengSpecialScrollView.h"
#import "DapengHuoDongConnterViewController.h"
#import "DapengZuoZheTableViewCell.h"
#import "DapengSpecialConnterViewController.h"
static NSArray * titles = nil;
@interface DapengSpecialViewController ()<UITableViewDelegate,UITableViewDataSource,DapengSpecialDelegate,DapengZuoZheDelegate>
{
    int page;
    int page1;
}

@property (nonatomic ,strong)NSMutableArray * dataTopArray;
@property (nonatomic ,strong)NSMutableArray * dataZuoArray;
@property (nonatomic ,strong)NSMutableArray * dataArray;
@property (nonatomic ,strong)UITableView * tableView;//整体的table

@end

@implementation DapengSpecialViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    page = 6;
    page1 = 10;
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    if (!titles) {
        titles = @[@"最近更新",@"专栏活动",@"推荐作者"];
    }
    
    
    
    [self initTopRequest];
    [self initZuozheRequest];
}
- (void)initTopRequest{
    DapengHttpRequest * request = [[DapengHttpRequest alloc]init];
    [request downloadDataWithUrlString:[NSString stringWithFormat:ZL_NEW,page] finished:^(NSData *data) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * array = dic[@"result"];
        _dataTopArray = [DapengJSONModel arrayOfModelsFromDictionaries:array error:nil];
        
        [self setTopTableView];
        [self createScroll];
//        [self initBiaoTiRequest];//解析标题
//        NSLog(@"%@",_dataTopArray);
    } failed:^(NSString *error) {
        NSLog(@"请求错误");
        NSLog(@"%@",error);
    }];
}
- (void)initZuozheRequest{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    DapengHttpRequest * request = [[DapengHttpRequest alloc]init];
    [request downloadDataWithUrlString:[NSString stringWithFormat:ZL_NEW,page1] finished:^(NSData *data) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * array = dic[@"result"];
        _dataArray = [NSMutableArray array];
        _dataZuoArray = [DapengJSONModel arrayOfModelsFromDictionaries:array error:nil];
        for (int i = 6; i<_dataZuoArray.count; i++) {
            
            [_dataArray addObject:_dataZuoArray[i]];
            
        }
//        NSLog(@"%lu",(unsigned long)_dataArray.count);
        [hud show:YES];
    } failed:^(NSString *error) {
        NSLog(@"请求错误");
        NSLog(@"%@",error);
    }];

}


- (void)createScroll{
    DapengSpecialScrollView * scroll = [[DapengSpecialScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    self.tableView.tableHeaderView = scroll;
}
- (void)setTopTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-49) style:UITableViewStylePlain];
    _tableView.bounces = YES;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    for (int i = 0; i<titles.count; i++) {
        if ([titles[i] isEqualToString:@"专栏活动"]) {
            [_tableView registerClass:[DapengSpecialHuodongTableViewCell class] forCellReuseIdentifier:@"celll"];
        }else if ([titles[i] isEqualToString:@"最近更新"]){
            [_tableView registerClass:[DapengSpecialTableViewCell class] forCellReuseIdentifier:@"cell"];
        }else if ([titles[i] isEqualToString:@"推荐作者"]){
            [_tableView registerClass:[DapengZuoZheTableViewCell class] forCellReuseIdentifier:@"cellll"];
        }
    }

}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return titles.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    for (int i = 0; i<3; i++) {
        if ([titles[section] isEqualToString:@"专栏活动"]) {
            return 1;
        }else if ([titles[section] isEqualToString:@"最近更新"]){
            return _dataTopArray.count/2;
        }else if([titles[section] isEqualToString:@"推荐作者"]){
            return _dataArray.count/2;
        }
    }
    return 2;
}
//标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section < titles.count) {
        return  titles[section];
    }
    return @"";
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        if ([titles[indexPath.section] isEqualToString:@"专栏活动"]) {
            return 120;
        }else if ([titles[indexPath.section] isEqualToString:@"最近更新"]){
            return 160;
        }else if([titles[indexPath.section] isEqualToString:@"推荐作者"]){
            return 160;
        }

    return 80;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectZero];
    
    UILabel * lib = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 5, 20)];
    lib.backgroundColor = [UIColor redColor];
    [view addSubview:lib];
    UILabel * lib1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lib.frame)+10, 20,100, 20)];
    lib1.text = titles[section];
    lib1.textColor = [UIColor colorWithRed:143/255.0 green:143/255.0 blue:143/255.0 alpha:1];
    lib1.font = [UIFont systemFontOfSize:14];
    [view addSubview:lib1];
    
    return view;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = nil;
    
//    NSLog(@"%ld",(long)indexPath.section);

        if ([titles[indexPath.section] isEqualToString:@"专栏活动"]) {
            DapengSpecialHuodongTableViewCell * celll = [tableView dequeueReusableCellWithIdentifier:@"celll" forIndexPath:indexPath];
  
            return celll;
        }else if([titles[indexPath.section] isEqualToString:@"最近更新"]){
            DapengSpecialTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            
            NSInteger index = indexPath.row;
            NSMutableArray * list = [NSMutableArray arrayWithCapacity:2];
            for (NSInteger i =0; i<2; i++) {
                [list addObject:_dataTopArray[index * 2 +i]];
            }
            cell.delegate = self;
            [cell bindProducts:list];
            return cell;
        }else if([titles[indexPath.section] isEqualToString:@"推荐作者"]){
//            NSLog(@"111");
            DapengZuoZheTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellll" forIndexPath:indexPath];
            
            
            NSInteger index = indexPath.row;
            NSMutableArray * list = [NSMutableArray arrayWithCapacity:2];
            for (NSInteger i =0; i<2; i++) {
//                NSLog(@"%@",_dataArray[index * 2 +i]);
                [list addObject:_dataArray[index * 2 +i]];
            }
            cell.delegate = self;
            [cell bindProducts:list];
            return cell;

        }
   
    return  cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([titles[indexPath.section] isEqualToString:@"专栏活动"]) {
        DapengHuoDongConnterViewController * huodong = [[DapengHuoDongConnterViewController alloc]init];
        [self.navigationController pushViewController:huodong animated:YES];
    }else if ([titles[indexPath.section] isEqualToString:@"最近更新"]){
        
//        DapengSpecialTableViewCell * special = [[DapengSpecialTableViewCell alloc]init];
//        DapengJSONModel * model = _dataTopArray[indexPath.row];
        
//        special.model = model;
        
//        [self.navigationController pushViewController:special animated:YES];
        
        
    }else{
        NSLog(@"22");
    }

    
    
}



//点击事件回调
- (void)productCell:(DapengSpecialTableViewCell *)cell actionWithFlag:(NSString *)flag andArray:(NSArray *)arr{
    DapengSpecialConnterViewController * connter = [[DapengSpecialConnterViewController alloc]init];
    connter.str = flag;
    connter.arr = arr;
    [self.navigationController pushViewController:connter animated:YES];
    
}
- (void)productZuoCell:(DapengZuoZheTableViewCell *)cell actionWithFlag:(NSString *)flag andArray:(NSArray *)arr{
    
    DapengSpecialConnterViewController * connter = [[DapengSpecialConnterViewController alloc]init];
    connter.str = flag;
    connter.arr = arr;
    [self.navigationController pushViewController:connter animated:YES];
    
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
