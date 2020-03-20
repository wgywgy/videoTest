//
//  DQRVPaddingLabel.m
//  AdDemo
//
//  Created by e on 2020/3/20.
//

#import "DQRVPaddingLabel.h"

@implementation DQRVPaddingLabel

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = UIEdgeInsetsMake(_topInset, _leftInset, _bottomInset, _rightInset);
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

- (CGSize)intrinsicContentSize {
    CGSize contentSize = [super intrinsicContentSize];
    contentSize.height += _topInset + _bottomInset;
    contentSize.width += _leftInset + _rightInset;
    return contentSize;
}

@end
