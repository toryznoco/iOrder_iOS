//
//  IOSignInHeaderView.m
//  iOrder
//
//  Created by Tory on 16/5/18.
//  Copyright © 2016年 易无解. All rights reserved.
//

#import "IOSignInHeaderView.h"

//  尺寸
#define kIOPromptHeight 12
#define kIOPromptTopMargin 8

@interface IOSignInHeaderView ()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *promptLabel;

@end

@implementation IOSignInHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initAllChildView];
    }
    return self;
}

- (void)initAllChildView {
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;
    [self setupIconView];
    
    UILabel *promptLabel = [[UILabel alloc] init];
    [self addSubview:promptLabel];
    _promptLabel = promptLabel;
    [self setupPromptLabel];
}

- (void)setupIconView {
    _iconView.image = [UIImage imageNamed:@"SignIn"];
    _iconView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)setupPromptLabel {
    _promptLabel.text = @"摇一摇签到~";
    _promptLabel.textAlignment = NSTextAlignmentCenter;
    _promptLabel.font = [UIFont systemFontOfSize:13];
    _promptLabel.textColor = [UIColor colorWithRed:120.0/255.0 green:120.0/255.0 blue:120.0/255.0 alpha:1.0];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat iconW = self.frame.size.height-kIOPromptHeight-2*kIOPromptTopMargin;
    CGFloat iconX = (self.frame.size.width-iconW)*0.5;
    CGFloat iconY = 0;
    CGFloat iconH = iconW;
    _iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat promptX = iconX;
    CGFloat promptY = self.frame.size.height-kIOPromptHeight-kIOPromptTopMargin;
    CGFloat promptW = iconW;
    CGFloat promptH = kIOPromptHeight;
    _promptLabel.frame = CGRectMake(promptX, promptY, promptW, promptH);
}

@end
