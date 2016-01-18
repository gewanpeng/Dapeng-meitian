//
//  DapengHttpRequest.m
//  1556_15561061_葛万朋
//
//  Created by qianfeng on 15/12/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DapengHttpRequest.h"
#import "DapengLimitCache.h"
@implementation DapengHttpRequest
{
    NSURLConnection * _urlCon;
    NSMutableData * _data;
    DownloadFinishedBlock _finishedBlock;
    DownloadFailedBlock _failedBlock;
    NSString * pathString;
}
- (void)downloadDataWithUrlString:(NSString *)urlString finished:(DownloadFinishedBlock)finishedBlock failed:(DownloadFailedBlock)failedBlock{
    if (_finishedBlock != finishedBlock) {
        _finishedBlock = nil;
        _finishedBlock = finishedBlock;
    }
    if (_failedBlock != failedBlock) {
        _failedBlock = nil;
        _failedBlock = failedBlock;
    }
    pathString = urlString;
    DapengLimitCache * cache = [DapengLimitCache defalutCache];
    NSData * data = [cache getDataWithNameString:urlString];
    if (data) {
        _failedBlock(data);
    }else{
        NSURL * url = [NSURL URLWithString:urlString];
        NSURLRequest *  request = [NSURLRequest requestWithURL:url];
        if (_urlCon) {
            [_urlCon cancel];
            _urlCon = nil;
        }
        _urlCon = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    if (_data==nil) {
        _data = [[NSMutableData alloc] init];
    }
    //清空缓存
    [_data setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
    
    if (_data&&_finishedBlock) {
        //请求成功  保存缓存到指定路径
        DapengLimitCache * cache = [DapengLimitCache defalutCache];
        
        [cache saveWithData:_data andNameString:pathString];
        
        //传给 vc 数据
        _finishedBlock(_data);
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (error&&_failedBlock)
    {
        _failedBlock(error.localizedDescription);
    }
}


@end
