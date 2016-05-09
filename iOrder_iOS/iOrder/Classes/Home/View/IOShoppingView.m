//
//  IOShoppingView.m
//  iOrder
//
//  Created by 易无解 on 5/8/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOShoppingView.h"

#define kScale 0.25

@implementation IOShoppingView

#pragma mark - privacy

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        CALayer *back = [CALayer layer];
        back.frame = CGRectMake(0, 10, frame.size.width, 44);
        back.backgroundColor = YWJRGBColor(238, 240, 241, 1).CGColor;
        [self.layer addSublayer:back];
        [self setupAllChildViewWith:frame];
    }
    return self;
}

- (void)setupAllChildViewWith:(CGRect)frame{
    UIButton *shoppingCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shoppingCarBtn.enabled = NO;
    shoppingCarBtn.frame = CGRectMake(25, 0, 44, 44);
    shoppingCarBtn.layer.cornerRadius = 17;
    shoppingCarBtn.clipsToBounds = YES;
    [shoppingCarBtn setImage:[UIImage imageNamed:@"1"] forState:UIControlStateDisabled];
    [shoppingCarBtn setImage:[UIImage imageNamed:@"barbecue_image"] forState:UIControlStateNormal];
    [self addSubview:shoppingCarBtn];
    _shoppingCarBtn = shoppingCarBtn;
    
    
    IOBadgeView *badge = [[IOBadgeView alloc] init];
    badge.x = CGRectGetMaxX(shoppingCarBtn.frame) - 14;
    _badge = badge;
    _badge.badgeValue = @"0";
    [self addSubview:badge];
    
    UILabel *totalPrice = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(shoppingCarBtn.frame) + 5, 24, 200, 14)];
    totalPrice.textColor = [UIColor lightGrayColor];
    totalPrice.font = [UIFont systemFontOfSize:17];
    totalPrice.text = @"购物车是空的";
    _totalPrice = totalPrice;
    [self addSubview:totalPrice];
    
    UIView *checkOutView = [[UIView alloc] init];
    checkOutView.frame = CGRectMake(frame.size.width * (1 - kScale), 10, frame.size.width * kScale, 44);
    checkOutView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:checkOutView];
    _checkOutView = checkOutView;
    
    UIButton *checkOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _checkOutBtn = checkOutBtn;
    checkOutBtn.enabled = NO;
    [checkOutView addSubview:checkOutBtn];
    [checkOutBtn setTitle:@"去结算" forState:UIControlStateNormal];
    CGPoint center = CGPointMake(checkOutView.width * 0.5, checkOutView.height * 0.5);
    [checkOutBtn sizeToFit];
    checkOutBtn.center = center;
    [checkOutBtn addTarget:self action:@selector(clickedCheckOut) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - public

#pragma mark - custom method

- (void)clickedCheckOut{
    YWJLog(@"点击 结账按钮");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
