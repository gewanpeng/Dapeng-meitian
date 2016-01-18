//
//  DapengZuoZheTableViewCell.h
//  Dapeng-meitian
//
//  Created by qianfeng on 15/12/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DapengJSONModel.h"
#define RColCount 2
#define RCellHeight 160
@class DapengZuoZheTableViewCell;
@protocol  DapengZuoZheDelegate <NSObject>
- (void)productZuoCell:(DapengZuoZheTableViewCell *)cell actionWithFlag:(NSString *)flag andArray:(NSArray *)arr;
@end
@interface DapengZuoZheTableViewCell : UITableViewCell
@property (nonatomic ,strong) DapengJSONModel * model;
@property (assign ,nonatomic) id<DapengZuoZheDelegate> delegate;
@property (nonatomic ,strong) NSString * str;
@property (nonatomic ,strong) NSMutableArray * arr;
- (void)bindProducts:(NSArray *)productList;

@end
