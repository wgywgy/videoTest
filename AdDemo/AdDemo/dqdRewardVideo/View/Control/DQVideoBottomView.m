//
//  DQVideoBottomView.m
//  AdDemo
//
//  Created by e on 2020/3/18.
//

#import "DQVideoBottomView.h"
@interface DQVideoBottomView ()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@end

@implementation DQVideoBottomView

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
    [[NSBundle mainBundle] loadNibNamed:@"DQVideoBottomView" owner:self options:nil];
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
    
    
    [self setupUI];
}

- (void)setupUI {
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    self.adLabel.backgroundColor = [UIColor lightGrayColor];
    self.adBanner.backgroundColor = [UIColor grayColor];
    
    self.adBanner.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBanner)];
    [self.adBanner addGestureRecognizer:tap];
}

- (void)tapBanner {
    if (self.didTapBanner) {
        self.didTapBanner();
    }
}

@end
