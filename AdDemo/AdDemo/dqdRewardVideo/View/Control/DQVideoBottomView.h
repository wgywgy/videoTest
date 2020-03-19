//
//  DQVideoBottomView.h
//  AdDemo
//
//  Created by e on 2020/3/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DQVideoBottomView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *adLabel;
@property (weak, nonatomic) IBOutlet UIImageView *adBanner;

@property(nonatomic, copy) void (^didTapBanner)(void);

@end

NS_ASSUME_NONNULL_END
