//
//  DapengTableViewCell.h
//  1556_15561061_葛万朋
//
//  Created by qianfeng on 15/12/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DapengJSONModel.h"
@interface DapengTableViewCell : UITableViewCell

@property (nonatomic ,strong)DapengJSONModel * model;

@property (nonatomic ,strong)UIImageView * imageView;
@property (nonatomic ,strong)UILabel * nameLable;
@property (nonatomic ,strong)UILabel * conntLable;
@property (nonatomic ,strong)UILabel * timeLable;
@property (nonatomic ,strong)UILabel * viewLable;


@end
