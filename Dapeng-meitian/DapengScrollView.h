//
//  DapengScrollView.h
//  1556022_GeWanPeng
//
//  Created by qianfeng on 15/11/27.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DapengScrollViewDelegate <NSObject>

-(void)itemSelected : (NSInteger)index;

@end

@interface DapengScrollView : UIView

@property (nonatomic, weak) id<DapengScrollViewDelegate> delegate;

-(instancetype)initViewWithImageArray:(NSArray *)imageArray;
@end