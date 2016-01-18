//
//  DapengSpecialHuodongTableViewCell.m
//  Dapeng-meitian
//
//  Created by qianfeng on 15/12/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DapengSpecialHuodongTableViewCell.h"
#import "PathHeader.h"
#import "DapengJSONModel.h"
#import "DapengHttpRequest.h"
#import "UIImageView+WebCache.h"
#import "DapengHuoDongConnterViewController.h"

@implementation DapengSpecialHuodongTableViewCell
{
    int page;
}
@synthesize dataArray = _dataArray;
@synthesize imageView = _imageView;
@synthesize lib = _lib;
@synthesize title = _title;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        page = 0;
        [self initHttpRequest];
    }
    return self;
}
- (void)initHttpRequest{
    DapengHttpRequest * request = [[DapengHttpRequest alloc]init];
    [request downloadDataWithUrlString:[NSString stringWithFormat:ZL_HOUDONG,page] finished:^(NSData *data) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * array = dic[@"result"];
        _dataArray = [DapengZhuanLanHuoDongModel arrayOfModelsFromDictionaries:array error:nil];
        [self createCell];
    } failed:^(NSString *error) {
        NSLog(@"%@",error);
    }];
}
- (void)createCell{
    
    DapengZhuanLanHuoDongModel * model = _dataArray[0];
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(10, 10, self.frame.size.width-40, 100)];
    view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view];

    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width-20, 100)];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.backgroundImage]];
    [view addSubview:_imageView];
    _lib = [[UILabel alloc]initWithFrame:CGRectMake(20,20 , 80, 30)];
    _lib.textAlignment = NSTextAlignmentCenter;
    _lib.font = [UIFont systemFontOfSize:18];
    _lib.textColor = [UIColor redColor];
    _lib.text = model.title;
    [self.contentView addSubview:_lib];
    _title = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_lib.frame)+5, 200, 30)];
    _title.font = [UIFont systemFontOfSize:11];
    _title.textColor = [UIColor lightGrayColor];
    _title.numberOfLines = 2;
    _title.text = model.introduction;
    [self.contentView addSubview:_title];
//    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, self.frame.size.width-40, 100)];
//    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:btn];
    
}
//- (void)btnClick:(UIButton *)btn{
//    DapengHuoDongConnterViewController * huodong = [[DapengHuoDongConnterViewController alloc]init];
//    [self   ]
//}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
