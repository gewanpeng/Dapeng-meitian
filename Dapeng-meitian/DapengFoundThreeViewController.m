//
//  DapengFoundThreeViewController.m
//  Dapeng-meitian
//
//  Created by qianfeng on 16/1/10.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "DapengFoundThreeViewController.h"

#import "PathHeader.h"
#import "DapengJSONModel.h"
#import "UIImageView+WebCache.h"
#import "DapengHttpRequest.h"
#import "DapengHuaTiTableViewCell.h"
#import "DapengHuaTiConnterViewController.h"
#import "DapengHuaTiTopNeiViewController.h"
#define Swidth [UIScreen mainScreen].bounds.size.width
@interface DapengFoundThreeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong)NSMutableArray * _dataTopArray;
@property (nonatomic ,strong)NSMutableArray * _dataArray;
@property (nonatomic ,strong)UITableView * _tableView;
@end

@implementation DapengFoundThreeViewController
@synthesize _dataArray = _dataArray;
@synthesize _dataTopArray = _dataTopArray;
@synthesize _tableView = _tableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    [self initHttpRequest];
    [self initTopHttpRrquest];
}
- (void)initTopHttpRrquest{
    DapengHttpRequest * request = [[DapengHttpRequest alloc]init];
    [request downloadDataWithUrlString:HT_TOU finished:^(NSData *data) {
       NSDictionary * div = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * array = div[@"result"];
        _dataTopArray = [DapengHutTiTopModel arrayOfModelsFromDictionaries:array error:nil];
        [self createTopView];
    } failed:^(NSString *error) {
        NSLog(@"%@",error);
    }];
}
- (void)initHttpRequest{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    DapengHttpRequest * request = [[DapengHttpRequest alloc]init];
    [request downloadDataWithUrlString:HT_NAME finished:^(NSData *data) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * array = dic[@"result"];
        _dataArray = [DapengHuaTiModel arrayOfModelsFromDictionaries:array error:nil];
        [self createTableView];
        [hud show:YES];
    } failed:^(NSString *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark -- 头部信息
- (void)createTopView{
    UIView * HuaTiTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 960)];
    _tableView.tableHeaderView = HuaTiTop;
    for (int i=0; i<_dataTopArray.count; i++) {
        DapengHutTiTopModel * model = _dataTopArray[i];
        UIImageView * imgV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0+i*320,Swidth, 200)];
        [imgV sd_setImageWithURL:[NSURL URLWithString:model.activity[@"image"]] placeholderImage:nil];
        [HuaTiTop addSubview:imgV];

        UILabel * lib = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imgV.frame)+10, Swidth, 20)];
        lib.text = model.activity[@"title"];
        lib.textAlignment = NSTextAlignmentCenter;
        lib.textColor = [UIColor blackColor];
        lib.font = [UIFont systemFontOfSize:15 weight:3];
        [HuaTiTop addSubview:lib];
        UILabel * lib1 =[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lib.frame), Swidth, 20)];
        lib1.textAlignment = NSTextAlignmentCenter;
        lib1.textColor = [UIColor lightGrayColor];
        lib1.font = [UIFont systemFontOfSize:12 weight:1];
        NSString *str= model.activity[@"startTime"];//时间戳
        NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
        NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM.dd"];
        NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
        
        NSString *str1= model.activity[@"stopTime"];//时间戳
        NSTimeInterval time1=[str1 doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
        NSDate *detaildate1=[NSDate dateWithTimeIntervalSince1970:time1];
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"MM.dd"];
        NSString *currentDateStr1 = [dateFormatter1 stringFromDate: detaildate1];
        
        lib1.text = [NSString stringWithFormat:@"%@-%@ | %@人参与",currentDateStr,currentDateStr1,model.activity[@"activityStats"][@"participator"]];
        [HuaTiTop addSubview:lib1];
        
        
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(Swidth/2-50, CGRectGetMaxY(lib1.frame)+10, 100, 30)];
        btn.tag = 100+i;
        [btn setTitle:@"查看" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:47/255.0 green:132/255.0 blue:261/255.0 alpha:1] forState:UIControlStateNormal];
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [UIColor colorWithRed:47/255.0 green:132/255.0 blue:261/255.0 alpha:1].CGColor;
        [btn addTarget:self action:@selector(btnTopClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 5;
        [HuaTiTop addSubview:btn];
    }
    
}
- (void)btnTopClick:(UIButton *)btn{

    DapengHutTiTopModel * model = _dataTopArray[btn.tag-100];
    DapengHuaTiTopNeiViewController * topNei = [[DapengHuaTiTopNeiViewController alloc]init];
    topNei.param = model.activity[@"activityId"];
    topNei.bgImage = model.activity[@"backgroundImage"];
    topNei.summary = model.activity[@"summary"];
    topNei.title = model.activity[@"title"];
    [self.navigationController pushViewController:topNei animated:YES];
}

#pragma mark -- 信息
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    _tableView.bounces = YES;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [self createTopView];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPat{
    static NSString * cellId = @"CellID";
    
    DapengHuaTiTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"df"];
    if (!cell) {
        cell = [[DapengHuaTiTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    if (_dataArray.count>1) {
        
        DapengHuaTiModel * model = _dataArray[indexPat.row];
        cell.model = model;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 550;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    DapengHuaTiConnterViewController * connter =[[DapengHuaTiConnterViewController alloc]init];
    DapengHuaTiModel * model = _dataArray[indexPath.row];
    connter.model = model;
    connter.hidesBottomBarWhenPushed=YES;
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
