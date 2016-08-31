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

@end

@implementation IOHomeHeaderView

#pragma mark - privacy

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
        
        [self setupAllChildView];
    }
    return self;
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
}

#pragma mark - masonry

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
        make.width.equalTo(self.superview);
        make.height.equalTo(@160);
    }];
    
    [self.specialView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_bottom).offset(10);
        make.left.equalTo(self);
        make.width.equalTo(self.superview);
        make.height.equalTo(@100);
    }];
    
    [super updateConstraints];
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
//    YWJLog(@"滑动到第几张图片");
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
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.backgroundColor = [UIColor clearColor];
        [self setupAllChildView];
    }
    return self;
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

#pragma mark - masonry

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.weekendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
        make.right.equalTo(self.mas_centerX).offset(-0.5);
        make.height.equalTo(@100);
    }];
    
    [self.dayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self);
        make.left.equalTo(self.mas_centerX).offset(0.5);
        make.bottom.equalTo(self.mas_centerY).offset(-0.5);
    }];
    
    [self.specialView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_centerY).offset(0.5);
        make.bottom.right.equalTo(self);
        make.left.equalTo(self.mas_centerX).offset(0.5);
    }];
    
    [super updateConstraints];
}

@end

