//
//  IOSpecialView.m
//  iOrder
//
//  Created by 易无解 on 4/22/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOSpecialView.h"

@interface IOSpecialView ()

@property (nonatomic, weak) UIImageView *weekendView;
@property (nonatomic, weak) UIImageView *dayView;
@property (nonatomic, weak) UIImageView *specialView;

@end

@implementation IOSpecialView

#pragma mark - privacy

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupAllChildView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat weekendW = YWJKeyWindow.width * 0.5 - 0.5;
    CGFloat weekendH = 100;
    CGFloat weekendX = 0;
    CGFloat weekendY = 0;
    _weekendView.frame = CGRectMake(weekendX, weekendY, weekendW, weekendH);
    
    CGFloat dayW = weekendW;
    CGFloat dayH = 49.5;
    CGFloat dayX = CGRectGetMaxX(_weekendView.frame) + 1.0;
    CGFloat dayY = 0;
    _dayView.frame = CGRectMake(dayX, dayY, dayW, dayH);
    
    CGFloat specialW = dayW;
    CGFloat specialH = dayH;
    CGFloat specialX = dayX;
    CGFloat specialY = CGRectGetMaxY(_dayView.frame) + 1.0;
    _specialView.frame = CGRectMake(specialX, specialY, specialW, specialH);
}

#pragma mark - public

- (void)setDatas:(NSArray *)datas{
    _datas = datas;
    
    _weekendView.image = [UIImage imageNamed:datas[0]];
    _dayView.image = [UIImage imageNamed:datas[1]];
    _specialView.image = [UIImage imageNamed:datas[2]];
}

#pragma mark - custom methods

- (void)setupAllChildView{
    UIImageView *weekendView = [[UIImageView alloc] init];
    weekendView.contentMode = UIViewContentModeCenter;
    [self addSubview:weekendView];
    weekendView.backgroundColor = [UIColor whiteColor];
    _weekendView = weekendView;
    
    UIImageView *dayView = [[UIImageView alloc] init];
    dayView.contentMode = UIViewContentModeCenter;
    [self addSubview:dayView];
    dayView.backgroundColor = [UIColor whiteColor];
    _dayView = dayView;
    
    UIImageView *specialView = [[UIImageView alloc] init];
    specialView.contentMode = UIViewContentModeCenter;
    [self addSubview:specialView];
    specialView.backgroundColor = [UIColor whiteColor];
    _specialView = specialView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
