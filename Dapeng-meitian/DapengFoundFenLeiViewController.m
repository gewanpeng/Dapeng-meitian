//
//  DapengFoundFenLeiViewController.m
//  Dapeng-meitian
//
//  Created by qianfeng on 15/12/27.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//
#import "PathHeader.h"
#import "DapengFoundFenLeiViewController.h"
#import "UIImageView+WebCache.h"
#import "DapengHttpRequest.h"
#import "DapengJSONModel.h"
#import "DapengSelectView.h"
#import "DapengTableViewCell.h"
#import "DapengFoundConnterViewController.h"
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
@interface DapengFoundFenLeiViewController ()<UIScrollViewDelegate ,DapengSelectViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    int biao;
    int ide;
}
@property (nonatomic ,strong)NSMutableArray * dataArray;
@property (nonatomic ,strong)NSMutableArray * dataBiaoArray;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *showLabel;

@property (nonatomic ,strong) DapengSelectView * selectView;

@property (nonatomic ,strong)UITableView * tableView;//整体的table

@end

@implementation DapengFoundFenLeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    biao = 10;
    ide = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [NSMutableArray array];
    _dataBiaoArray = [NSMutableArray array];
    [self initBiaoTiRequest];
    
    

}
- (void)btnClick:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)initTopRequest{
    DapengHttpRequest * request = [[DapengHttpRequest alloc]init];
    [request downloadDataWithUrlString:[NSString stringWithFormat:TJ_FENLEI_Name,ide] finished:^(NSData *data) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * array = dic[@"result"];
        _dataArray = [DapengJSONModel arrayOfModelsFromDictionaries:array error:nil];
        
        [self createTableView];
//        [self initBiaoTiRequest];//解析标题
        
    } failed:^(NSString *error) {
        NSLog(@"请求错误");
        NSLog(@"%@",error);
    }];
}
- (void)initBiaoTiRequest{
    DapengHttpRequest * request = [[DapengHttpRequest alloc]init];
    [request downloadDataWithUrlString:[NSString stringWithFormat:TJ_BIAOTI,biao] finished:^(NSData *data) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * array = dic[@"result"];
        _dataBiaoArray = [DapengBiaoModel arrayOfModelsFromDictionaries:array error:nil];
        [self createScroll];
        [self initTopRequest];
    } failed:^(NSString *error) {
        NSLog(@"请求错误");
        NSLog(@"%@",error);
    }];
}
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 160, self.view.bounds.size.width, self.view.bounds.size.height-49-160) style:UITableViewStylePlain];
    _tableView.bounces = YES;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[DapengTableViewCell class] forCellReuseIdentifier:@"cell"];
//    [self createScroll];

}
- (void)createScroll{
//    NSLog(@"%lu",(unsigned long)_dataBiaoArray.count);
    NSMutableArray * imageArray = [NSMutableArray array];
    NSMutableArray * colorArray = [NSMutableArray array];
    for (int i=0; i<_dataBiaoArray.count; i++) {
        DapengBiaoModel * biaoModel = _dataBiaoArray[i];

        UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:biaoModel.largeIcon]]];
        [imageArray addObject:image];
        NSString * col = biaoModel.color;
        [colorArray addObject:col];
        
    }
    _selectView = [[DapengSelectView alloc]initViewWithImageArray:imageArray andColor:colorArray];
    _selectView.delegate = self;
    [self.view addSubview:_selectView];
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 30, 30)];
    [ btn setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhuidingbu"] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_selectView addSubview:btn];

//    _tableView.tableHeaderView = _selectView;
}
- (void)itemSelected:(NSInteger)index{
    
    ide = (int)index+1;
//    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    DapengHttpRequest * request = [[DapengHttpRequest alloc]init];
    [request downloadDataWithUrlString:[NSString stringWithFormat:TJ_FENLEI_Name,ide] finished:^(NSData *data) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * array = dic[@"result"];
        _dataArray = [DapengJSONModel arrayOfModelsFromDictionaries:array error:nil];
        [self createTableView];
//        [hud show:YES];
    } failed:^(NSString *error) {
        NSLog(@"请求错误");
        NSLog(@"%@",error);
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPat{
    DapengTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPat];
    
    if (_dataArray.count>1) {
        
        DapengJSONModel * model = _dataArray[indexPat.row];

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
    DapengJSONModel * model = _dataArray[indexPath.row];
    connter.model = model;
    connter.isFen = @"Cell";
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:connter animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}










//- (void)createScroll{
//   
//    
//    UIScrollView * scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 200)];
//    [self.view addSubview:scroll];
//
//    for (int i = 0; i<_dataBiaoArray.count; i++) {
//        DapengBiaoModel * model = _dataBiaoArray[i];
//        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0+i*Width, 0, Width, 200)];
//        imageView.userInteractionEnabled = YES;
//        [imageView sd_setImageWithURL:[NSURL URLWithString:model.image]];
//        [scroll addSubview:imageView];
//    }
//    scroll.contentSize = CGSizeMake(self.dataBiaoArray.count*Width, 200);
//    scroll.contentOffset = CGPointMake((self.fenlei.intValue-1)*Width, 0);
//    scroll.pagingEnabled = YES;
//    scroll.alwaysBounceHorizontal = NO;
//    scroll.alwaysBounceVertical = NO;
//    scroll.delegate = self;
//    scroll.bounces = NO;
//    
//}
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    NSInteger current = scrollView.contentOffset.x/Width;
//    
////    self.fenlei >current ? self.fenlei : current;
//    
////    connter = scrollView.contentOffset.x/Width;
//    
//    self.connest = [NSString stringWithFormat:@"%ld",self.fenlei.intValue > current ? self.fenlei.intValue : current];
//
//    NSLog(@"%@",self.connest);
//    [self createTabbelScroll];
//}
//- (void)createTabbelScroll{
//    
//    UIScrollView * scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 400, self.view.frame.size.width, 200)];
//    [self.view addSubview:scroll];
//    
//    for (int i = 0; i< 5 ; i++) {
//        
//        UILabel * lib = [[UILabel alloc]initWithFrame:CGRectMake(i*Width,0, Width, 200)];
//        lib.text = [NSString stringWithFormat:@"%d",i+1];
//        lib.layer.borderWidth = 1;
//        lib.layer.borderColor = [UIColor redColor].CGColor;
//        [scroll addSubview:lib];
//        
//    }
//    NSLog(@"%d",self.connest.intValue);
//    scroll.contentSize = CGSizeMake(self.dataBiaoArray.count*Width, 200);
//    scroll.contentOffset = CGPointMake((self.connest.intValue-1)*Width, 0);
//    scroll.pagingEnabled = YES;
//    scroll.alwaysBounceHorizontal = YES;
//    scroll.alwaysBounceVertical = NO;
//    scroll.delegate = self;
//    scroll.bounces = NO;
//
//    
//    
//    
//    
//}
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
