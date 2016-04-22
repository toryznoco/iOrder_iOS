//
//  IOOrderHeaderView.m
//  iOrder
//
//  Created by 易无解 on 4/21/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOOrderHeaderView.h"

#import "IOScrollView.h"
#import "IOSpecialView.h"
#import "IOTitleView.h"

@interface IOOrderHeaderView ()

@property (nonatomic, weak) IOScrollView *scrollView;
@property (nonatomic, weak) IOSpecialView *specialView;
@property (nonatomic, weak) IOTitleView *titleView;

@end

@implementation IOOrderHeaderView

#pragma mark - privacy

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
//        设置headerView的大小
        self.width = YWJKeyWindow.bounds.size.width;
        self.height = 305;
        
        [self setupAllChildView];
    }
    return self;
}

- (void)layoutSubviews{
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
    CGFloat titleViewY = CGRectGetMaxY(_specialView.frame) + 10;
    _titleView.frame = CGRectMake(titleViewX, titleViewY, titleViewW, titleViewH);
}

#pragma mark - custom methods

- (void)setupAllChildView{
    IOScrollView *scrollView = [[IOScrollView alloc] init];
    [self addSubview:scrollView];
    _scrollView = scrollView;
    
    IOSpecialView *specialView = [[IOSpecialView alloc] init];
    [self addSubview:specialView];
    _specialView = specialView;
    
    IOTitleView *titleView = [[IOTitleView alloc] init];
    [self addSubview:titleView];
    _titleView = titleView;
}

@end
