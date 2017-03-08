//
//  IOSignInFooterView.m
//  iOrder
//
//  Created by Tory on 16/5/23.
//  Copyright © 2016年 易无解. All rights reserved.
//

#import "IOSignInFooterView.h"

//  尺寸
#define kIOFooterViewDetailWidth 300
#define kIOTitleLabelHeight 13
#define kIODetailLabelHeight 30
#define kIOTitleTopMargin 8
#define kIODetailTopMargin 3

//  字体


@interface IOSignInFooterView ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *detailLabel;

@end

@implementation IOSignInFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initAllChildView];
    }
    return self;
}

- (void)initAllChildView {
    UILabel *titleLabel = [[UILabel alloc] init];
    [self addSubview:titleLabel];
    _titleLabel = titleLabel;
    [self setupTitleLabel];
    
    UILabel *detailLabel = [[UILabel alloc] init];
    [self addSubview:detailLabel];
    _detailLabel = detailLabel;
    [self setupDetailLabel];
}

- (void)setupTitleLabel {
    _titleLabel.text = @"活动规则";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:13];
    _titleLabel.textColor = [UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:1.0];
}

- (void)setupDetailLabel {
    _detailLabel.text = @"每日只能签到一次，必须在iBeacon识别区域内才可签到，签到达到一定次数可以获得优惠券，最终解释权归iOrder所有。";
    _detailLabel.font = [UIFont systemFontOfSize:11];
    _detailLabel.numberOfLines = 0;
    _detailLabel.textColor = [UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:1.0];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat titileX = 0;
    CGFloat titileY = kIOTitleTopMargin;
    CGFloat titileW = IOScreenWidth;
    CGFloat titileH = kIOTitleLabelHeight;
    _titleLabel.frame = CGRectMake(titileX, titileY, titileW, titileH);
    
    CGFloat detailX = (IOScreenWidth-kIOFooterViewDetailWidth)*0.5;
    CGFloat detailY = CGRectGetMaxY(_titleLabel.frame)+kIODetailTopMargin;
    CGFloat detailW = kIOFooterViewDetailWidth;
    CGFloat detailH = kIODetailLabelHeight;
    _detailLabel.frame = CGRectMake(detailX, detailY, detailW, detailH);
}

@end
