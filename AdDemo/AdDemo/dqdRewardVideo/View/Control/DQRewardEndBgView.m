//
//  DQRewardEndBgView.m
//  AdDemo
//
//  Created by e on 2020/3/18.
//

#import "DQRewardEndBgView.h"
@interface DQRewardEndBgView ()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@end

@implementation DQRewardEndBgView

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
    [[NSBundle mainBundle] loadNibNamed:@"DQRewardEndBgView" owner:self options:nil];
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
    
    
    [self setupUI];
}

- (void)setupUI {
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor yellowColor];
    
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelf)];
    [self addGestureRecognizer:tap];
}

- (void)tapSelf {
    if (self.didTapSelf) {
        self.didTapSelf();
    }
}

@end
