//
//  IOHomeShopHeaderView.m
//  iOrder
//
//  Created by 易无解 on 5/13/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOHomeShopHeaderView.h"

#pragma mark - implementation IOHomeShopHeaderView
@implementation IOHomeShopHeaderView

#pragma mark - privacy
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor greenColor];
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"005"]];
        
        [self setupChildViewWithFrame:frame];
    }
    return self;
}

#pragma mark - custom methods
- (void)setupChildViewWithFrame:(CGRect)frame{
    IOHomeShopInfoView *infoView = [[IOHomeShopInfoView alloc] initWithFrame:CGRectMake(0, 64, frame.size.width, 72)];
    [self addSubview:infoView];
    
    IOHomeShopOptionView *optionView = [[IOHomeShopOptionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(infoView.frame), frame.size.width, 40)];
    [self addSubview:optionView];
}

@end


#pragma mark - implementation IOHomeShopInfoView
@implementation IOHomeShopInfoView

#pragma mark - privacy
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

@end


#pragma mark - implementation IOHomeShopOptionView
@interface IOHomeShopOptionView ()

@property (nonatomic, strong) NSMutableArray *optionBtns;
@property (nonatomic, strong) NSMutableArray *seletedTags;

@end

@implementation IOHomeShopOptionView

#pragma mark - privacy
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self optionBtns];
        [self seletedTags];
        [self setupChildViewWithFrame:frame];
    }
    return self;
}

- (NSMutableArray *)optionBtns{
    if (!_optionBtns) {
        _optionBtns = [NSMutableArray array];
    }
    return _optionBtns;
}

- (NSMutableArray *)seletedTags{
    if (!_seletedTags) {
        _seletedTags = [NSMutableArray array];
    }
    return _seletedTags;
}

#pragma mark - custom methods

- (void)setupChildViewWithFrame:(CGRect)frame{
    CGFloat optionViewH = frame.size.width / 3.0;
    
    UIView *optionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, optionViewH, frame.size.height)];
    [self addSubview:optionView];
    [optionView addSubview:[self optionBtnWithRect:CGRectMake(0, 0, optionView.frame.size.width, optionView.frame.size.height) tag:1 title:@"点菜"]];
    [optionView addSubview:[self selectedViewWithRect:CGRectMake(0, 36, optionView.frame.size.width, 4) tag:1]];
    
    UIView *optionView1 = [[UIView alloc] initWithFrame:CGRectMake(optionViewH, 0, optionViewH, frame.size.height)];
    [self addSubview:optionView1];
    [optionView1 addSubview:[self optionBtnWithRect:CGRectMake(0, 0, optionView1.frame.size.width, optionView1.frame.size.height) tag:2 title:@"评价"]];
    [optionView1 addSubview:[self selectedViewWithRect:CGRectMake(0, 36, optionView1.frame.size.width, 4) tag:2]];
    
    UIView *optionView2 = [[UIView alloc] initWithFrame:CGRectMake(2 * optionViewH, 0, optionViewH, frame.size.height)];
    [self addSubview:optionView2];
    [optionView2 addSubview:[self optionBtnWithRect:CGRectMake(0, 0, optionView2.frame.size.width, optionView2.frame.size.height) tag:3 title:@"商家"]];
    [optionView2 addSubview:[self selectedViewWithRect:CGRectMake(0, 36, optionView2.frame.size.width, 4) tag:3]];
}

- (UIButton *)optionBtnWithRect:(CGRect)frame tag:(NSInteger)tag title:(NSString *)title{
    UIButton *optionBtn = [[UIButton alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
    [_optionBtns addObject:optionBtn];
    [optionBtn addTarget:self action:@selector(optionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    optionBtn.tag = tag;
    [optionBtn setTitle:title forState:UIControlStateNormal];
    [optionBtn setTitleColor:YWJRGBColor(92, 91, 92, 1) forState:UIControlStateNormal];
    [optionBtn setTitleColor:YWJRGBColor(35, 35, 35, 1) forState:UIControlStateHighlighted];
    return optionBtn;
}

- (UIView *)selectedViewWithRect:(CGRect)frame tag:(NSInteger)tag{
    UIView *selectedTag = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
    [_seletedTags addObject:selectedTag];
    selectedTag.hidden = YES;
    selectedTag.backgroundColor = [UIColor orangeColor];
    return selectedTag;
}

- (void)optionBtnClick:(UIButton *)btn{
    YWJLog(@"click %ld", btn.tag);
}

@end