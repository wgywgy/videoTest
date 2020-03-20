//
//  DQVideoTopView.m
//  AdDemo
//
//  Created by e on 2020/3/18.
//

#import "DQVideoTopView.h"
@interface DQVideoTopView ()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property(nonatomic, assign) BOOL pauseCount;

@property (nonatomic, strong) CAShapeLayer *txtLabelBorderLayer;

@end

@implementation DQVideoTopView
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [[NSBundle mainBundle] loadNibNamed:@"DQVideoTopView" owner:self options:nil];
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;

    [self setupUI];
}

- (void)setupUI {
    self.closeBtn.hidden = YES;
    self.skipBtn.hidden = YES;
    
    self.pauseCount = NO;
    self.elapseSecond = 0;
    
    self.countLabel.leftInset = 9;
    self.countLabel.rightInset = 9;
    self.countLabel.topInset = 8;
    self.countLabel.bottomInset = 8;
}

- (void)toggleMute:(BOOL)mute {
    self.isMute = mute;
    if (self.didTapMute) {
        self.didTapMute(mute);
    }
    [self setupMuteUI:self.isMute];
}

- (void)setupMuteUI:(BOOL)mute {
    if (mute) {
        [self.soundBtn setTitle:@"有声" forState:UIControlStateNormal];
    } else {
        [self.soundBtn setTitle:@"静音" forState:UIControlStateNormal];
    }
}

- (IBAction)didTapSoundBtn:(id)sender {
    self.isMute = !self.isMute;
    [self toggleMute:self.isMute];
}

- (IBAction)didTapSkipBtn:(id)sender {
    [self pauseCountDown];
    if (self.didTapSkip) {
        self.didTapSkip();
    }
}

- (IBAction)didTapCloseBtn:(id)sender {
    if (self.didTapClose) {
        self.didTapClose();
    }
}


- (void)resetState {
    
}

// countDown
- (void)startCountDown {
    NSLog(@"doing something …");
    [self changeToSkipStateIfNeed];
    
    if (self.pauseCount) {
        return;
    }
    
    if (self.countSecond > 0) {
//        [self.countDownBtn setTitle:[NSString stringWithFormat:@"%d", self.countSecond] forState:UIControlStateNormal];
        [self setCountLabelWithStr:[NSString stringWithFormat:@"%d", self.countSecond]];
        self.countSecond--;
        self.elapseSecond++;
        
        __weak typeof(self) weakSelf = self;
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [weakSelf startCountDown];
        });
    } else {
        [self changeToCloseState];
    }
}

- (void)pauseCountDown {
    self.pauseCount = YES;
}

- (void)continueCountDown {
    self.pauseCount = NO;
    [self startCountDown];
}

- (void)stopCountDown {
    self.pauseCount = YES;
}

- (void)changeToSkipStateIfNeed {
    if (self.elapseSecond >= 5) {
        [self changeToSkipState];
    }
}

- (void)changeToSkipState {
    self.skipBtn.hidden = NO;
}

- (void)changeToCloseState {
    self.countLabel.hidden = YES;
    self.skipBtn.hidden = YES;
    self.soundBtn.hidden = YES;
    self.closeBtn.hidden = NO;
    
    if (self.didEndCount) {
        self.didEndCount();
    }
}

- (void)setCountLabelWithStr:(NSString *)text {
    self.countLabel.text = text;
    [self.countLabel setNeedsLayout];
    [self.countLabel layoutIfNeeded];
    
    UIBezierPath *maskPath =
    [UIBezierPath bezierPathWithRoundedRect:self.countLabel.bounds
                          byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight
                                cornerRadii:CGSizeMake(13, 13)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.countLabel.bounds;
    maskLayer.path = maskPath.CGPath;
    self.countLabel.layer.mask = maskLayer;
    
    [self.txtLabelBorderLayer removeFromSuperlayer];
    self.txtLabelBorderLayer.path = maskPath.CGPath;
    
    self.txtLabelBorderLayer.frame = self.countLabel.bounds;
    [self.countLabel.layer addSublayer:self.txtLabelBorderLayer];
}

- (CAShapeLayer *)txtLabelBorderLayer {
    if (!_txtLabelBorderLayer) {
        _txtLabelBorderLayer = [CAShapeLayer new];
        _txtLabelBorderLayer.lineWidth = 1;
        _txtLabelBorderLayer.strokeColor = [UIColor whiteColor].CGColor;
        _txtLabelBorderLayer.fillColor = [UIColor clearColor].CGColor;
    }
    return _txtLabelBorderLayer;
}

@end
