//
//  DapengSpecialScrollView.m
//  Dapeng-meitian
//
//  Created by qianfeng on 15/12/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DapengSpecialScrollView.h"
#import "DapengHttpRequest.h"
#import "DapengJSONModel.h"
#import "UIImageView+WebCache.h"
#import "PathHeader.h"
#define IMAGE_COUNT 5
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
@interface DapengSpecialScrollView ()<UIScrollViewDelegate>
{
    int category_id;
}

@property(nonatomic,retain)UIScrollView * scrollView;
@property(nonatomic,retain)UIPageControl * pageControl;

@property (nonatomic,retain)NSMutableArray * dataArray;

@property (nonatomic,strong)UIImage * image;

@property (nonatomic,strong)UIImage * firstImage;
@property (nonatomic,strong)UIImage * lastImage;





@property (nonatomic ,strong)UIImageView * titleImageView;
@property (nonatomic ,strong)UILabel * nameLabel;
@property (nonatomic ,strong)UILabel * leiBieLabel;
//显示title
@property (nonatomic ,retain)UILabel * titleLabel;

@end

@implementation DapengSpecialScrollView

@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;

@synthesize dataArray = _dataArray;
//文字
@synthesize titleImageView = _titleImageView;
@synthesize titleLabel = _titleLabel;
@synthesize nameLabel = _nameLabel;
@synthesize leiBieLabel = _leiBieLabel;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _dataArray = [NSMutableArray array];
        category_id = 5;
        [self initHttpRequest];
    }
    return self;
}

- (void)initHttpRequest{
    DapengHttpRequest * request =[[DapengHttpRequest alloc]init];
    [request downloadDataWithUrlString:[NSString stringWithFormat:ZL_TUPIAN,category_id] finished:^(NSData *data) {
        NSDictionary * dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * array = dic[@"result"];
        _dataArray = [DapengJSONModel arrayOfModelsFromDictionaries:array error:nil];
//        NSLog(@"%@",_dataArray);
        [self setUp];
    } failed:^(NSString *error) {
        NSLog(@"请求失败");
    }];

}
#pragma mark -- 设置子视图

- (void)setUp{
//    DapengZhuanLanModel * model2 = _dataArray[0];
//    NSLog(@"%@",model2.article[@"article"][@"title"]);
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, size.width, 200)];
    
    _scrollView.bounces = NO;
    
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    _scrollView.showsVerticalScrollIndicator = NO;
    
    _scrollView.pagingEnabled = YES;
    
    _scrollView.contentSize = CGSizeMake((IMAGE_COUNT+2) * size.width, 200);
    
    _scrollView.delegate = self;
    
    
    
    //创建一个数组存储所有的图片 包括两头多出来
    NSMutableArray * imageArr = [NSMutableArray array];
    
    for (int i = 0; i < IMAGE_COUNT; i ++) {
        
        DapengZhuanLanModel * model = _dataArray[i];
    
        _image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.author[@"image"]]]];
        UIImageView * imageView = [[UIImageView alloc]initWithImage:_image];
        [imageArr addObject:imageView];
    }
    
    DapengZhuanLanModel * model = _dataArray[4];
    _firstImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.author[@"image"]]]];

    DapengZhuanLanModel * model1 = _dataArray[0];
    _lastImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model1.author[@"image"]]]];
//
    UIImageView * imageView1 = [[UIImageView alloc]initWithImage:_firstImage];
    
    [imageArr insertObject:imageView1 atIndex:0];
    
    UIImageView * imageView2 = [[UIImageView alloc]initWithImage:_lastImage];
    
    
    [imageArr addObject:imageView2];
    
    for (int i = 0; i < imageArr.count; i ++) {
        
        UIImageView * imageView = imageArr[i];
        
        imageView.frame = CGRectMake(i * SCREEN_W, 0, SCREEN_W, 200);
        
        [_scrollView addSubview:imageView];
        
    }
    
    _scrollView.contentOffset = CGPointMake(SCREEN_W, 0);
    
    [self addSubview:_scrollView];
    
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(300, 160, 70, 40)];
    
    
    //设置点的个数
    _pageControl.numberOfPages = IMAGE_COUNT;
    
    _pageControl.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    //点选中时的颜色
    _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    
    //设置页码指示器的颜色
    _pageControl.pageIndicatorTintColor = [UIColor cyanColor];
    
    [self addSubview:_pageControl];
    
    _titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, self.frame.size.height - 40, 40, 40)];
    _titleImageView.layer.masksToBounds = YES;
    _titleImageView.layer.cornerRadius = 20;
    [self addSubview:_titleImageView];
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_titleImageView.frame)+5, self.frame.size.height - 40, 100, 20)];
    _nameLabel.backgroundColor = [UIColor clearColor];
    _nameLabel.font = [UIFont systemFontOfSize:16];
    _nameLabel.textColor = [UIColor whiteColor];
    [self addSubview:_nameLabel];
    _leiBieLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_nameLabel.frame)+5, self.frame.size.height - 40, 30, 20)];
    _leiBieLabel.backgroundColor = [UIColor clearColor];
    _leiBieLabel.font = [UIFont systemFontOfSize:12];
    _leiBieLabel.textColor = [UIColor redColor];
    [self addSubview:_leiBieLabel];
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_titleImageView.frame)+5, CGRectGetMaxY(_nameLabel.frame), self.frame.size.width-200, 20)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont systemFontOfSize:12];
    _titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:_titleLabel];
    [self starTheTime];
}

#pragma mark -- scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //滚动视图 滚动减速时触发 （如果与UIPageControl结合使用的时候 可以认为翻页即将结束时触发）
    int page = (int)(scrollView.contentOffset.x/self.frame.size.width);
    if (page == 6) {
         page = 1;
        DapengZhuanLanModel * model2 = _dataArray[page-1];
        [_titleImageView sd_setImageWithURL:[NSURL URLWithString:model2.author[@"avatar"]]];
        _nameLabel.text = [NSString stringWithFormat:@"%@",model2.article[@"author"][@"name"]];
        _leiBieLabel.text = [NSString stringWithFormat:@"/%@",model2.article[@"category"][@"categoryGroup"][@"name"]];
        _titleLabel.text = [NSString stringWithFormat:@"%@",model2.article[@"article"][@"title"]];
    }else if (page == 0){
        page = 5;
        DapengZhuanLanModel * model2 = _dataArray[page-1];
        [_titleImageView sd_setImageWithURL:[NSURL URLWithString:model2.author[@"avatar"]]];
        _nameLabel.text = [NSString stringWithFormat:@"%@",model2.article[@"author"][@"name"]];
        _leiBieLabel.text = [NSString stringWithFormat:@"/%@",model2.article[@"category"][@"categoryGroup"][@"name"]];
        _titleLabel.text = [NSString stringWithFormat:@"%@",model2.article[@"article"][@"title"]];
    }else{
        DapengZhuanLanModel * model2 = _dataArray[page-1];
        [_titleImageView sd_setImageWithURL:[NSURL URLWithString:model2.author[@"avatar"]]];
        _nameLabel.text = [NSString stringWithFormat:@"%@",model2.article[@"author"][@"name"]];
        _leiBieLabel.text = [NSString stringWithFormat:@"/%@",model2.article[@"category"][@"categoryGroup"][@"name"]];
        _titleLabel.text = [NSString stringWithFormat:@"%@",model2.article[@"article"][@"title"]];
    }
//    DapengZhuanLanModel * model2 = _dataArray[page-1];
//    [_titleImageView sd_setImageWithURL:[NSURL URLWithString:model2.author[@"avatar"]]];
//    _nameLabel.text = [NSString stringWithFormat:@"%@",model2.article[@"author"][@"name"]];
//    _leiBieLabel.text = [NSString stringWithFormat:@"/%@",model2.article[@"category"][@"categoryGroup"][@"name"]];
//    _titleLabel.text = [NSString stringWithFormat:@"%@",model2.article[@"article"][@"title"]];
    if (page == 6) {
        scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
        page = 1;
    }else if(page == 0){
        scrollView.contentOffset = CGPointMake(self.frame.size.width * 5, 0);
        page = 5;
    }
    _pageControl.currentPage = page - 1 ;
    
}
- (void)starTheTime{
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 10*NSEC_PER_SEC, 1*NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        //设置计时器里面的内容
        static int i =0;
        if(i){
            dispatch_source_cancel(timer);
        }
        [self imageTimer];
    });
    //启动定时器
    dispatch_resume(timer);
}
- (void)imageTimer{
    
    static int page = 0;
    page ++;
    self.pageControl.currentPage ++;
//    NSLog(@"%ld",(long)self.pageControl.currentPage);
    
    
    if (page == 5) {
        self.scrollView.contentOffset = CGPointMake(SCREEN_W , 0);
        self.pageControl.currentPage = 0;
        page = 0;
        DapengZhuanLanModel * model2 = _dataArray[page];
        [_titleImageView sd_setImageWithURL:[NSURL URLWithString:model2.author[@"avatar"]]];
        _nameLabel.text = [NSString stringWithFormat:@"%@",model2.article[@"author"][@"name"]];
        _leiBieLabel.text = [NSString stringWithFormat:@"/%@",model2.article[@"category"][@"categoryGroup"][@"name"]];
        _titleLabel.text = [NSString stringWithFormat:@"%@",model2.article[@"article"][@"title"]];
//        _titleLabel.text = [NSString stringWithFormat:@"%d",page];
    }else{
        [self.scrollView setContentOffset:CGPointMake(SCREEN_W * (self.pageControl.currentPage+1), 0) animated:YES];
        DapengZhuanLanModel * model2 = _dataArray[page];
        [_titleImageView sd_setImageWithURL:[NSURL URLWithString:model2.author[@"avatar"]]];
        _nameLabel.text = [NSString stringWithFormat:@"%@",model2.article[@"author"][@"name"]];
        _leiBieLabel.text = [NSString stringWithFormat:@"/%@",model2.article[@"category"][@"categoryGroup"][@"name"]];

        _titleLabel.text = [NSString stringWithFormat:@"%@",model2.article[@"article"][@"title"]];

        
    }
}










@end
