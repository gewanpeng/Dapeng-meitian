//
//  DapengHuaTiConnterViewController.m
//  Dapeng-meitian
//
//  Created by qianfeng on 16/1/11.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "DapengHuaTiConnterViewController.h"
#import "RGBColor.h"
#import "UIImageView+WebCache.h"
@interface DapengHuaTiConnterViewController ()
{
    UIImageView * img;
}
@end

@implementation DapengHuaTiConnterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView * top = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    [self.view addSubview:top];
    UILabel * lib = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-50, 30, 100, 20)];
    lib.textAlignment = NSTextAlignmentCenter;
    lib.textColor = [UIColor blackColor];
    lib.text = [NSString stringWithFormat:@"%@的贴文",self.model.user[@"loginNickname"]];
    lib.font = [UIFont systemFontOfSize:12 weight:2];
    [top addSubview:lib];
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 30, 30)];
    [ btn setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhuidingbu"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [top addSubview:btn];
    
    [self setUI];
}
- (void)btnClick:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setUI{
    DapengHuaTiModel * model = self.model;
    NSArray * arr =model.post[@"media"];
    
        img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 300)];
        [img sd_setImageWithURL:[NSURL URLWithString:arr[1][@"originalUrl"]] placeholderImage:nil];
        [self.view addSubview:img];
    UILabel * lib = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(img.frame), self.view.frame.size.width-40, 60)];
    lib.text =model.post[@"media"][0][@"value"];
    lib.numberOfLines = 0;
    lib.lineBreakMode = NSLineBreakByCharWrapping;
    lib.textColor = [UIColor blackColor];
    lib.font = [UIFont systemFontOfSize:13 weight:1];
    [self.view addSubview:lib];
    UILabel * lib1 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(lib.frame)+10, 60, 30)];
    lib1.textColor = [UIColor lightGrayColor];
    lib1.font = [UIFont systemFontOfSize:12 weight:1];
    lib1.text =@"每天话题:";
    [self.view addSubview:lib1];
    UILabel * lib2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lib1.frame), CGRectGetMaxY(lib.frame)+10, 180, 30)];
    lib2.font = [UIFont systemFontOfSize:12 weight:1];
    lib2.text = [NSString stringWithFormat:@"#%@#",model.activity[@"title"]];
    lib2.textColor = [RGBColor colorWithHexString:model.activity[@"color"]];
    [self.view addSubview:lib2];
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
