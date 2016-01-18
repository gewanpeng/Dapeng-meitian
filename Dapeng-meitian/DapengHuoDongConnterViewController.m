//
//  DapengHuoDongConnterViewController.m
//  Dapeng-meitian
//
//  Created by qianfeng on 15/12/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DapengHuoDongConnterViewController.h"
#import "PathHeader.h"
#import "DapengHttpRequest.h"
#import "DapengJSONModel.h"
#import "UIImageView+WebCache.h"
@interface DapengHuoDongConnterViewController ()<UIWebViewDelegate>
{
    int page;
}
@property (nonatomic ,strong)NSMutableArray * dataArray;
@property (nonatomic ,strong)NSMutableArray * dataNeiArray;

@property (nonatomic ,strong)UIImageView * imageView;

@property (nonatomic ,strong)UIWebView * webView;
@end

@implementation DapengHuoDongConnterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataNeiArray = [NSMutableArray array];
    _dataArray = [NSMutableArray array];
    page = 0;
    [self initHttpRequest];
}
- (void)initHttpRequest{
    DapengHttpRequest * request = [[DapengHttpRequest alloc]init];
    [request downloadDataWithUrlString:[NSString stringWithFormat:ZL_HOUDONG,page] finished:^(NSData *data) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * array = dic[@"result"];
//        NSLog(@"%@",array);
        _dataArray = [DapengZhuanLanHuoDongModel arrayOfModelsFromDictionaries:array error:nil];
        [self initHttpRequestNei];
    } failed:^(NSString *error) {
        NSLog(@"%@",error);
    }];
}
- (void)initHttpRequestNei{
    DapengZhuanLanHuoDongModel * model = _dataArray[0];

    NSArray * array = [model.url componentsSeparatedByString:@"//"];
//    NSLog(@"%@",array[1]);
    NSString * str = array[1];
    DapengHttpRequest * request1 = [[DapengHttpRequest alloc]init];
    [request1 downloadDataWithUrlString:[NSString stringWithFormat:ZL_HOUDONG_NEI,str] finished:^(NSData *data) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * array1 =@[dic[@"result"]];
        
        _dataNeiArray = [DapengZhuanLanHuoDongNeiModel arrayOfModelsFromDictionaries:array1 error:nil];

        
        
        
//        NSLog(@"%@",array1);
//        NSLog(@"%@",_dataNeiArray);
        [self setUI];
    } failed:^(NSString *error) {
        NSLog(@"%@",error);
    }];
    
}
- (void)setUI{
    DapengZhuanLanHuoDongNeiModel * model = _dataNeiArray[0];
    DapengJSONArrayModel * modelarr = model.image[1];
//    NSLog(@"%@",model.article[@"url"]);
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:modelarr.url]];
    [self.view addSubview:_imageView];
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageView.frame), self.view.frame.size.width, self.view.frame.size.height-200-49)];
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView.delegate = self;
    NSString * string = [NSString stringWithFormat:@"%@",model.article[@"url"]];
    NSURL * url = [NSURL URLWithString:string];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];

    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 30, 30)];
    [ btn setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhuidingbu"] forState:UIControlStateNormal];

    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}
- (void)btnClick:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"%@",error.localizedDescription);
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    UIApplication * app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    UIApplication * app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    
    
    return YES;
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
