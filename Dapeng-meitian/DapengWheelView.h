//
//  DapengWheelView.h
//  Dapeng-meitian
//
//  Created by qianfeng on 16/1/8.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^click) (int i);

@interface DapengWheelView : UIView
// imageNames 和images 二选一
//图片名数组
@property(nonatomic,weak)NSArray *imageNames;
//图片数组
@property(nonatomic,weak)NSArray *images;
//回调单击方法
@property(nonatomic,strong)click click;

@end
