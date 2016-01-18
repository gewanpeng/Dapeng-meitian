//
//  DapengFoundConnterViewController.m
//  Dapeng-meitian
//
//  Created by qianfeng on 15/12/27.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//
#import "PathHeader.h"
#import "DapengFoundConnterViewController.h"
#import "UIImageView+WebCache.h"
@interface DapengFoundConnterViewController ()<UIWebViewDelegate>
@property (nonatomic ,strong)UIImageView * imageView;

@property (nonatomic ,strong)UIWebView * webView;

@end

@implementation DapengFoundConnterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = NO;
//    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 30, 30)];
//    [btn setTitle:@"dd" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
    [self setUI];
    
}

- (void)setUI{
    if ([self.isFen isEqualToString:@"tupian"]) {
        DapengJSONArrayModel * arrayModel = self.model.image[0];
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        [_imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:arrayModel.url]]];
        [self.view addSubview:_imageView];
        
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageView.frame), self.view.frame.size.width, self.view.frame.size.height)];
    }else{
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageView.frame), self.view.frame.size.width, self.view.frame.size.height)];
    }
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView.delegate = self;
    NSString * string = [NSString stringWithFormat:NEIRONG,self.model.article[@"articleId"]];
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
