//
//  DapengSelectView.h
//  Dapeng-meitian
//
//  Created by qianfeng on 16/1/8.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DapengSelectViewDelegate <NSObject>

-(void)itemSelected : (NSInteger)index;

@end

@interface DapengSelectView : UIView

@property (nonatomic, weak) id<DapengSelectViewDelegate> delegate;

//@property (nonatomic ,strong)NSArray * yanse;


-(instancetype)initViewWithImageArray:(NSArray *)imageArray andColor:(NSArray *)colorArray;

@end