//
//  DapengHuaTiTableViewCell.m
//  Dapeng-meitian
//
//  Created by qianfeng on 16/1/11.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "DapengHuaTiTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "RGBColor.h"

#define SWidth [UIScreen mainScreen].bounds.size.width
#define SHeight [UIScreen mainScreen].bounds.size.height
@implementation DapengHuaTiTableViewCell
{
    UIImageView * _TouXiangImage;
    UILabel * _Name;
    UILabel * _Time;
    UILabel * _Fenlei;
    UIImageView * _imageView;
    UILabel * _connter;
    UIButton * btn;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}
- (void)createCell{
}
- (void)setModel:(DapengHuaTiModel *)model{
        _TouXiangImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 30, 30)];
        _TouXiangImage.layer.masksToBounds = YES;
        _TouXiangImage.layer.cornerRadius = 15;
        [_TouXiangImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:model.user[@"loginAvatar"]]] placeholderImage:nil];
        [self.contentView addSubview:_TouXiangImage];
        _Name = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_TouXiangImage.frame)+10, 20, SWidth-100, 20)];
        _Name.font =[UIFont systemFontOfSize:12 weight:3];
        _Name.textColor = [UIColor blackColor];
        _Name.textAlignment = NSTextAlignmentLeft;
        _Name.text = [NSString stringWithFormat:model.user[@"loginNickname"]];
        [self.contentView addSubview:_Name];
        _Time = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_TouXiangImage.frame)+10, CGRectGetMaxY(_Name.frame)+5, SWidth/2-40, 10)];
        _Time.textColor = [UIColor lightGrayColor];
        _Time.textAlignment = NSTextAlignmentLeft;
        _Time.font = [UIFont systemFontOfSize:10 weight:1];
    
        NSString *str= model.activity[@"createdTime"];//时间戳
        NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
        NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd HH:mm"];
        NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
        _Time.text = currentDateStr;
        [self.contentView addSubview:_Time];
        _Fenlei = [[UILabel alloc]initWithFrame:CGRectMake(SWidth/2 +40, CGRectGetMaxY(_Name.frame)+5, SWidth/2-50, 10)];
        _Fenlei.textAlignment = NSTextAlignmentRight;
        _Fenlei.font = [UIFont systemFontOfSize:10 weight:1];
        _Fenlei.text = [NSString stringWithFormat:@"#%@#",model.activity[@"title"]];
        _Fenlei.textColor = [RGBColor colorWithHexString:model.activity[@"color"]];
        [self.contentView addSubview:_Fenlei];
    
 NSArray * arr = model.post[@"media"];
    NSArray * arr1 = model.voteUsers;
//    NSLog(@"%@",arr1);
    NSUInteger  Users = arr1.count;
//    NSLog(@"%ld",arr1.count);
    if (arr.count > 0) {
        if (arr.count==1) {
            if ([arr[0][@"mimeType"] isEqualToString:@"text/plain"]) {
                _connter = [[UILabel alloc]init];
                _connter.numberOfLines = 0;
                _connter.lineBreakMode = NSLineBreakByCharWrapping;
                _connter.textColor = [UIColor blackColor];
                _connter.font = [UIFont systemFontOfSize:14 weight:5];
                _connter.frame = CGRectMake(20, CGRectGetMaxY(_TouXiangImage.frame)+20, SWidth-40, 40);
                _connter.text = arr[0][@"value"];
                [self.contentView addSubview:_connter];
                NSArray * array = @[@"评论",@"已赞",@"分享"];
                for (int i=0; i<array.count; i++) {
                    btn  = [[UIButton alloc]initWithFrame:CGRectMake(20 + i* (SWidth/4+30) , CGRectGetMaxY(_connter.frame)+10, SWidth/4, 30)];
                    if ([array[i] isEqualToString:@"已赞"]) {
                        [btn setTitle:[NSString stringWithFormat:@"%@%lu",array[i],(unsigned long)Users] forState:UIControlStateNormal];
                    }else{
                        [btn setTitle:array[i] forState:UIControlStateNormal];
                    }
                    
                    
                    
                    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                    btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
                    btn.layer.borderWidth = 1;
                    btn.layer.cornerRadius = 5;
                    btn.titleLabel.font = [UIFont systemFontOfSize:12 weight:2];
                    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                    btn.tag = 100+i;
                    [self.contentView addSubview:btn];
                }

            }else if ([arr[0][@"mimeType"] isEqualToString:@"image/jpeg"]){
                _imageView = [[UIImageView alloc]init];
                _imageView.frame = CGRectMake(0, CGRectGetMaxY(_TouXiangImage.frame)+20, SWidth, 300);
                [_imageView sd_setImageWithURL:[NSURL URLWithString:arr[0][@"originalUrl"]] placeholderImage:nil];
                [self.contentView addSubview:_imageView];
                
                NSArray * array = @[@"评论",@"已赞",@"分享"];
                for (int i=0; i<array.count; i++) {
                    btn  = [[UIButton alloc]initWithFrame:CGRectMake(20+ i* (SWidth/4+30), CGRectGetMaxY(_imageView.frame)+10, SWidth/4, 30)];
                    if ([array[i] isEqualToString:@"已赞"]) {
                        [btn setTitle:[NSString stringWithFormat:@"%@%lu",array[i],(unsigned long)Users] forState:UIControlStateNormal];
                    }else{
                        [btn setTitle:array[i] forState:UIControlStateNormal];
                    }

                    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                    btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
                    btn.layer.borderWidth = 1;
                    btn.layer.cornerRadius = 5;
                    btn.titleLabel.font = [UIFont systemFontOfSize:12 weight:2];
                    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                    btn.tag = 100+i;
                    [self.contentView addSubview:btn];
                }

            }
        }else if (arr.count>=2){
           
            _imageView = [[UIImageView alloc]init];
            _imageView.frame = CGRectMake(0, CGRectGetMaxY(_TouXiangImage.frame)+20, SWidth, 300);
            [_imageView sd_setImageWithURL:[NSURL URLWithString:arr[1][@"originalUrl"]] placeholderImage:nil];
            [self.contentView addSubview:_imageView];
            _connter = [[UILabel alloc]init];
            _connter.numberOfLines = 0;
            _connter.lineBreakMode = NSLineBreakByCharWrapping;
            _connter.textColor = [UIColor blackColor];
            _connter.font = [UIFont systemFontOfSize:14 weight:5];
            _connter.frame = CGRectMake(20, CGRectGetMaxY(_imageView.frame)+20, SWidth-40, 40);
            _connter.text = arr[0][@"value"];
            [self.contentView addSubview:_connter];
            
            NSArray * array = @[@"评论",@"已赞",@"分享"];
            for (int i=0; i<array.count; i++) {
                btn  = [[UIButton alloc]initWithFrame:CGRectMake(20+ i* (SWidth/4+30), CGRectGetMaxY(_connter.frame)+10, SWidth/4, 30)];
                if ([array[i] isEqualToString:@"已赞"]) {
                    [btn setTitle:[NSString stringWithFormat:@"%@%lu",array[i],(unsigned long)Users] forState:UIControlStateNormal];
                }else{
                    [btn setTitle:array[i] forState:UIControlStateNormal];
                }

                [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
                btn.layer.borderWidth = 1;
                btn.layer.cornerRadius = 5;
                btn.titleLabel.font = [UIFont systemFontOfSize:12 weight:2];
                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                btn.tag = 100+i;
                [self.contentView addSubview:btn];
            }

        }
    }else{
        
    }
    
    UIView * zan = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(btn.frame)+10, SWidth-20, 40)];
    [self.contentView addSubview:zan];
    for (int i = 0; i<Users; i++) {
        UIImageView * imgV = [[UIImageView alloc]initWithFrame:CGRectMake(i*45, 0, 30, 30)];
        imgV.layer.masksToBounds = YES;
        imgV.layer.cornerRadius = 15;
        [imgV sd_setImageWithURL:[NSURL URLWithString:model.voteUsers[i][@"user"][@"loginAvatar"]] placeholderImage:nil];
        [zan addSubview:imgV];
    }
    
    
    
    
}
- (void)btnClick:(UIButton *)btn{
//    NSLog(@"%ld",(long)btn.tag);
    if (btn.tag == 100) {
//        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(100, SHeight+100, 100, 50)];
//        view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
//        [self.contentView addSubview:view];
//        UILabel * lb= [[UILabel alloc]initWithFrame:CGRectMake(100, SHeight+100, 120, 50)];
//        lb.text = @"读者被外星人掳走了";
//        lb.textColor = [UIColor whiteColor];
//        lb.textAlignment = NSTextAlignmentCenter;
//        lb.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
//        [self.contentView addSubview:lb];
//        
//        [UIView animateWithDuration:1 animations:^{
//            lb.frame = CGRectMake(100, 150, 100, 50);
//            
//        }];
        
        
        
        
    }else if(btn.tag == 102){
        
        
        
        
    }
    
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
