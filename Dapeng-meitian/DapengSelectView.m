//
//  DapengSelectView.m
//  Dapeng-meitian
//
//  Created by qianfeng on 16/1/8.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "DapengSelectView.h"
#import "RGBColor.h"
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT    [[UIScreen mainScreen] bounds].size.height

#define NORMAL_VIEW_WIDTH 60
#define NORMAL_VIEW_HEIGHT 60

#define SELECT_VIEW_WIDTH 90
#define SELECT_VIEW_HEIGHT 90

#define ITEM_SPACE 30
#define LEFT_SPACE (SCREEN_WIDTH/2-NORMAL_VIEW_WIDTH/2)
@interface DapengSelectView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) NSMutableArray *imageViewArray;
@property (nonatomic, strong) NSMutableArray *viewArray;

@property (nonatomic ,strong) UIView *backView;
@property (nonatomic ,strong) NSArray * color;
@end
@implementation DapengSelectView

-(instancetype)initViewWithImageArray:(NSArray *)imageArray andColor:(NSArray *)colorArray{
    _color = [NSArray arrayWithArray:colorArray];
    if (!imageArray) {
        return nil;
    }
    if (imageArray.count<1) {
        return nil;
    }
    
    NSInteger totalNum = imageArray.count;
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
    if (self) {
        _scrollview = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollview.contentSize = CGSizeMake(LEFT_SPACE*2+SELECT_VIEW_WIDTH+(totalNum-1)*NORMAL_VIEW_WIDTH+(totalNum-1)*ITEM_SPACE, 160);
        _scrollview.delegate = self;
        _scrollview.showsHorizontalScrollIndicator = NO;
        _scrollview.bounces = NO;
        _scrollview.decelerationRate = UIScrollViewDecelerationRateFast;
        [self addSubview:_scrollview];
        
        _backView = [[UIView alloc] initWithFrame:CGRectMake(-SCREEN_WIDTH, 0, _scrollview.contentSize.width+SCREEN_WIDTH*2, _scrollview.contentSize.height-20)];
        
        _backView.backgroundColor = [RGBColor colorWithHexString:colorArray[0]];
        
        
        [_scrollview addSubview:_backView];
        
        _imageViewArray = [NSMutableArray array];
        _viewArray = [NSMutableArray array];
        
        CGFloat offsetX = LEFT_SPACE;
        for (int i=0; i<totalNum; i++) {
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(offsetX, 0, NORMAL_VIEW_WIDTH, NORMAL_VIEW_HEIGHT)];
            [_scrollview addSubview:view];
            [_viewArray addObject:view];
            offsetX += NORMAL_VIEW_WIDTH+ITEM_SPACE;
            
            
            CGRect rect;
            if (i==0) {
                rect = CGRectMake(-(SELECT_VIEW_WIDTH-NORMAL_VIEW_WIDTH)/2, 20, SELECT_VIEW_WIDTH, SELECT_VIEW_HEIGHT);
            }else{
                rect = CGRectMake(0, 20, NORMAL_VIEW_WIDTH, NORMAL_VIEW_HEIGHT);
            }
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
            imageView.image = imageArray[i];
            imageView.tag = i;
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)];
            [imageView addGestureRecognizer:tap];
            [view addSubview:imageView];
            [_imageViewArray addObject:imageView];
        }
        
    }
    return self;
}

-(void)clickImage:(UITapGestureRecognizer *)tap{
    UIImageView *imageView = (UIImageView *)tap.view;
    NSInteger tag = imageView.tag;
    
    _backView.backgroundColor = [RGBColor colorWithHexString:_color[tag]];

    
    UIView *containerView = _viewArray[tag];
    
    CGFloat offsetX = CGRectGetMidX(containerView.frame)-SCREEN_WIDTH/2;
    
    
    [_scrollview scrollRectToVisible:CGRectMake(offsetX, 20, SCREEN_WIDTH, 120) animated:YES];
    
    if (_delegate && [_delegate respondsToSelector:@selector(itemSelected:)]) {
        [_delegate itemSelected:tag];
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int currentIndex = scrollView.contentOffset.x/(NORMAL_VIEW_WIDTH+ITEM_SPACE);
    if (currentIndex>_imageViewArray.count-2||currentIndex<0) {
        return;
    }
    int rightIndex = currentIndex+1;
    UIImageView *currentImageView = _imageViewArray[currentIndex];
    UIImageView *rightImageView = _imageViewArray[rightIndex];
    
    
    CGFloat scale =  (scrollView.contentOffset.x-currentIndex*(NORMAL_VIEW_WIDTH+ITEM_SPACE))/(NORMAL_VIEW_WIDTH+ITEM_SPACE);
    
    //NSLog(@"%f",scale);
    
    CGFloat width = SELECT_VIEW_WIDTH-scale*(SELECT_VIEW_WIDTH-NORMAL_VIEW_WIDTH);
    CGFloat height = SELECT_VIEW_HEIGHT-scale*(SELECT_VIEW_HEIGHT-NORMAL_VIEW_HEIGHT);
    if (width<NORMAL_VIEW_WIDTH) {
        width = NORMAL_VIEW_WIDTH;
    }
    if (height<NORMAL_VIEW_HEIGHT) {
        height = NORMAL_VIEW_HEIGHT;
    }
    if (width>SELECT_VIEW_WIDTH) {
        width = SELECT_VIEW_WIDTH;
    }
    if (height>SELECT_VIEW_HEIGHT) {
        height = SELECT_VIEW_HEIGHT;
    }
    CGRect rect = CGRectMake(-(width-NORMAL_VIEW_WIDTH)/2, 20, width, height);
    currentImageView.frame = rect;
    
    width = NORMAL_VIEW_WIDTH+scale*(SELECT_VIEW_WIDTH-NORMAL_VIEW_WIDTH);
    height = NORMAL_VIEW_HEIGHT+scale*(SELECT_VIEW_HEIGHT-NORMAL_VIEW_HEIGHT);
    if (width<NORMAL_VIEW_WIDTH) {
        width = NORMAL_VIEW_WIDTH;
    }
    if (height<NORMAL_VIEW_HEIGHT) {
        height = NORMAL_VIEW_HEIGHT;
    }
    if (width>SELECT_VIEW_WIDTH) {
        width = SELECT_VIEW_WIDTH;
    }
    if (height>SELECT_VIEW_HEIGHT) {
        height = SELECT_VIEW_HEIGHT;
    }
    rect = CGRectMake(-(width-NORMAL_VIEW_WIDTH)/2, 20, width, height);
//    NSLog(@"%@",NSStringFromCGRect(rect));
    rightImageView.frame = rect;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        int currentIndex = roundf(scrollView.contentOffset.x/(NORMAL_VIEW_WIDTH+ITEM_SPACE));
//        NSLog(@"%d",currentIndex);
         _backView.backgroundColor = [RGBColor colorWithHexString:_color[currentIndex]];
        
        UIView *containerView = _viewArray[currentIndex];
        CGFloat offsetX = CGRectGetMidX(containerView.frame)-SCREEN_WIDTH/2;
        [_scrollview scrollRectToVisible:CGRectMake(offsetX, 20, SCREEN_WIDTH, 120) animated:YES];
        if (_delegate && [_delegate respondsToSelector:@selector(itemSelected:)]) {
            [_delegate itemSelected:currentIndex];
        }
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
  
    int currentIndex = roundf(scrollView.contentOffset.x/(NORMAL_VIEW_WIDTH+ITEM_SPACE));
    UIView *containerView = _viewArray[currentIndex];
//      NSLog(@"df%d",currentIndex);
    _backView.backgroundColor = [RGBColor colorWithHexString:_color[currentIndex]];
    
    CGFloat offsetX = CGRectGetMidX(containerView.frame)-SCREEN_WIDTH/2;
    [_scrollview scrollRectToVisible:CGRectMake(offsetX, 0, SCREEN_WIDTH, 120) animated:YES];
    if (_delegate && [_delegate respondsToSelector:@selector(itemSelected:)]) {
        [_delegate itemSelected:currentIndex];
    }
}


@end
