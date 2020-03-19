//
//  DQRewardedVideoAd.h
//  AdDemo
//
//  Created by e on 2020/3/18.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DQRewardedVideoAd;
@protocol DQRewardedVideoAdDelegate <NSObject>

@optional
/**
 This method is called when video ad material loaded successfully.
 */
- (void)dqd_rewardedVideoAdDidLoad:(DQRewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when cached successfully.
 */
- (void)dqd_rewardedVideoAdDidDownLoadVideo:(DQRewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when video ad materia failed to load.
 @param error : the reason of error
 */
- (void)dqd_rewardedVideoAd:(DQRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error;

/**
 This method is called when rendering a nativeExpressAdView successed. ?
 */
- (void)dqd_rewardedVideoAdViewRenderSuccess:(DQRewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when a nativeExpressAdView failed to render.
 @param error : the reason of error
 */
- (void)dqd_rewardedVideoAdViewRenderFail:(DQRewardedVideoAd *)rewardedVideoAd error:(NSError *_Nullable)error;

///**
// This method is called when video ad slot will be showing.
// */
//- (void)nativeExpressRewardedVideoAdWillVisible:(DQRewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when video ad slot has been shown.
 */
- (void)dqd_rewardedVideoAdDidVisible:(DQRewardedVideoAd *)rewardedVideoAd;

///**
// This method is called when video ad is about to close.
// */
//- (void)dqd_rewardedVideoAdWillClose:(DQRewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when video ad is closed.
 */
- (void)dqd_rewardedVideoAdDidClose:(DQRewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when video ad is clicked.
 */
- (void)dqd_rewardedVideoAdDidClick:(DQRewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when the user clicked skip button.
 */
- (void)dqd_rewardedVideoAdDidClickSkip:(DQRewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when video ad play completed or an error occurred.
 @param error : the reason of error
 */
- (void)dqd_ewardedVideoAdDidPlayFinish:(DQRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error;

///**
// Server verification which is requested asynchronously is succeeded.
// @param verify :return YES when return value is 2000.
// */
//- (void)nativeExpressRewardedVideoAdServerRewardDidSucceed:(DQRewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify;
//
///**
// Server verification which is requested asynchronously is failed.
// Return value is not 2000.
// */
//- (void)nativeExpressRewardedVideoAdServerRewardDidFail:(DQRewardedVideoAd *)rewardedVideoAd;

@end

@interface DQRewardedVideoAd : NSObject
//@property (nonatomic, strong) BURewardedVideoModel *rewardedVideoModel;
@property (nonatomic, weak, nullable) id<DQRewardedVideoAdDelegate> delegate;

/**
 Whether material is effective.
 Setted to YES when data is not empty and has not been displayed.
 Repeated display is not billed.
 */
@property (nonatomic, getter=isAdValid, readonly) BOOL adValid;

- (instancetype)initWithSlotID:(NSString *)slotID;
- (void)loadAdData;

/**
 Display video ad.
 @param rootViewController : root view controller for displaying ad.
 @return : whether it is successfully displayed.
 */
- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController;

@end

NS_ASSUME_NONNULL_END
