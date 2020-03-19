//
//  ViewController.m
//  AdDemo
//
//  Created by e on 2020/3/18.
//

#import "ViewController.h"
#import "DQDRewardVideoHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)preLoad:(id)sender {
    [[DQDRewardVideoHelper sharedInstance] preloadWithSlotId:@"3333"];
}

- (IBAction)showAd:(id)sender {
    [DQDRewardVideoHelper sharedInstance].showBaseVC = self;
    [[DQDRewardVideoHelper sharedInstance] showAdWithSlotId:@"3333"];
}

@end
