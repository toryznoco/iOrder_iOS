//
//  IOHomeHeaderView.m
//  iOrder
//
//  Created by 易无解 on 5/17/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOHomeHeaderView.h"

#import "UIImageView+WebCache.h"
#import "SDCycleScrollView.h"

#pragma mark - implementation IOHomeHeaderView
@interface IOHomeHeaderView ()

@property (nonatomic, weak) IOScrollView *scrollView;
@property (nonatomic, weak) IOSpecialView *specialView;
@property (nonatomic, weak) IOTitleView *titleView;

@end

@implementation IOHomeHeaderView

#pragma mark - privacy

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
        //        设置headerView的大小
        self.width = YWJKeyWindow.bounds.size.width;
        self.height = 305;
        
        [self setupAllChildView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat scrollViewW = self.width;
    CGFloat scrollViewH = 160;
    CGFloat scrollViewX = 0;
    CGFloat scrollViewY = 0;
    _scrollView.frame = CGRectMake(scrollViewX, scrollViewY, scrollViewW, scrollViewH);
    
    CGFloat specialViewW = scrollViewW;
    CGFloat specialViewH = 100;
    CGFloat specialViewX = 0;
    CGFloat specialViewY = CGRectGetMaxY(_scrollView.frame) + 10;
    _specialView.frame = CGRectMake(specialViewX, specialViewY, specialViewW, specialViewH);
    
    CGFloat titleViewW = scrollViewW;
    CGFloat titleViewH = 25;
    CGFloat titleViewX = 0;
    CGFloat titleViewY = CGRectGetMaxY(_specialView.frame) + 9;
    _titleView.frame = CGRectMake(titleViewX, titleViewY, titleViewW, titleViewH);
}

#pragma mark - custom methods

- (void)setupAllChildView {
    NSArray *images = @[@"roll_image_1.png",
                        @"roll_image_2.png",
                        @"roll_image_3.png"];
    IOScrollView *scrollView = [[IOScrollView alloc] init];
    [self addSubview:scrollView];
    _scrollView = scrollView;
    _scrollView.images = images;
    
    NSArray *datas = @[@"weekend_bargain_image.png",
                       @"bargain_price_image.png",
                       @"new_products_image.png"];
    IOSpecialView *specialView = [[IOSpecialView alloc] init];
    [self addSubview:specialView];
    _specialView = specialView;
    _specialView.datas = datas;
    
    IOTitleView *titleView = [[IOTitleView alloc] init];
    [self addSubview:titleView];
    _titleView = titleView;
}

@end


#pragma mark - implementation IOScrollView
@interface IOScrollView ()<SDCycleScrollViewDelegate>

@property (nonatomic, weak) SDCycleScrollView *cycleScrollView;

@end

@implementation IOScrollView

#pragma mark - privacy

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:0.99];
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"005.jpg"]];
        backgroundView.frame = CGRectMake(0, 0, YWJKeyWindow.width, 160);
        [self addSubview:backgroundView];
        
        SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, YWJKeyWindow.width, 160) shouldInfiniteLoop:YES imageNamesGroup:nil];
        [self addSubview:cycleScrollView];
        _cycleScrollView = cycleScrollView;
        
        cycleScrollView.delegate = self;
        cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        cycleScrollView.autoScrollTimeInterval = 4.0;
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - public

- (void)setImages:(NSArray *)images {
    _images = images;
    
    _cycleScrollView.localizationImageNamesGroup = images;
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    YWJLog(@"点击了某张图片");
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    YWJLog(@"滑动到第几张图片");
}

@end


#pragma mark - implementation IOSpecialView
@interface IOSpecialView ()

@property (nonatomic, weak) UIImageView *weekendView;
@property (nonatomic, weak) UIImageView *dayView;
@property (nonatomic, weak) UIImageView *specialView;

@end

@implementation IOSpecialView

#pragma mark - privacy

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupAllChildView];
    }
    return self;
}

- (void)layoutSubviews {
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

- (void)setDatas:(NSArray *)datas {
    _datas = datas;
    
    _weekendView.image = [UIImage imageNamed:datas[0]];
    _dayView.image = [UIImage imageNamed:datas[1]];
    _specialView.image = [UIImage imageNamed:datas[2]];
}

#pragma mark - custom methods

- (void)setupAllChildView {
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

@end

#pragma mark - implementation IOTitleView
@interface IOTitleView ()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *title;

@end

@implementation IOTitleView

#pragma mark - privacy

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupAllChildView];
    }
    return self;
}

- (void)layoutSubviews {
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

- (void)setupAllChildView {
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

