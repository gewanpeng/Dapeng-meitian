//
//  DapengHuaTiTopNeiViewController.m
//  Dapeng-meitian
//
//  Created by qianfeng on 16/1/13.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "DapengHuaTiTopNeiViewController.h"
#import "PathHeader.h"
#import "DapengJSONModel.h"
#import "UIImageView+WebCache.h"
#import "DapengHttpRequest.h"
#import "DapengHuaTiTableViewCell.h"
#import "DapengHuaTiConnterViewController.h"
@interface DapengHuaTiTopNeiViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong)NSMutableArray * _dataTopArray;
@property (nonatomic ,strong)NSMutableArray * _dataArray;
@property (nonatomic ,strong)UITableView * _tableView;

@end

@implementation DapengHuaTiTopNeiViewController
@synthesize _dataArray = _dataArray;
@synthesize _dataTopArray = _dataTopArray;
@synthesize _tableView = _tableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    [self initHttpRequest];
}

- (void)initHttpRequest{
    DapengHttpRequest * request = [[DapengHttpRequest alloc]init];
    [request downloadDataWithUrlString:[NSString stringWithFormat:HT_TOU_Connter,self.param] finished:^(NSData *data) {
        NSDictionary * div = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * array = div[@"result"];
        _dataArray = [DapengHuaTiModel arrayOfModelsFromDictionaries:array error:nil];
        [self createTableView];
    } failed:^(NSString *error) {
        NSLog(@"%@",error);
    }];

}
- (void)createTopView{
    UIView * top = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    _tableView.tableHeaderView = top;
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    [img sd_setImageWithURL:[NSURL URLWithString:self.bgImage] placeholderImage:nil];
    [top addSubview:img];
    UILabel * lib = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, self.view.frame.size.width-20, 30)];
    lib.text = self.title;
    lib.font = [UIFont systemFontOfSize:15 weight:2];
    lib.textColor = [UIColor whiteColor];
    [top addSubview:lib];
    UILabel * lib1 = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(lib.frame)+5, 200, 20)];
    lib1.text = self.summary;
    lib1.textColor = [UIColor whiteColor];
    lib1.font = [UIFont systemFontOfSize:12 weight:2];
    [top addSubview:lib1];
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 30, 30)];
    [ btn setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhuidingbu"] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [top addSubview:btn];
}
- (void)btnClick:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

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
