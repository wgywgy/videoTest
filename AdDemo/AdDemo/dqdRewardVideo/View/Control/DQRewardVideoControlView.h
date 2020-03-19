//
//  DQRewardVideoControlView.h
//  AdDemo
//
//  Created by e on 2020/3/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DQRewardVideoControlView;
@protocol DQRewardVideoControlViewDelegate <NSObject>

@optional
- (void)didControlEnd:(DQRewardVideoControlView *)controlView;
- (void)didControlMute:(DQRewardVideoControlView *)controlView mute:(BOOL)mute;
- (void)didControlShowSkipTip:(DQRewardVideoControlView *)controlView;
- (void)didControlDismissSkipTip:(DQRewardVideoControlView *)controlView;
@end

@interface DQRewardVideoControlView : UIView

@property(nonatomic, weak) id<DQRewardVideoControlViewDelegate> delegate;

@property(nonatomic, weak) UIViewController *baseController;

- (void)toggleMute:(BOOL)mute;

@end

NS_ASSUME_NONNULL_END
