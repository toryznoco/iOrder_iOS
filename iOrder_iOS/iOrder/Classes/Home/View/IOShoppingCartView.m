//
//  IOShoppingCartView.m
//  iOrder
//
//  Created by 易无解 on 5/8/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOShoppingCartView.h"

#define kScale 0.25

#define kBadgeViewFont [UIFont systemFontOfSize:11]


#pragma mark - implementation IOBadgeView
@implementation IOBadgeView

#pragma mark - privacy

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = NO;
        
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        
        self.titleLabel.font = kBadgeViewFont;
        [self sizeToFit];
    }
    return self;
}

#pragma mark - public

- (void)setBadgeValue:(NSString *)badgeValue {
    _badgeValue = badgeValue;
    
    // 判断badgeValue是否有内容
    if (badgeValue.length == 0 || [badgeValue isEqualToString:@"0"]) {
        self.hidden = YES;
        return;
    } else {
        self.hidden = NO;
    }
    
    NSMutableDictionary *badgeAtt = [NSMutableDictionary dictionary];
    badgeAtt[NSFontAttributeName] = kBadgeViewFont;
    CGSize size = [badgeValue sizeWithAttributes:badgeAtt];
    
    if (size.width > self.width) {// 文字的尺寸大于控件的宽度
        [self setImage:[UIImage imageNamed:@"new_dot"] forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
        [self setBackgroundImage:nil forState:UIControlStateNormal];
    } else {
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        [self setTitle:badgeValue forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
    }
}

@end


#pragma mark - implementation IOShoppingCartView
@implementation IOShoppingCartView

#pragma mark - privacy

- (instancetype)initWithFrame:(CGRect)frame {
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

- (void)setupAllChildViewWith:(CGRect)frame {
    UIButton *shoppingCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shoppingCarBtn.enabled = NO;
    shoppingCarBtn.frame = CGRectMake(25, 0, 44, 44);
    shoppingCarBtn.layer.cornerRadius = 17;
    shoppingCarBtn.clipsToBounds = YES;
    [shoppingCarBtn setImage:[UIImage imageNamed:@"shopping_car"] forState:UIControlStateDisabled];
    [shoppingCarBtn setImage:[UIImage imageNamed:@"shopping_car_heilighted"] forState:UIControlStateNormal];
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
    [checkOutBtn addTarget:self action:@selector(clickedCheckOut:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - public

#pragma mark - custom method

- (void)clickedCheckOut:(UIButton *)btn {
    YWJLog(@"点击 结账按钮");
    if ([self.delegate respondsToSelector:@selector(shoppingCartView:checkOutBtnClick:)]) {
        [self.delegate shoppingCartView:self checkOutBtnClick:btn];
    }
}

@end

