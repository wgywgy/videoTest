//
//  DQDRewardVideoHelper.m
//  AdDemo
//
//  Created by e on 2020/3/18.
//

#import "DQDRewardVideoHelper.h"
#import "DQRewardedVideoAd.h"

@interface DQDRewardVideoHelper () <DQRewardedVideoAdDelegate>

@property(nonatomic, strong) DQRewardedVideoAd *rewardVideoAd;

@end

@implementation DQDRewardVideoHelper

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static DQDRewardVideoHelper *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

- (void)preloadWithSlotId:(NSString *)slotId {
    self.rewardVideoAd = [[DQRewardedVideoAd alloc] initWithSlotID:slotId];
    self.rewardVideoAd.delegate = self;
    [self.rewardVideoAd loadAdData];
}

- (void)showAdWithSlotId:(NSString *)slotId {
    if (self.showBaseVC) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        [self.rewardVideoAd showAdFromRootViewController:self.showBaseVC];
    }
}

@end
