//
//  DapengFoundConnterViewController.h
//  Dapeng-meitian
//
//  Created by qianfeng on 15/12/27.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DapengJSONModel.h"
@interface DapengFoundConnterViewController : UIViewController

@property (nonatomic ,strong)DapengJSONModel * model;

@property (nonatomic ,strong)NSString * isFen ; //判断是从那里传过来的
@end
