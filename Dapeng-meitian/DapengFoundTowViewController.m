//
//  DapengFoundTowViewController.m
//  Dapeng-meitian
//
//  Created by qianfeng on 16/1/9.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "DapengFoundTowViewController.h"

#import "PathHeader.h"
#import "DapengHttpRequest.h"
#import "DapengJSONModel.h"
#import "UIImageView+WebCache.h"
#import "DapengTableViewCell.h"
#import "DapengFoundFenLeiViewController.h"
#import "DapengFoundConnterViewController.h"

@interface DapengFoundTowViewController ()<NSURLConnectionDelegate,UITableViewDataSource,UITableViewDelegate>
{
    int top;
    int biao;
    int param;
    BOOL isRreshing;
}
@property (nonatomic ,strong)NSMutableData * receiveData;
@property (nonatomic ,strong)NSMutableArray * _dataTopArray; //头部
@property (nonatomic ,strong)NSMutableArray * _dataBiaoArray;//标题
@property (nonatomic ,strong)NSMutableArray * _dataNameArray;//行信息

@property (nonatomic ,strong)UIView * topView;//上半部分的视图

@property (nonatomic ,strong)UIImageView * imageTopView; //头部视图

@property (nonatomic ,strong)UITableView * tableView;//整体的table
@end

@implementation DapengFoundTowViewController
@synthesize _dataTopArray = _dataTopArray;
@synthesize _dataBiaoArray = _dataBiaoArray;
@synthesize _dataNameArray = _dataNameArray;
@synthesize tableView = _tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    top =1;
    biao = 10;
    param = 1;
    _dataTopArray = [NSMutableArray array];
    _dataBiaoArray = [NSMutableArray array];
    _dataNameArray = [NSMutableArray array];
    self.navigationController.navigationBarHidden = YES;
    [self initHttpRequest]; //解析内容
}
- (void)initTopRequest{
    
    
    DapengHttpRequest * request = [[DapengHttpRequest alloc]init];
    [request downloadDataWithUrlString:[NSString stringWithFormat:TJ_BIAOTOU,top] finished:^(NSData *data) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * array = dic[@"result"];
        _dataTopArray = [DapengJSONModel arrayOfModelsFromDictionaries:array error:nil];
        
        [self setTopTableView];
        [self initBiaoTiRequest];//解析标题
        
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
        [self setBiaoTiTableView];
    } failed:^(NSString *error) {
        NSLog(@"请求错误");
        NSLog(@"%@",error);
    }];
}
- (void)initHttpRequest{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    DapengHttpRequest * request = [[DapengHttpRequest alloc]init];
    [request downloadDataWithUrlString:[NSString stringWithFormat:TJ_NAME,param] finished:^(NSData *data) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * array = dic[@"result"];
        _dataNameArray = [DapengJSONModel arrayOfModelsFromDictionaries:array error:nil];
        [self initTopRequest];   //解析头部
        [self createTableView];
//        [self coreateHeadrefreshView];
//        [self coreateFooterfreshView];
        [hud show:YES];
    } failed:^(NSString *error) {
        NSLog(@"请求错误");
        NSLog(@"%@",error);
    }];
    
}
#pragma mark -- 头部
- (void)setTopTableView{
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 275)];
    _tableView.tableHeaderView = _topView;
    
    DapengJSONModel * model = _dataTopArray[0];
    //    NSLog(@"%@",model.category[@"categoryGroup"][@"name"]);
    DapengJSONArrayModel * arr = model.image[0];
    _imageTopView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    [_imageTopView sd_setImageWithURL:[NSURL URLWithString:arr.url]];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(topClick:)];
    _imageTopView.userInteractionEnabled = YES;
    [_imageTopView addGestureRecognizer:tap];
    [_topView addSubview:_imageTopView];
    
    UILabel * name = [[UILabel alloc]initWithFrame:CGRectMake(0, 135, 200, 25)];
    name.textColor = [UIColor whiteColor];
    name.textAlignment = NSTextAlignmentCenter;
    name.text = model.article[@"title"];
    name.font = [UIFont systemFontOfSize:15];
    [_imageTopView addSubview:name];
    UILabel * lib = [[UILabel alloc]initWithFrame:CGRectMake(4, CGRectGetMaxY(name.frame)+5, 40, 20)];
    lib.textColor = [UIColor whiteColor];
    lib.textAlignment = NSTextAlignmentCenter;
    lib.text = model.category[@"categoryGroup"][@"name"];
    lib.font = [UIFont systemFontOfSize:12];
    [_imageTopView addSubview:lib];
    UILabel * libShu = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lib.frame), CGRectGetMaxY(name.frame)+10, 1, 12)];
    libShu.layer.borderWidth = 1;
    libShu.layer.borderColor = [UIColor whiteColor].CGColor;
    [_imageTopView addSubview:libShu];
    UILabel * lib1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(libShu.frame), CGRectGetMaxY(name.frame)+5, 50, 20)];
    lib1.textColor = [UIColor whiteColor];
    lib1.textAlignment = NSTextAlignmentCenter;
    lib1.text = model.author[@"name"];
    lib1.font = [UIFont systemFontOfSize:12];
    [_imageTopView addSubview:lib1];
    
}
- (void)topClick:(UITapGestureRecognizer *)tap{
    DapengFoundConnterViewController * connter = [[DapengFoundConnterViewController alloc]init];
    DapengJSONModel * model = _dataTopArray[0];
    connter.model = model;
    connter.isFen = @"tupian";
    connter.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:connter animated:YES];
//    self.hidesBottomBarWhenPushed=NO;
    
    
}

#pragma mark -- 标题
- (void)setBiaoTiTableView{
    //#if 1
    for (int i =0; i<_dataBiaoArray.count; i++) {
        DapengBiaoModel * biao = _dataBiaoArray[i];
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(26+(i*70), CGRectGetMaxY(_imageTopView.frame)+10, 40, 60)];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:btn];
        UIImageView  * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:biao.image]];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 20;
        [btn addSubview:imageView];
        UIImageView * imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [imageView1 sd_setImageWithURL:[NSURL URLWithString:biao.icon]];
        [imageView addSubview:imageView1];
        UILabel * lib = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), 40, 20)];
        lib.text = biao.name;
        lib.textColor = [UIColor lightGrayColor];
        lib.textAlignment = NSTextAlignmentCenter;
        lib.font = [UIFont systemFontOfSize:12];
        [btn addSubview:lib];
    }
    //#else
    //    UIImageView * view = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageTopView.frame)+10, self.view.frame.size.width, 60)];
    ////    view.backgroundColor = [UIColor whiteColor];
    //    view.image = [UIImage imageNamed:@"NNWFM3T"];
    //    [_topView addSubview:view];
    //#endif
}
- (void)btnClick:(UIButton *)btn{
    DapengBiaoModel *  biao = _dataBiaoArray[btn.tag - 100];
    
    DapengFoundFenLeiViewController * fenlei = [[DapengFoundFenLeiViewController alloc]init];
    
    fenlei.fenlei = [NSString stringWithFormat:@"%ld",(btn.tag-100)+1];
    fenlei.connest = [NSString stringWithFormat:@"%ld",(btn.tag-100)+1];
    [self.navigationController pushViewController:fenlei animated:YES];
    
    
    
}


#pragma mark -- 行信息
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
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
    connter.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:connter animated:YES];
//    self.hidesBottomBarWhenPushed=NO;
}

#pragma mark --------  上拉 下拉 刷新
//- (void)coreateHeadrefreshView{
//    if (self.header == nil) {
//        self.header = [[EGORefreshTableHeaderView alloc]initWithFrame:CGRectMake(0, -200, self.view.frame.size.width, 200)];
//        self.header.delegate = self;
//        [_tableView addSubview:self.header];
//    }
//    [self.header refreshLastUpdatedDate];
//}
//- (void)coreateFooterfreshView{
//    if ((self.footer ==nil)) {
//        self.footer = [[EGORefreshTableFooterView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
//        self.footer.delegate = self;
//        //        [_tableView addSubview:self.footerView];
//        _tableView.tableFooterView = self.footer;
//    }
//    [self.footer refreshLastUpdatedDate];
//}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [self.header egoRefreshScrollViewDidScroll:scrollView];
//    [self.footer egoRefreshScrollViewDidScroll:scrollView];
//}
//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
//    //让头视图 结束 tableview 的拖拽
//    //scrollView 就是当前的 tableview
//    [self.header egoRefreshScrollViewDidEndDragging:scrollView];
//    [self.footer egoRefreshScrollViewDidEndDragging:scrollView];
//}
//-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
//{
//    isRreshing = YES;
//    //延迟2.5秒 执行downloadReques 这个方法 开始刷新下一页的数据
//    [self performSelector:@selector(downloadReques) withObject:nil afterDelay:2.5];
//}
//- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos{
//    isRreshing = YES;
//    [self performSelector:@selector(downloadReques1) withObject:nil afterDelay:2.5];
//}
//- (void)downloadReques{
//    param = 1;
//    if (_dataNameArray) {
//        [_dataNameArray removeAllObjects];
//    }
//    [self initHttpRequest];
//    isRreshing = NO;
//    [self.header egoRefreshScrollViewDataSourceDidFinishedLoading:_tableView];
//    [_tableView reloadData];
//}
//通过这个方法 返回刷新时候的当前时间
//-(NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view
//{
//    return [NSDate date];
//}
//- (void)downloadReques1{
//    param ++;
//    [self initHttpRequest];
//    isRreshing = NO;
//    [self.footer egoRefreshScrollViewDataSourceDidFinishedLoading:_tableView];
//    [_tableView reloadData];//重新加载
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
