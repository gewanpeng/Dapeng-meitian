//
//  DapengGuidanceViewController.m
//  Dapeng-meitian
//
//  Created by qianfeng on 15/12/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DapengGuidanceViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "DapengFactory.h"
@interface DapengGuidanceViewController ()
{
    AVPlayer * _player;
}
@property (nonatomic ,strong)UISlider *progress;
@end

@implementation DapengGuidanceViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated]; //创建视频播放器对象
    
    NSString *urlString = [[NSBundle mainBundle]pathForResource:@"LaunchMovie.mp4" ofType:nil];
    NSURL *url=[NSURL fileURLWithPath:urlString];
    AVAsset * asset = [AVAsset assetWithURL:url];
    
    AVPlayerItem * item = [[AVPlayerItem alloc]initWithAsset:asset];
    
    _player = [[AVPlayer alloc]initWithPlayerItem:item];
    
    //创建视频播放器的图层
    AVPlayerLayer * playerlayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    
    //设置playerlayer 的大小
    playerlayer.frame = self.view.layer.frame;
    //设置视频播放样式
    playerlayer.contentsGravity = AVLayerVideoGravityResize;
    //将layer层添加到视图
    [self.view.layer insertSublayer:playerlayer atIndex:0];
    
    //开始播放
    [_player play];
    
    
    
//    //通过观察者,观察视频播放器的状态
//    [_player addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dede)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[_player currentItem]];
}
- (void)dede{
    [DapengFactory setInstall:@"1"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"tabbar1" object:nil userInfo:nil];

}
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
//     __block AVPlayer * player = _player;
//    if ([keyPath isEqualToString:@"status"]) {
//        if (_player.status == AVPlayerStatusReadyToPlay) {
//
//        }
//        
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
