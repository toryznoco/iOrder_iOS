//
//  IOOrderCell.m
//  iOrder
//
//  Created by Tory on 31/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOOrderCell.h"
#import "UIImageView+WebCache.h"

@implementation IOOrderTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
        frame.size.height = kIOCellTitleHeight;
    }
    self = [super initWithFrame:frame];
    
    UIImageView *shopIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"store_icon"]];
    shopIcon.left = kIOCellPadding;
    shopIcon.top = (kIOCellTitleHeight-shopIcon.height)/2;
    [self addSubview:shopIcon];
    
    _shopNameLabel = [YYLabel new];
    _shopNameLabel.size = CGSizeMake(kIOCellShopNameWidth, 24);
    _shopNameLabel.left = shopIcon.right + kIOCellShopNameMarginLeft;
    _shopNameLabel.centerY = shopIcon.centerY;
    [self addSubview:_shopNameLabel];
    _shopNameLabel.font = kIOCellFont;
    
    _statusLabel = [YYLabel new];
    _statusLabel.size = CGSizeMake(kIOCellStatusWidth, 24);
    _statusLabel.centerY = _shopNameLabel.centerY;
    _statusLabel.right = kScreenWidth - kIOCellStatusMarginRight;
    [self addSubview:_statusLabel];
    _statusLabel.font = kIOCellFont;
    _statusLabel.textAlignment = NSTextAlignmentCenter;
    _statusLabel.textColor = kIOThemeColor;
    
    return self;
}

@end

@implementation IOOrderInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = IOScreenWidth;
        frame.size.height = kIOCellInfoHeight;
    }
    self = [super initWithFrame:frame];
    
    CALayer *separator = [CALayer layer];
    separator.frame = CGRectMake(0, 0, IOScreenWidth, 1);
    [self.layer addSublayer:separator];
    separator.backgroundColor = kIOLineColor.CGColor;
    
    /** 店铺Icon */
    _shopIconView = [UIImageView new];
    _shopIconView.size = CGSizeMake(kIOCellIconWidth, kIOCellIconWidth);
    _shopIconView.origin = CGPointMake(kIOCellShopNameMarginLeft, kIOCellPadding);
    _shopIconView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_shopIconView];
    _shopIconView.clipsToBounds = YES;
    
    /** 菜品数量Label */
    _goodsAmountLabel = [YYLabel new];
    _goodsAmountLabel.size = CGSizeMake(kIOCellOrderLabelWidth, kIOCellOrderLabelHeight);
    _goodsAmountLabel.origin = CGPointMake(_shopIconView.right + kIOCellOrderLabelMarginLeft, _shopIconView.top);
    [self addSubview:_goodsAmountLabel];
    _goodsAmountLabel.font = kIOCellFont;
    _goodsAmountLabel.text = @"菜品数量：";
    
    /** 菜品数量 */
    _goodsAmount = [YYLabel new];
    _goodsAmount.size = CGSizeMake(kIOCellOrderWidth, kIOCellOrderLabelHeight);
    _goodsAmount.origin = CGPointMake(_goodsAmountLabel.right + kIOCellPadding, _goodsAmountLabel.top);
    [self addSubview:_goodsAmount];
    _goodsAmount.font = kIOCellFont;
    
    /** 总价Label */
    _priceLabel = [YYLabel new];
    _priceLabel.size = CGSizeMake(_goodsAmountLabel.width, _goodsAmountLabel.height);
    _priceLabel.origin = CGPointMake(_goodsAmountLabel.left, _goodsAmountLabel.bottom + kIOCellOrderLabelMarginTop);
    [self addSubview:_priceLabel];
    _priceLabel.font = kIOCellFont;
    _priceLabel.text = @"订单总价：";
    
    /** 总价 */
    _price = [YYLabel new];
    _price.size = CGSizeMake(_goodsAmount.width, _priceLabel.height);
    _price.origin = CGPointMake(_goodsAmount.left, _priceLabel.top);
    [self addSubview:_price];
    _price.font = kIOCellFont;
    
    /** 下单时间Label */
    _orderTimeLabel = [YYLabel new];
    _orderTimeLabel.size = CGSizeMake(_priceLabel.width, _priceLabel.height);
    _orderTimeLabel.origin = CGPointMake(_goodsAmountLabel.left, _priceLabel.bottom + kIOCellOrderLabelMarginTop);
    [self addSubview:_orderTimeLabel];
    _orderTimeLabel.font = kIOCellFont;
    _orderTimeLabel.text = @"下单时间：";
    
    /** 下单时间 */
    _orderTime = [YYLabel new];
    _orderTime.size = CGSizeMake(_price.width, _orderTimeLabel.height);
    _orderTime.origin = CGPointMake(_goodsAmount.left, _orderTimeLabel.top);
    [self addSubview:_orderTime];
    _orderTime.font = kIOCellFont;
    
    return self;
}

@end

@implementation IOOrderSubmitedBarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = IOScreenWidth;
        frame.size.height = kIOCellBarHeight;
    }
    self = [super initWithFrame:frame];
    
    CALayer *separator = [CALayer layer];
    separator.frame = CGRectMake(0, 0, IOScreenWidth, 1);
    [self.layer addSublayer:separator];
    separator.backgroundColor = kIOLineColor.CGColor;
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.size = CGSizeMake(kIOCellButtonWidth, kIOCellBarHeight - 2*kIOCellButtonMarginTop);
    _cancelBtn.right = IOScreenWidth - kIOCellButtonMarginRight;
    _cancelBtn.top = kIOCellButtonMarginTop;
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(cancelBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancelBtn];
    _cancelBtn.titleLabel.font = kIOCellFont;
    [_cancelBtn setTitleColor:kIOThemeColor forState:UIControlStateNormal];
    
    _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _payBtn.size = CGSizeMake(kIOCellButtonWidth, _cancelBtn.height);
    _payBtn.right = _cancelBtn.left - kIOCellButtonMarginRight;
    _payBtn.top = _cancelBtn.top;
    [_payBtn setTitle:@"去支付" forState:UIControlStateNormal];
    [_payBtn addTarget:self action:@selector(payBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_payBtn];
    _payBtn.titleLabel.font = kIOCellFont;
    [_payBtn setTitleColor:kIOThemeColor forState:UIControlStateNormal];
    
    return self;
}

- (void)cancelBtnDidClick:(UIButton *)btn {
    if (self.cell.delegate && [self.cell.delegate respondsToSelector:@selector(cancelBtnDidClick:)]) {
        [self.cell.delegate performSelector:@selector(cancelBtnDidClick:) withObject:btn];
    }
}

- (void)payBtnDidClick:(UIButton *)btn {
    if (self.cell.delegate && [self.cell.delegate respondsToSelector:@selector(payBtnDidClick:)]) {
        [self.cell.delegate performSelector:@selector(payBtnDidClick:) withObject:btn];
    }
}

@end

@implementation IOOrderPaidBarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = IOScreenWidth;
        frame.size.height = kIOCellBarHeight;
    }
    self = [super initWithFrame:frame];
    
    CALayer *separator = [CALayer layer];
    separator.frame = CGRectMake(0, 0, IOScreenWidth, 1);
    [self.layer addSublayer:separator];
    separator.backgroundColor = kIOLineColor.CGColor;
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.size = CGSizeMake(kIOCellButtonWidth, kIOCellBarHeight - 2*kIOCellButtonMarginTop);
    _cancelBtn.right = IOScreenWidth - kIOCellButtonMarginRight;
    _cancelBtn.top = kIOCellButtonMarginTop;
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(cancelBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancelBtn];
    _cancelBtn.titleLabel.font = kIOCellFont;
    [_cancelBtn setTitleColor:kIOThemeColor forState:UIControlStateNormal];
    
    return self;
}

- (void)cancelBtnDidClick:(UIButton *)btn {
    if (self.cell.delegate && [self.cell.delegate respondsToSelector:@selector(cancelBtnDidClick:)]) {
        [self.cell.delegate performSelector:@selector(cancelBtnDidClick:) withObject:btn];
    }
}

@end

@implementation IOOrderCookingBarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = IOScreenWidth;
        frame.size.height = kIOCellBarHeight;
    }
    self = [super initWithFrame:frame];
    
    CALayer *separator = [CALayer layer];
    separator.frame = CGRectMake(0, 0, IOScreenWidth, 1);
    [self.layer addSublayer:separator];
    separator.backgroundColor = kIOLineColor.CGColor;
    
    _alertBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _alertBtn.size = CGSizeMake(kIOCellButtonWidth, kIOCellBarHeight - 2*kIOCellButtonMarginTop);
    _alertBtn.right = IOScreenWidth - kIOCellButtonMarginRight;
    _alertBtn.top = kIOCellButtonMarginTop;
    [_alertBtn setTitle:@"催单" forState:UIControlStateNormal];
    [_alertBtn addTarget:self action:@selector(alertBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_alertBtn];
    _alertBtn.titleLabel.font = kIOCellFont;
    [_alertBtn setTitleColor:kIOThemeColor forState:UIControlStateNormal];
    return self;
}

- (void)alertBtnDidClick:(UIButton *)btn {
    if (self.cell.delegate && [self.cell.delegate respondsToSelector:@selector(alertBtnDidClick:)]) {
        [self.cell.delegate performSelector:@selector(alertBtnDidClick:) withObject:btn];
    }
}

@end

@implementation IOOrderCookedBarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = IOScreenWidth;
        frame.size.height = kIOCellBarHeight;
    }
    self = [super initWithFrame:frame];
    
    CALayer *separator = [CALayer layer];
    separator.frame = CGRectMake(0, 0, IOScreenWidth, 1);
    [self.layer addSublayer:separator];
    separator.backgroundColor = kIOLineColor.CGColor;
    
    _getBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _getBtn.size = CGSizeMake(kIOCellButtonWidth, kIOCellBarHeight - 2*kIOCellButtonMarginTop);
    _getBtn.right = IOScreenWidth - kIOCellButtonMarginRight;
    _getBtn.top = kIOCellButtonMarginTop;
    [_getBtn setTitle:@"取餐" forState:UIControlStateNormal];
    [_getBtn addTarget:self action:@selector(getBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_getBtn];
    _getBtn.titleLabel.font = kIOCellFont;
    [_getBtn setTitleColor:kIOThemeColor forState:UIControlStateNormal];
    return self;
}

- (void)getBtnDidClick:(UIButton *)btn {
    if (self.cell.delegate && [self.cell.delegate respondsToSelector:@selector(getBtnDidClick:)]) {
        [self.cell.delegate performSelector:@selector(getBtnDidClick:) withObject:btn];
    }
}

@end

@implementation IOOrderReceiptBarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = IOScreenWidth;
        frame.size.height = kIOCellBarHeight;
    }
    self = [super initWithFrame:frame];
    
    CALayer *separator = [CALayer layer];
    separator.frame = CGRectMake(0, 0, IOScreenWidth, 1);
    [self.layer addSublayer:separator];
    separator.backgroundColor = kIOLineColor.CGColor;
    
    _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentBtn.size = CGSizeMake(kIOCellButtonWidth, kIOCellBarHeight - 2*kIOCellButtonMarginTop);
    _commentBtn.right = IOScreenWidth - kIOCellButtonMarginRight;
    _commentBtn.top = kIOCellButtonMarginTop;
    [_commentBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_commentBtn addTarget:self action:@selector(commentBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_commentBtn];
    _commentBtn.titleLabel.font = kIOCellFont;
    [_commentBtn setTitleColor:kIOThemeColor forState:UIControlStateNormal];
    return self;
}

- (void)commentBtnDidClick:(UIButton *)btn {
    if (self.cell.delegate && [self.cell.delegate respondsToSelector:@selector(commentBtnDidClick:)]) {
        [self.cell.delegate performSelector:@selector(commentBtnDidClick:) withObject:btn];
    }
}

@end

@implementation IOOrderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = IOScreenWidth;
        frame.size.height = 1;
    }
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    self.exclusiveTouch = YES;
    
    _contentView = [UIView new];
    _contentView.width = IOScreenWidth;
    _contentView.height = 1;
    _contentView.backgroundColor = [UIColor whiteColor];
    static UIImage *topLineBG, *bottomLineBG;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        topLineBG = [UIImage imageWithSize:CGSizeMake(1, 3) drawBlock:^(CGContextRef context) {
            CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
            CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 0.8, [UIColor colorWithWhite:0 alpha:0.08].CGColor);
            CGContextAddRect(context, CGRectMake(-2, 3, 4, 4));
            CGContextFillPath(context);
        }];
        bottomLineBG = [UIImage imageWithSize:CGSizeMake(1, 3) drawBlock:^(CGContextRef context) {
            CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
            CGContextSetShadowWithColor(context, CGSizeMake(0, 0.4), 2, [UIColor colorWithWhite:0 alpha:0.08].CGColor);
            CGContextAddRect(context, CGRectMake(-2, -2, 4, 2));
            CGContextFillPath(context);
        }];
    });
    
    UIImageView *topLine = [[UIImageView alloc] initWithImage:topLineBG];
    topLine.width = _contentView.width;
    topLine.bottom = 0;
    topLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [_contentView addSubview:topLine];
    
    UIImageView *bottomLine = [[UIImageView alloc] initWithImage:bottomLineBG];
    bottomLine.width = _contentView.width;
    bottomLine.top = _contentView.height;
    bottomLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_contentView addSubview:bottomLine];
    [self addSubview:_contentView];
    
    _titleView = [IOOrderTitleView new];
    _titleView.width = IOScreenWidth;
    _titleView.hidden = YES;
    [_contentView addSubview:_titleView];
    
    _infoView = [IOOrderInfoView new];
    _infoView.width = IOScreenWidth;
    _infoView.hidden = YES;
    [_contentView addSubview:_infoView];
    
    _submitedBarView = [IOOrderSubmitedBarView new];
    _submitedBarView.width = IOScreenWidth;
    _submitedBarView.hidden = YES;
    [_contentView addSubview:_submitedBarView];
    
    _paidBarView = [IOOrderPaidBarView new];
    _paidBarView.width = IOScreenWidth;
    _paidBarView.hidden = YES;
    [_contentView addSubview:_paidBarView];
    
    _cookingBarView = [IOOrderCookingBarView new];
    _cookingBarView.width = IOScreenWidth;
    _cookingBarView.hidden = YES;
    [_contentView addSubview:_cookingBarView];
    
    _cookedBarView = [IOOrderCookedBarView new];
    _cookedBarView.width = IOScreenWidth;
    _cookedBarView.hidden = YES;
    [_contentView addSubview:_cookedBarView];
    
    _receiptBarView = [IOOrderReceiptBarView new];
    _receiptBarView.width = IOScreenWidth;
    _receiptBarView.hidden = YES;
    [_contentView addSubview:_receiptBarView];
    
    return self;
}

- (void)setLayout:(IOOrderLayout *)layout {
    _layout = layout;
    
    self.height = layout.height;
    _contentView.top = layout.marginTop;
    _contentView.height = layout.height - layout.marginTop - layout.marginBottom;
    
    CGFloat top = 0;
    
    _titleView.top = 0;
    _titleView.hidden = NO;
    _titleView.height = layout.titleHeight;
    top = _titleView.bottom;
    
    _infoView.top = top;
    _infoView.hidden = NO;
    _infoView.height = layout.infoHeight;
    top = _infoView.bottom;
    
    switch (layout.order.status) {
        case IOOrderStatusSubmited:
            _submitedBarView.hidden = NO;
            _submitedBarView.height = layout.barHeight;
            _submitedBarView.top = top;
            break;
        case IOOrderStatusPaid:
            _paidBarView.hidden = NO;
            _paidBarView.height = layout.barHeight;
            _paidBarView.top = top;
            break;
        case IOOrderStatusCooking:
            _cookingBarView.hidden = NO;
            _cookingBarView.height = layout.barHeight;
            _cookingBarView.top = top;
            break;
        case IOOrderStatusCooked:
            _cookedBarView.hidden = NO;
            _cookedBarView.height = layout.barHeight;
            _cookedBarView.top = top;
            break;
        case IOOrderStatusReceipt:
            _receiptBarView.hidden = NO;
            _receiptBarView.height = layout.barHeight;
            _receiptBarView.top = top;
            break;
        default:
            
            break;
    }
    
    // 设置数据
    [self setupDataWithLayout:layout];
}

- (void)setupDataWithLayout:(IOOrderLayout *)layout {
    
    // titleView
    _titleView.shopNameLabel.text = layout.order.shop.name;
    NSString *status = nil;
    switch (layout.order.status) {
        case IOOrderStatusCancel:
            status = @"已取消";
            break;
        case IOOrderStatusSubmited:
            status = @"待支付";
            break;
        case IOOrderStatusPaid:
            status = @"待接单";
            break;
        case IOOrderStatusCooking:
            status = @"待通知取餐";
            break;
        case IOOrderStatusCooked:
            status = @"待取餐";
            break;
        case IOOrderStatusReceipt:
            status = @"待评价";
            break;
        case IOOrderStatusDone:
            status = @"已完成";
            break;
    }
    _titleView.statusLabel.text = status;
    
    // infoView
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", kIOHTTPPictureServerUrl, layout.order.shop.picture];
    NSURL *url = [NSURL URLWithString:urlStr];
    [_infoView.shopIconView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    _infoView.goodsAmount.text = [NSString stringWithFormat:@"%d", layout.order.goodsAmount];
    _infoView.price.text = [NSString stringWithFormat:@"%.2f元", layout.order.totalPrice];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"YYYY年MM月dd日 hh:mm:ss"];
    NSDate *orderTime = [NSDate dateWithTimeIntervalSince1970:(layout.order.orderTime.longValue/1000)];
    _infoView.orderTime.text = [fmt stringFromDate:orderTime];
}

@end

@implementation IOOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    _orderView = [IOOrderView new];
    _orderView.cell = self;
    _orderView.titleView.cell = self;
    _orderView.infoView.cell = self;
    _orderView.submitedBarView.cell = self;
    _orderView.paidBarView.cell = self;
    _orderView.cookingBarView.cell = self;
    _orderView.cookedBarView.cell = self;
    _orderView.receiptBarView.cell = self;
    [self.contentView addSubview:_orderView];
    return self;
}

/**
 设置ViewModel
 
 @param layout viewModel
 */
- (void)setLayout:(IOOrderLayout *)layout {
    self.height = layout.height;
    self.contentView.height = layout.height;
    _orderView.layout = layout;
}

@end
