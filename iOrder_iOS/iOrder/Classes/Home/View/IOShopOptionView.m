//
//  IOShopOptionView.m
//  iOrder
//
//  Created by 易无解 on 5/17/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOShopOptionView.h"

#pragma mark - implementation IOShopOptionView
@interface IOShopOptionView ()

@property (nonatomic, strong) NSMutableArray *optionBtns;
@property (nonatomic, strong) NSMutableArray *seletedTags;

@end

@implementation IOShopOptionView

#pragma mark - privacy
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self optionBtns];
        [self seletedTags];
        [self setupChildViewWithFrame:frame];
    }
    return self;
}

- (NSMutableArray *)optionBtns {
    if (!_optionBtns) {
        _optionBtns = [NSMutableArray array];
    }
    return _optionBtns;
}

- (NSMutableArray *)seletedTags {
    if (!_seletedTags) {
        _seletedTags = [NSMutableArray array];
    }
    return _seletedTags;
}

#pragma mark - custom methods

- (void)setupChildViewWithFrame:(CGRect)frame {
    CGFloat optionViewH = frame.size.width / 3.0;
    
    UIView *optionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, optionViewH, frame.size.height)];
    [self addSubview:optionView];
    [optionView addSubview:[self optionBtnWithRect:CGRectMake(0, 0, optionView.frame.size.width, optionView.frame.size.height) tag:1 title:@"点菜"]];
    UIView *selectedTag = [self selectedViewWithRect:CGRectMake(0, 36, optionView.frame.size.width, 4) tag:1];
    selectedTag.hidden = NO;
    [optionView addSubview:selectedTag];
    
    UIView *optionView1 = [[UIView alloc] initWithFrame:CGRectMake(optionViewH, 0, optionViewH, frame.size.height)];
    [self addSubview:optionView1];
    [optionView1 addSubview:[self optionBtnWithRect:CGRectMake(0, 0, optionView1.frame.size.width, optionView1.frame.size.height) tag:2 title:@"评价"]];
    [optionView1 addSubview:[self selectedViewWithRect:CGRectMake(0, 36, optionView1.frame.size.width, 4) tag:2]];
    
    UIView *optionView2 = [[UIView alloc] initWithFrame:CGRectMake(2 * optionViewH, 0, optionViewH, frame.size.height)];
    [self addSubview:optionView2];
    [optionView2 addSubview:[self optionBtnWithRect:CGRectMake(0, 0, optionView2.frame.size.width, optionView2.frame.size.height) tag:3 title:@"商家"]];
    [optionView2 addSubview:[self selectedViewWithRect:CGRectMake(0, 36, optionView2.frame.size.width, 4) tag:3]];
}

- (UIButton *)optionBtnWithRect:(CGRect)frame tag:(NSInteger)tag title:(NSString *)title {
    UIButton *optionBtn = [[UIButton alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
    [_optionBtns addObject:optionBtn];
    [optionBtn addTarget:self action:@selector(optionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    optionBtn.tag = tag;
    [optionBtn setTitle:title forState:UIControlStateNormal];
    [optionBtn setTitleColor:YWJRGBColor(92, 91, 92, 1) forState:UIControlStateNormal];
    [optionBtn setTitleColor:YWJRGBColor(35, 35, 35, 1) forState:UIControlStateHighlighted];
    return optionBtn;
}

- (UIView *)selectedViewWithRect:(CGRect)frame tag:(NSInteger)tag {
    UIView *selectedTag = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
    [_seletedTags addObject:selectedTag];
    selectedTag.tag = tag;
    selectedTag.hidden = YES;
    selectedTag.backgroundColor = [UIColor orangeColor];
    return selectedTag;
}

- (void)optionBtnClick:(UIButton *)btn {
    for (UIView *selected in _seletedTags) {
        if (btn.tag == selected.tag) {
            selected.hidden = NO;
        }else{
            selected.hidden = YES;
        }
    }
    YWJLog(@"click %ld", btn.tag);
}

@end