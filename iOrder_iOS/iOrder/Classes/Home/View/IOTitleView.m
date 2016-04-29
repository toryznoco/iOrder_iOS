//
//  IOTitleView.m
//  iOrder
//
//  Created by 易无解 on 4/22/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOTitleView.h"

@interface IOTitleView ()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *title;

@end

@implementation IOTitleView

#pragma mark - privacy

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupAllChildView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat iconW = 21;
    CGFloat iconH = 21;
    CGFloat iconX = 10;
    CGFloat iconY = 2;
    _iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat titleW = _title.width;
    CGFloat titleH = _title.height;
    CGFloat titleX = CGRectGetMaxX(_iconView.frame) + 10;
    CGFloat titleY = 3;
    _title.frame = CGRectMake(titleX, titleY, titleW, titleH);
}

#pragma mark - custom methods

- (void)setupAllChildView{
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;
    
    _iconView.image = [UIImage imageNamed:@"store_image"];
    
    UILabel *title = [[UILabel alloc] init];
    [self addSubview:title];
    title.text = @"附近商家";
    title.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    title.font = [UIFont systemFontOfSize:15];
    [title sizeToFit];
    _title = title;
}

@end
