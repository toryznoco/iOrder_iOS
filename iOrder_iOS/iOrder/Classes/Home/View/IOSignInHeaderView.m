//
//  IOSignInHeaderView.m
//  iOrder
//
//  Created by Tory on 16/5/18.
//  Copyright © 2016年 易无解. All rights reserved.
//

#import "IOSignInHeaderView.h"

@interface IOSignInHeaderView ()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *promptLabel;

@end

@implementation IOSignInHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupAllChildView];
    }
    return self;
}

- (void)setupAllChildView {
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;
    _iconView.image = [UIImage imageNamed:@"SignIn"];
    
    UILabel *promptLabel = [[UILabel alloc] init];
    [self addSubview:promptLabel];
    _promptLabel = promptLabel;
    _promptLabel.text = @"摇一摇签到~";
    _promptLabel.textAlignment = NSTextAlignmentCenter;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat iconX = (self.frame.size.width-kIOIconWidth)*0.5;
    CGFloat iconY = 64;
    CGFloat iconW = kIOIconWidth;
    CGFloat iconH = iconW;
    _iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat promptX = iconX;
    CGFloat promptY = CGRectGetMaxY(_iconView.frame)+kIOPromptTopMargin;
    CGFloat promptW = iconW;
    CGFloat promptH = kIOPromptHeight;
    _promptLabel.frame = CGRectMake(promptX, promptY, promptW, promptH);
}

@end
