//
//  IOHomeNavigationView.m
//  iOrder
//
//  Created by 易无解 on 5/20/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOHomeNavigationView.h"

#pragma mark - implementation IOHomeNavigationView

@interface IOHomeNavigationView ()

@property (nonatomic, weak) UIView *item;

@end

@implementation IOHomeNavigationView

#pragma mark - privacy
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupAllChildViewWithFrame:CGRectMake(0, 20, frame.size.width, 64)];
    }
    return self;
}

#pragma mark - custom method

- (void)setupAllChildViewWithFrame:(CGRect)frame {
    IOHomeNavigationItem *item = [[IOHomeNavigationItem alloc] initWithFrame:frame];
    _item = item;
    [self addSubview:item];
}

@end


#pragma mark - implementation IOHomeNavigationItem
@interface IOHomeNavigationItem ()

@property (nonatomic, weak) UIButton *cityBtn;
@property (nonatomic, weak) UIImageView *arrowImage;
@property (nonatomic, weak) UIButton *mapBtn;
@property (nonatomic, weak) UIView *searchView;
@property (nonatomic, weak) UIImageView *searchImage;
@property (nonatomic, weak) UILabel *placeHolderLabel;

@end

@implementation IOHomeNavigationItem

#pragma mark - privacy

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupAllChildView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_cityBtn sizeToFit];
    CGFloat cityBtnW = _cityBtn.width;
    CGFloat cityBtnH = _cityBtn.height;
    CGFloat cityBtnX = 10;
    CGFloat cityBtnY = 10;
    _cityBtn.frame = CGRectMake(cityBtnX, cityBtnY, cityBtnW, cityBtnH);
    
    CGFloat arrowImageW = 13;
    CGFloat arrowImageH = 10;
    CGFloat arrowImageX = CGRectGetMaxX(_cityBtn.frame);
    CGFloat arrowImageY = 18;
    _arrowImage.frame = CGRectMake(arrowImageX, arrowImageY, arrowImageW, arrowImageH);
    
    CGFloat mapBtnW = 42;
    CGFloat mapBtnH = 30;
    CGFloat mapBtnX = self.width - mapBtnW - 10;
    CGFloat mapBtnY = 20;
    _mapBtn.frame = CGRectMake(mapBtnX, mapBtnY, mapBtnW, mapBtnH);
    
    CGFloat searchViewW = 200;
    CGFloat searchViewH = 25;
    _searchImage.frame = CGRectMake(0, 0, searchViewW, searchViewH);
    _searchImage.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    
    CGFloat searchImageW = 15;
    CGFloat searchImageH = 15;
    CGFloat searchImageX = 5;
    CGFloat searchImageY = 3;
    _searchImage.frame = CGRectMake(searchImageX, searchImageY, searchImageW, searchImageH);
    
    CGFloat placeHolderW = 150;
    CGFloat placeHolderH = 25;
    CGFloat placeHolderX = 25;
    CGFloat placeHolderY = 0;
    _placeHolderLabel.frame = CGRectMake(placeHolderX, placeHolderY, placeHolderW, placeHolderH);
}

#pragma mark - custom method

- (void)setupAllChildView {
    UIButton *cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cityBtn.font = [UIFont systemFontOfSize:15];
    _cityBtn = cityBtn;
    [self addSubview:cityBtn];
    
    UIImageView *arrowImage = [[UIImageView alloc] init];
    [arrowImage setImage:[UIImage imageNamed:@"arrow"]];
    _arrowImage = arrowImage;
    [self addSubview:arrowImage];
    
    UIButton *mapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [mapBtn addTarget:self action:@selector(mapBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _mapBtn = mapBtn;
    [self addSubview:mapBtn];
    
    UIView *searchView = [[UIView alloc] init];
    searchView.backgroundColor = YWJRGBColor(7, 170, 153, 1);
    searchView.layer.masksToBounds = YES;
    searchView.layer.cornerRadius = 12;
    _searchView = searchView;
    [self addSubview:searchView];
    
    UIImageView *searchImage = [[UIImageView alloc] init];
    _searchImage = searchImage;
    [searchView addSubview:searchImage];
    
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.font = [UIFont boldSystemFontOfSize:13];
    placeHolderLabel.text = @"输入商家，品类";
    placeHolderLabel.textColor = [UIColor whiteColor];
    _placeHolderLabel = placeHolderLabel;
    [searchView addSubview:placeHolderLabel];
}

- (void)mapBtnClick:(UIButton *)btn {
    YWJLog(@"click mapBtnClick");
}

@end