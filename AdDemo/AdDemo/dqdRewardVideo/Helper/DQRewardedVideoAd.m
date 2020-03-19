//
//  DQRewardedVideoAd.m
//  AdDemo
//
//  Created by e on 2020/3/18.
//

#import "DQRewardedVideoAd.h"
#import "DQVideoMainViewController.h"

@interface DQRewardedVideoAd()
@property(nonatomic, strong) DQVideoMainViewController *videoMainViewController;
@property(nonatomic, copy) NSString *slotID;
@end

@implementation DQRewardedVideoAd

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithSlotID:(NSString *)slotID {
    self = [super init];
    if (self) {
        self.slotID = slotID;
        self.videoMainViewController = [[DQVideoMainViewController alloc] init];
    }
    return self;
}

- (void)loadAdData {
    
}

/**
 Display video ad.
 @param rootViewController : root view controller for displaying ad.
 @return : whether it is successfully displayed.
 */
- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController {
    if (!rootViewController) {
        return NO;
    }
    
    self.videoMainViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [rootViewController presentViewController:self.videoMainViewController animated:YES completion:nil];
    return YES;
}

@end
