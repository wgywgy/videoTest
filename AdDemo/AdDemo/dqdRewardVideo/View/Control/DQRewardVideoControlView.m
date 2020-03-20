//
//  DQRewardVideoControlView.m
//  AdDemo
//
//  Created by e on 2020/3/19.
//

#import "DQRewardVideoControlView.h"
#import "DQRVBaseMarco.h"

#import "DQVideoTopView.h"
#import "DQVideoBottomView.h"
#import "DQVideoPlayerView.h"
#import "DQRewardEndBgView.h"

#import <StoreKit/StoreKit.h>

#define DQTopViewHeight 200
#define DQBottomViewHeight 120
@interface DQRewardVideoControlView () <SKStoreProductViewControllerDelegate>
@property(nonatomic, strong) DQVideoTopView *videoTopView;
@property(nonatomic, strong) DQVideoBottomView *videoBottomView;
@property(nonatomic, strong) DQVideoPlayerView *videoPlayerView;
@property(nonatomic, strong) DQRewardEndBgView *endBgView;
@end

@implementation DQRewardVideoControlView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    DQWS(weakSelf)
    [self addSubview:self.endBgView];
    self.endBgView.hidden = YES;
    self.endBgView.didTapSelf = ^{
        [weakSelf gotoResultPage];
    };
    
    self.videoTopView = [[DQVideoTopView alloc] initWithFrame:CGRectMake(0, 0, DQCurrentScreenWidth, DQTopViewHeight)];
    [self addSubview:self.videoTopView];
    self.videoTopView.countSecond = 30;
    [self.videoTopView startCountDown];

    self.videoTopView.didTapSkip = ^{
        [weakSelf skipTipAction];
    };
    self.videoTopView.didTapClose = ^{
        [weakSelf closeAction];
    };
    self.videoTopView.didTapMute = ^(BOOL toMute) {
        [weakSelf muteAction:toMute];
    };
    
    self.videoTopView.didEndCount = ^{
        weakSelf.videoBottomView.hidden = YES;
        [weakSelf showEndView];
        if ([weakSelf.delegate respondsToSelector:@selector(didControlEnd:)]) {
            [weakSelf.delegate didControlEnd:weakSelf];
        }
    };

    self.videoBottomView = [[DQVideoBottomView alloc] initWithFrame:CGRectMake(0, DQCurrentScreenHeight - DQBottomViewHeight, DQCurrentScreenWidth, DQBottomViewHeight)];
    [self addSubview:self.videoBottomView];
    
    self.videoBottomView.didTapBanner = ^{
        [weakSelf gotoResultPage];
    };
}

- (void)toggleMute:(BOOL)mute {
    [self.videoTopView toggleMute:mute];
}

#pragma mark - Skip
- (void)skipTipAction {
    if ([self.delegate respondsToSelector:@selector(didControlShowSkipTip:)]) {
        [self.delegate didControlShowSkipTip:self];
    }
    
    UIAlertController *alertController =
    [UIAlertController alertControllerWithTitle:@"观看完整视频才能获得奖励"
                                        message:@""
                                 preferredStyle:UIAlertControllerStyleAlert];

    DQWS(weakSelf)
    UIAlertAction *cancelAction =
    [UIAlertAction actionWithTitle:@"放弃奖励" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
        if ([self.delegate respondsToSelector:@selector(didControlDismissSkipTip:)]) {
            [self.delegate didControlDismissSkipTip:self];
        }
        
        [weakSelf.videoTopView stopCountDown];
        [weakSelf.videoTopView changeToCloseState];
        weakSelf.videoBottomView.hidden = YES;
        [weakSelf showEndView];
        
        if ([weakSelf.delegate respondsToSelector:@selector(didControlEnd:)]) {
            [weakSelf.delegate didControlEnd:weakSelf];
        }
    }];
    [alertController addAction:cancelAction];
    
    UIAlertAction *continueAction =
    [UIAlertAction actionWithTitle:@"继续观看" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
        if ([self.delegate respondsToSelector:@selector(didControlDismissSkipTip:)]) {
            [self.delegate didControlDismissSkipTip:self];
        }
        
        [weakSelf.videoTopView continueCountDown];
    }];
    [alertController addAction:continueAction];
    
    [cancelAction setValue:DQRVColorFromRGBAlpha(0x888888, 1) forKey:@"titleTextColor"];
    [continueAction setValue:DQRVColorFromRGBAlpha(0x3A76DE, 1) forKey:@"titleTextColor"];
    
    [self.baseController presentViewController:alertController animated:YES completion:nil];
}

- (void)dismissSkipAlert {

}

- (void)realSkipAction {
}

- (void)showEndView {
    self.endBgView.hidden = NO;
}

#pragma mark - Getter
- (DQRewardEndBgView *)endBgView {
    if (!_endBgView) {
        _endBgView = [[DQRewardEndBgView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
    return _endBgView;
}

#pragma mark - Action
- (void)closeAction {
    [self.baseController dismissViewControllerAnimated:YES completion:nil];
}

- (void)muteAction:(BOOL)toMute {
    if ([self.delegate respondsToSelector:@selector(didControlMute:mute:)]) {
        [self.delegate didControlMute:self mute:toMute];
    }
}

#pragma mark - Jump App store
- (void)gotoResultPage {
    [self openAppWithIdentifier:@"425349261"];
}

- (void)openAppWithIdentifier:(NSString*)appId {
    SKStoreProductViewController*storeProductVC =  [[SKStoreProductViewController alloc] init];
     
    storeProductVC.delegate=self;
         
    NSDictionary*dict = [NSDictionary dictionaryWithObject:appId forKey:SKStoreProductParameterITunesItemIdentifier];
    [storeProductVC loadProductWithParameters:dict completionBlock:^(BOOL result, NSError * _Nullable error) {
        if(result) {
            [self.baseController presentViewController:storeProductVC animated:YES completion:nil];
        }
    }];
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController*)viewController{
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

@end
