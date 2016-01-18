//
//  DapengTableViewCell.m
//  1556_15561061_葛万朋
//
//  Created by qianfeng on 15/12/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DapengTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "RGBColor.h"
#define Width [UIScreen mainScreen].bounds.size.width
@implementation DapengTableViewCell
{
    UIImageView * imageView;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCell];
    }
    return self;
}
- (void)createCell{

    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 120, 80)];
    imageView.layer.masksToBounds = YES;
//    imageView.layer.cornerRadius = 20;
    [self.contentView addSubview:imageView];
    
    self.nameLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+10, 10, Width - imageView.frame.size.width -30, 30)];
//    NSLog(@"%lf",self..frame.size.width );
//NSLog(@"%lf", [UIScreen mainScreen].bounds.size.width);
    self.nameLable.numberOfLines = 2;
    self.nameLable.lineBreakMode = NSLineBreakByCharWrapping;
    self.nameLable.font = [UIFont systemFontOfSize:13];
    self.nameLable.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.nameLable];
    
    self.conntLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, CGRectGetMaxY(self.nameLable.frame)+5, 30, 20)];
    self.conntLable.font = [UIFont systemFontOfSize:10];
//    self.conntLable.textColor = [UIColor orangeColor];
    self.conntLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.conntLable];
    
    UILabel * libShu = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.conntLable.frame)+10, CGRectGetMaxY(self.nameLable.frame)+10, 1, 12)];
    libShu.layer.borderWidth = 1;
    libShu.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.contentView addSubview:libShu];
    
    self.timeLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(libShu.frame)+10, CGRectGetMaxY(self.nameLable.frame)+5, 60, 20)];
    self.timeLable.font = [UIFont systemFontOfSize:10];
    self.timeLable.textColor = [UIColor lightGrayColor];
    self.timeLable.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.timeLable];
    
    
    
    self.viewLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeLable.frame)+5, CGRectGetMaxY(self.nameLable.frame), Width - imageView.frame.size.width -self.conntLable.frame.size.width - self.timeLable.frame.size.width, 30)];
    self.viewLable.font = [UIFont systemFontOfSize:10];
    self.viewLable.textColor = [UIColor lightGrayColor];
    self.viewLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.viewLable];
    
    
}
- (void)setModel:(DapengJSONModel *)model{
    DapengJSONArrayModel * arrModel = model.image[0];
    [imageView sd_setImageWithURL:[NSURL URLWithString:arrModel.url]];

    self.nameLable.text = model.article[@"title"];
    self.conntLable.text = model.category[@"name"];
    self.conntLable.textColor = [RGBColor colorWithHexString:[NSString stringWithFormat:model.category[@"categoryGroup"][@"color"]]];
    self.timeLable.text = model.author[@"name"];
    self.viewLable.text = [NSString stringWithFormat:@"%@",model.article[@"articleStats"][@"read"]];

    
}


- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
