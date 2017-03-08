//
//  IOSubmitOrderView.m
//  iOrder
//
//  Created by 易无解 on 5/25/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOSubmitOrderView.h"

#define kScale 0.25

#pragma mark - implementation IOSubmitOrderView

@interface IOSubmitOrderView ()

@property (nonatomic, weak) UILabel *totalPrice;
@property (nonatomic, weak) UIView *submitView;
@property (nonatomic, weak) UIButton *submitBtn;

@end
@implementation IOSubmitOrderView

#pragma mark - privacy

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupAllChildView];
    }
    return self;
}

#pragma mark - public

- (void)setPrice:(NSString *)price {
    _price = price;
    
    _totalPrice.text = price;
}

#pragma mark - custom methods

- (void)setupAllChildView {
    UIView *submitView = [[UIView alloc] init];
    submitView.frame = CGRectMake(self.width * (1 - kScale), 0, self.width * kScale, 44);
    submitView.backgroundColor = kIOThemeColors;
    [self addSubview:submitView];
    _submitView = submitView;
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _submitBtn = submitBtn;
    [submitView addSubview:submitBtn];
    [submitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    CGPoint center = CGPointMake(submitView.width * 0.5, submitView.height * 0.5);
    [submitBtn sizeToFit];
    submitBtn.center = center;
    [submitBtn addTarget:self action:@selector(submitBtnclicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *totalPrice = [[UILabel alloc] initWithFrame:CGRectMake(submitView.x - 70, 14, 70, 14)];
    totalPrice.textColor = kIOThemeColors;
    totalPrice.font = [UIFont systemFontOfSize:17];
    _totalPrice = totalPrice;
    [self addSubview:totalPrice];
    
    UILabel *priceDescri = [[UILabel alloc] initWithFrame:CGRectMake(totalPrice.x - 5 - 50, 14, 50, 14)];
    priceDescri.textAlignment = NSTextAlignmentRight;
    priceDescri.font = [UIFont systemFontOfSize:13];
    priceDescri.text = @"待支付";
    [self addSubview:priceDescri];
}

- (void)submitBtnclicked:(UIButton *)btn {
    if ([_delegate respondsToSelector:@selector(submitOrderView:submitClicked:)]) {
        [_delegate submitOrderView:self submitClicked:btn];
    }
}

@end
