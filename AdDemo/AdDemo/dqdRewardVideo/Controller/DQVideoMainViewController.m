//
//  DQVideoMainViewController.m
//  AdDemo
//
//  Created by e on 2020/3/18.
//

#import "DQVideoMainViewController.h"

#import "DQRVBaseMarco.h"
#import "DQRewardVideoControlView.h"
#import "DQVideoPlayerView.h"

@interface DQVideoMainViewController () <DQRewardVideoControlViewDelegate, DQVideoPlayerViewDelegate>
@property(nonatomic, strong) DQRewardVideoControlView *controlView;
@property(nonatomic, strong) DQVideoPlayerView *playerView;
@end

@implementation DQVideoMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.playerView];
    [self.playerView updatePlayerWithURL:[NSURL URLWithString:@"https://r2---sn-npoe7ne6.googlevideo.com/videoplayback?expire=1584622144&ei=4BVzXt-uD4mA1d8P0tC6-Ag&ip=45.113.192.180&id=o-AAPmtUjEDEpxxIfwF-rjC12cp8aJMHkp4zte-mX08fVH&itag=18&source=youtube&requiressl=yes&mh=_p&mm=31%2C26&mn=sn-npoe7ne6%2Csn-i3b7knl6&ms=au%2Conr&mv=m&mvi=1&pl=24&initcwndbps=34001250&vprv=1&mime=video%2Fmp4&gir=yes&clen=11491750&ratebypass=yes&dur=151.672&lmt=1584533779379359&mt=1584600459&fvip=2&c=WEB&txp=5531432&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cgir%2Cclen%2Cratebypass%2Cdur%2Clmt&sig=ADKhkGMwRQIgF4E8AN6juUTOGSC6nEVBYhksvLI1_vTAmHlK8q-L5UUCIQDRNGW0sSBtFQmQIg6-DF-gCptn2RdX4iQdgQy6ZmNQZw%3D%3D&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=ABSNjpQwRAIgZq-EHlNt0MB-kts7XtoL3ptiSm_S_JD723fxXXa-aCQCIBxNKqw_5WgOxyk_98GVG0co_wYVrgpc9OBD058SXDrs"]];
//                                                         http://bos.nj.bpc.baidu.com/tieba-smallvideo/11772_3c435014fb2dd9a5fd56a57cc369f6a0.mp4"]];
    [self.view addSubview:self.controlView];
    
    [self.controlView toggleMute:YES];
}

#pragma mark - Getter
- (DQRewardVideoControlView *)controlView {
    if (!_controlView) {
        _controlView = [[DQRewardVideoControlView alloc] initWithFrame:CGRectMake(0, 0, DQCurrentScreenWidth, DQCurrentScreenHeight)];
        _controlView.baseController = self;
        _controlView.delegate = self;
    }
    return _controlView;
}

- (DQVideoPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [[DQVideoPlayerView alloc] initWithFrame:CGRectMake(0, 0, DQCurrentScreenWidth, DQCurrentScreenHeight)];
        _playerView.delegate = self;
    }
    return _playerView;
}

#pragma mark - DQRewardVideoControlViewDelegate
- (void)didControlEnd:(DQRewardVideoControlView *)controlView {
    [self.playerView pause];
}

- (void)didControlMute:(DQRewardVideoControlView *)controlView mute:(BOOL)mute {
    [self.playerView setupMute:mute];
}

- (void)didControlShowSkipTip:(DQRewardVideoControlView *)controlView {
    [self.playerView pause];
}

- (void)didControlDismissSkipTip:(DQRewardVideoControlView *)controlView {
    [self.playerView play];
}

#pragma mark - DQVideoPlayerViewDelegate
- (void)didPlayFinish:(DQVideoPlayerView *)videoPlayerView {
    
}

@end
