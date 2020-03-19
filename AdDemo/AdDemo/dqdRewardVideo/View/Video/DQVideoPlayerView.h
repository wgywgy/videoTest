//
//  DQVideoPlayerView.h
//  AdDemo
//
//  Created by e on 2020/3/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DQVideoPlayerView;
@protocol DQVideoPlayerViewDelegate <NSObject>

@optional
- (void)didPlayFinish:(DQVideoPlayerView *)videoPlayerView;

@end

@interface DQVideoPlayerView : UIView

@property(nonatomic, weak) id<DQVideoPlayerViewDelegate> delegate;
@property(nonatomic, assign) BOOL isPlaying;
@property(nonatomic, assign) float currentPlayTime;

- (void)updatePlayerWithURL:(NSURL *)url;
- (void)play;
- (void)pause;
- (void)setupMute:(BOOL)isMute;

@end

NS_ASSUME_NONNULL_END
