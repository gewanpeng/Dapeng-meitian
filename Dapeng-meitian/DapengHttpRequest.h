//
//  DapengHttpRequest.h
//  1556_15561061_葛万朋
//
//  Created by qianfeng on 15/12/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DapengHttpRequest : NSObject

typedef void (^DownloadFinishedBlock)(NSData * data);
typedef void (^DownloadFailedBlock)(NSString * error);

- (void)downloadDataWithUrlString:(NSString *)urlString finished:(DownloadFinishedBlock)finishedBlock failed:(DownloadFailedBlock)failedBlock;

@end
