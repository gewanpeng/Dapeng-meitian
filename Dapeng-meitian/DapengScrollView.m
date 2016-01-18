//
//  DapengScrollView.m
//  1556022_GeWanPeng
//
//  Created by qianfeng on 15/11/27.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DapengScrollView.h"
#import "DapengHttpRequest.h"
#import "DapengJSONModel.h"
#import "UIImageView+WebCache.h"
#import "PathHeader.h"
#define IMAGE_COUNT 5
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
@interface DapengScrollView ()<UIScrollViewDelegate>
{
    int category_id;
}

@property(nonatomic,retain)UIScrollView * scrollView;
@property(nonatomic,retain)UIPageControl * pageControl;

@property (nonatomic,retain)NSMutableArray * dataArray;

@property (nonatomic,strong)UIImage * image;

@property (nonatomic,strong)UIImage * firstImage;
@property (nonatomic,strong)UIImage * lastImage;

@end
@implementation DapengScrollView
@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;

@synthesize dataArray = _dataArray;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        _dataArray = [NSMutableArray array];
        category_id = 10;
        [self initHttpRequest];
    }
    return self;
}

- (void)initHttpRequest{
    DapengHttpRequest * request = [[DapengHttpRequest alloc]init];
    [request downloadDataWithUrlString:[NSString stringWithFormat:TJ_BIAOTI,category_id] finished:^(NSData *data) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * array = dic[@"result"];
        _dataArray = [DapengBiaoModel arrayOfModelsFromDictionaries:array error:nil];
        [self setUp];
    } failed:^(NSString *error) {
        NSLog(@"请求错误");
        NSLog(@"%@",error);
    }];

}

#pragma mark -- 设置子视图

- (void)setUp{
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, size.width, 200)];
    
    _scrollView.bounces = NO;
    
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    _scrollView.showsVerticalScrollIndicator = NO;
    
    _scrollView.pagingEnabled = YES;
    
    _scrollView.contentSize = CGSizeMake(IMAGE_COUNT * size.width, 200);
    
    _scrollView.delegate = self;
    
    //创建一个数组存储所有的图片 包括两头多出来
    NSMutableArray * imageArr = [NSMutableArray array];
    
    for (int i = 0; i < IMAGE_COUNT; i ++) {
        
        
        DapengBiaoModel * model = _dataArray[i];
        NSLog(@"%@",model.image);
        
            _image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.image]]];
        UIImageView * imageView = [[UIImageView alloc]initWithImage:_image];
        [imageArr addObject:imageView];
        
        
    }
    
//    DapengModel * model = _dataArray[3];
//    for (DapengXiaoModel * xiaomodel in model.thumb) {
//        _firstImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:xiaomodel.img_url]]];
//    }
//    DapengModel * model1 = _dataArray[0];
//    for (DapengXiaoModel * xiaomodel in model1.thumb) {
//        _lastImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:xiaomodel.img_url]]];
//    }
    
//    UIImageView * imageView1 = [[UIImageView alloc]initWithImage:_firstImage];
//    
//    [imageArr insertObject:imageView1 atIndex:0];
//    
//    UIImageView * imageView2 = [[UIImageView alloc]initWithImage:_lastImage];
//    
//    
//    [imageArr addObject:imageView2];
    
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
    
//    [self starTheTime];
}

#pragma mark -- scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //滚动视图 滚动减速时触发 （如果与UIPageControl结合使用的时候 可以认为翻页即将结束时触发）
    int page = (int)(scrollView.contentOffset.x/self.frame.size.width);
    NSLog(@"%d",page);
    if (page == 6) {
        scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
        page = 1;
    }else if(page == 0){
        scrollView.contentOffset = CGPointMake(self.frame.size.width * 4, 0);
        page = 5;
    }
    _pageControl.currentPage = page - 1 ;
    
}
- (void)starTheTime{
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 2*NSEC_PER_SEC, 1*NSEC_PER_SEC);
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
    
    if (page == 5) {
        self.scrollView.contentOffset = CGPointMake(SCREEN_W , 0);
        self.pageControl.currentPage = 0;
        page = 0;
    }else{
        [self.scrollView setContentOffset:CGPointMake(SCREEN_W * (self.pageControl.currentPage+1), 0) animated:YES];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
