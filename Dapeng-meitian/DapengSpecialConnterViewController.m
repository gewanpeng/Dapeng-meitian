//
//  DapengSpecialConnterViewController.m
//  Dapeng-meitian
//
//  Created by qianfeng on 15/12/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DapengSpecialConnterViewController.h"
#import "PathHeader.h"
#import "DapengHttpRequest.h"
#import "DapengJSONModel.h"
#import "UIImageView+WebCache.h"
#import "DapengTableViewCell.h"
#import "DapengFoundConnterViewController.h"



@interface DapengSpecialConnterViewController ()<NSURLConnectionDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)NSMutableArray * _dataTopArray; //头部
@property (nonatomic ,strong)NSMutableArray * _dataNameArray;//行信息
@property (nonatomic ,strong)UIImageView * imageTopView; //头部视图
@property (nonatomic ,strong)UIView * topView;//上半部分的视图


@property (nonatomic ,strong)UITableView * tableView;//整体的table
@end

@implementation DapengSpecialConnterViewController
@synthesize _dataTopArray = _dataTopArray;
@synthesize _dataNameArray = _dataNameArray;
@synthesize tableView = _tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataTopArray = [NSMutableArray array];
    _dataNameArray = [NSMutableArray array];
    self.navigationController.navigationBarHidden = YES;
    
    
    [self initHttpRequest]; //解析内容
}
- (void)btnClick:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)initHttpRequest{
    DapengHttpRequest * request = [[DapengHttpRequest alloc]init];
    [request downloadDataWithUrlString:[NSString stringWithFormat:ZL_NEW_NEI,self.str] finished:^(NSData *data) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * array = dic[@"result"];
        _dataNameArray = [DapengJSONModel arrayOfModelsFromDictionaries:array error:nil];
       
        [self createTableView];
        
//        [self initBiaoTiRequest];//解析标题
//        NSLog(@"%@",_dataNameArray);
    } failed:^(NSString *error) {
        NSLog(@"请求错误");
        NSLog(@"%@",error);
    }];
}
#pragma mark -- 头部
- (void)setTopTableView{
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
//    _topView.backgroundColor = [UIColor redColor];
    _tableView.tableHeaderView = _topView;
    
    DapengJSONModel * model = self.arr;

    DapengJSONArrayModel * arr = model.image[0];
    _imageTopView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    [_imageTopView sd_setImageWithURL:[NSURL URLWithString:model.article[@"author"][@"image"]]];
//
////    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(topClick:)];
////    _imageTopView.userInteractionEnabled = YES;
////    [_imageTopView addGestureRecognizer:tap];
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 30, 30)];
    [ btn setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhuidingbu"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [_topView addSubview:_imageTopView];
//
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, _topView.frame.size.height-60, 40, 40)];
    imageView.layer.cornerRadius = 20;
    imageView.layer.masksToBounds = YES;
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.article[@"author"][@"avatar"]]];
    [_imageTopView addSubview:imageView];
    

    UILabel * name = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, _topView.frame.size.height-60, 100, 15)];
    name.textColor = [UIColor whiteColor];
    name.textAlignment = NSTextAlignmentLeft;
    name.text = model.article[@"author"][@"name"];
    name.font = [UIFont systemFontOfSize:12];
    [_imageTopView addSubview:name];
    UILabel * lib = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, CGRectGetMaxY(name.frame)+5, 100, 15)];
    lib.textColor = [UIColor whiteColor];
    lib.textAlignment = NSTextAlignmentLeft;
    lib.text = [NSString stringWithFormat:@"微信:%@",model.article[@"author"][@"contactId"]];
    lib.font = [UIFont systemFontOfSize:12];
    [_imageTopView addSubview:lib];
   
    UILabel * lib1 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(name.frame)+5, 50, 20)];
    lib1.textColor = [UIColor whiteColor];
    lib1.textAlignment = NSTextAlignmentCenter;
//    lib1.text = model.author[@"name"];
    lib1.font = [UIFont systemFontOfSize:12];
    [_imageTopView addSubview:lib1];
    
}
#pragma mark -- 行信息
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-49) style:UITableViewStylePlain];
    _tableView.bounces = YES;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [self setTopTableView];
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
