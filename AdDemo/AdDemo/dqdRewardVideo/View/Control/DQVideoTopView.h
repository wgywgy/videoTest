//
//  DQVideoTopView.h
//  AdDemo
//
//  Created by e on 2020/3/18.
//

#import <UIKit/UIKit.h>
//#import "DQBorderLabel.h"
#import "DQRVPaddingLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DQVideoTopView : UIView
@property (weak, nonatomic) IBOutlet DQRVPaddingLabel *countLabel;
//@property(nonatomic, strong) IBOutlet DQBorderLabel *countDownBtn;
@property(nonatomic, weak) IBOutlet UIButton *soundBtn;
@property(nonatomic, weak) IBOutlet UIButton *skipBtn;
@property(nonatomic, weak) IBOutlet UIButton *closeBtn;


@property(nonatomic, assign) BOOL isMute;
/// 当前展示倒计时
@property(nonatomic, assign) int countSecond;
/// 逝去的时间
@property(nonatomic, assign) int elapseSecond;

@property(nonatomic, copy) void (^didTapClose)(void);
@property(nonatomic, copy) void (^didTapSkip)(void);
@property(nonatomic, copy) void (^didTapMute)(BOOL toMute);

@property(nonatomic, copy) void (^didEndCount)(void);

- (void)startCountDown;
- (void)continueCountDown;
- (void)stopCountDown;

- (void)changeToCloseState;

- (void)toggleMute:(BOOL)mute;

@end

NS_ASSUME_NONNULL_END
