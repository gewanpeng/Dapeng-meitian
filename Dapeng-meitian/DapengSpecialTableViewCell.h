//
//  DapengSpecialTableViewCell.h
//  Dapeng-meitian
//
//  Created by qianfeng on 15/12/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DapengJSONModel.h"
#define RColCount 2
#define RCellHeight 160

@class DapengSpecialTableViewCell;
@protocol  DapengSpecialDelegate <NSObject>
- (void)productCell:(DapengSpecialTableViewCell *)cell actionWithFlag:(NSString *)flag andArray:(NSArray *)arr;
@end
@interface DapengSpecialTableViewCell : UITableViewCell

@property (nonatomic ,strong) DapengJSONModel * model;
@property (assign ,nonatomic) id<DapengSpecialDelegate> delegate;
@property (nonatomic ,strong) NSString * str;
@property (nonatomic ,strong) NSMutableArray * arr;

- (void)bindProducts:(NSArray *)productList;

@end
