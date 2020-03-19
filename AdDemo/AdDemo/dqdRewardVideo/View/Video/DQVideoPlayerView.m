//
//  DQVideoPlayerView.m
//  AdDemo
//
//  Created by e on 2020/3/18.
//

#import "DQVideoPlayerView.h"
#import <AVFoundation/AVFoundation.h>

@interface DQVideoPlayerView ()

@property(nonatomic, strong) UIView *playerView;
@property(nonatomic, strong) AVPlayer *player;
@property(nonatomic, strong) AVPlayerLayer *playerLayer;
@property(nonatomic, strong) AVPlayerItem *playerItem;

@property(nonatomic, strong) id playTimeObserver;

@end

@implementation DQVideoPlayerView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //播放器的view
        self.playerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:self.playerView];
        
        // 设置AVPlayer
        self.player = [[AVPlayer alloc] init];
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        _playerLayer.frame = self.bounds;

        _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        [self.playerView.layer addSublayer:_playerLayer];
    }
    return self;
}

-(void)setupMute:(BOOL)isMute {
    if (isMute) {
        self.player.volume = 0;
    }else{
        self.player.volume = 1.0;
    }
}

-(void)updatePlayerWithURL:(NSURL *)url{
    //如果有视频源的切换的话，要记得先移除再添加
    [self removeObserverAndNotificationWithPlayer];

    _playerItem = [AVPlayerItem playerItemWithURL:url]; // create item
    [_player replaceCurrentItemWithPlayerItem:_playerItem]; // replaceCurrentItem
    [self addObserverAndNotification]; // 添加观察者，发布通知
}

#pragma mark - 添加观察者，发布通知
-(void)addObserverAndNotification{
    [_playerItem addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionNew) context:nil]; // 观察status属性， 一共有三种属性
    [self monitoringPlayback:_playerItem]; // 监听播放
    
    // 播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    // 前台通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterForegroundNotification) name:UIApplicationWillEnterForegroundNotification object:nil];
    // 后台通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterBackgroundNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

#pragma mark - 播放完成的通知
- (void)playbackFinished:(NSNotification *)notification {
    _playerItem = [notification object];
//    // 是否无限循环
//    [_playerItem seekToTime:kCMTimeZero]; // 跳转到初始
//    [_player play]; // 是否无限循环
}

#pragma mark - 前台通知
-(void)enterForegroundNotification{
    [self play];
}

#pragma mark - 后台通知
-(void)enterBackgroundNotification{
    [self pause];
}

#pragma mark - Status的KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    AVPlayerItem *item = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        // 判断status 的 状态
        AVPlayerStatus status = [[change objectForKey:@"new"] intValue]; // 获取更改后的状态
        if (status == AVPlayerStatusReadyToPlay) {
            NSLog(@"准备播放");
            // CMTime 本身是一个结构体
            CMTime duration = item.duration; // 获取视频长度
            NSLog(@"%.2f", CMTimeGetSeconds(duration));
//            // 设置视频时间
//            [self setMaxDuration:CMTimeGetSeconds(duration)];
            // 播放
            [self play];
            
        } else if (status == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
        } else {
            NSLog(@"AVPlayerStatusUnknown");
        }
    }
}

#pragma mark - 添加监听播放
- (void)monitoringPlayback:(AVPlayerItem *)item {
    __weak typeof(self)weakSelf = self;
    // 播放进度, 每秒执行30次， CMTime 为30分之一秒
    _playTimeObserver = [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 30.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        // 当前播放秒
       weakSelf.currentPlayTime = (double)item.currentTime.value/ item.currentTime.timescale;
    }];
}

#pragma mark - 播放
- (void)play {
    _isPlaying = YES;
    [_player play]; // 调用avplayer 的play方法
}

#pragma mark - 暂停
- (void)pause {
    _isPlaying = NO;
    [_player pause];
}

#pragma mark - 移除通知和观察者
-(void)removeObserverAndNotificationWithPlayer{
    [_player replaceCurrentItemWithPlayerItem:nil];
    [_playerItem removeObserver:self forKeyPath:@"status"];
    [_player removeTimeObserver:_playTimeObserver];
    _playTimeObserver = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
