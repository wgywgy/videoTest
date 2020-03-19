//
//  DQDRewardVideoHelper.h
//  AdDemo
//
//  Created by e on 2020/3/18.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DQDRewardVideoHelper : NSObject

@property(nonatomic, weak) UIViewController *showBaseVC;

+ (instancetype)sharedInstance;

- (void)preloadWithSlotId:(NSString *)slotId;

- (void)showAdWithSlotId:(NSString *)slotId;

@end

NS_ASSUME_NONNULL_END
