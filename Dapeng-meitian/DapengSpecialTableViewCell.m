//
//  DapengSpecialTableViewCell.m
//  Dapeng-meitian
//
//  Created by qianfeng on 15/12/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DapengSpecialTableViewCell.h"
#import "DapengButton.h"
#import "DapengProduct.h"
#import "DapengJSONModel.h"
#import "UIImageView+WebCache.h"
#import "RGBColor.h"
#define RCellWidth [UIScreen mainScreen].bounds.size.width
#define RMarginX 0
#define RMarginY 0
#define RStartTag 100
@implementation DapengSpecialTableViewCell
{
    UIImageView * imageView;
    NSMutableArray * array;
    NSMutableArray * array1;

}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        array = [NSMutableArray array];
        array1 = [NSMutableArray array];
        self.arr = [NSMutableArray array];
        
        [self createCell];
    }
    return self;
}
- (void)createCell{
    NSInteger width = RCellWidth/RColCount;
    for (NSInteger i = 0; i < RColCount; i++)
    {
        DapengButton *btn = [[DapengButton alloc] init];
        btn.frame = CGRectMake(i*width + RMarginX, RMarginY, width - 2*RMarginX, RCellHeight - 2*RMarginY);
        btn.tag = RStartTag + i;

        [self.contentView addSubview:btn];
    }
}
- (void)bindProducts:(NSArray *)productList{
//    NSLog(@"%@",productList);
    NSInteger width = RCellWidth/RColCount;
    for (NSInteger i=0; i<RColCount; i++) {
        DapengButton * btn = (DapengButton *)[self.contentView viewWithTag:RStartTag +i];
        btn.backgroundColor = [UIColor whiteColor];
        DapengJSONModel * model = productList[i];
        self.arr = productList[i];
        [array1 addObject:self.arr];
        self.str = model.article[@"author"][@"authorId"];
        [array addObject:self.str];
        btn.tag = i;
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake((btn.frame.size.width/2)-10, 10, 30, 30)];
        imageView.layer.cornerRadius = 15;
        imageView.layer.masksToBounds = YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.article[@"author"][@"avatar"]]];
        [btn addSubview:imageView];
        UILabel * namelib = [[UILabel alloc]initWithFrame:CGRectMake(13, CGRectGetMaxY(imageView.frame)+10, btn.frame.size.width-20, 30)];
        namelib.textAlignment = NSTextAlignmentCenter;
        namelib.textColor = [UIColor blackColor];
        namelib.text = [NSString stringWithFormat:model.author[@"name"]];
        namelib.font = [UIFont systemFontOfSize:14];
        [btn addSubview:namelib];
        UILabel * xian = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(namelib.frame)+2, btn.frame.size.width-20, 1)];
        xian.backgroundColor = [UIColor lightGrayColor];
        [btn addSubview:xian];
        UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(xian.frame)+5, btn.frame.size.width-20, 30)];
        title.textColor = [UIColor grayColor];
        title.font = [UIFont systemFontOfSize:12];
        title.text = [NSString stringWithFormat:model.article[@"article"][@"title"]];
        [btn addSubview:title];
        UILabel * fenlei = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(title.frame)+5, btn.frame.size.width-20, 30)];
        fenlei.textColor = [RGBColor colorWithHexString:[NSString stringWithFormat:model.article[@"category"][@"categoryGroup"][@"color"]]];
        fenlei.text = [NSString stringWithFormat:model.article[@"category"][@"categoryGroup"][@"name"]];
        fenlei.textAlignment = NSTextAlignmentCenter;
        fenlei.font = [UIFont systemFontOfSize:12];
        [btn addSubview:fenlei];
        
        [btn addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}
- (void)buttonTapped:(DapengButton *)btn
{
    
    NSString * ss = array[btn.tag];
    NSArray * arr = array1[btn.tag];
    [_delegate productCell:self actionWithFlag:ss andArray:arr];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
