//
//  IOOrderViewCell.m
//  iOrder
//
//  Created by Tory on 16/5/11.
//  Copyright © 2016年 易无解. All rights reserved.
//

#import "IOOrderViewCell.h"
#import "IOOrder.h"
#import "UIImageView+WebCache.h"

@interface IOOrderViewCell ()
/**
 *  店铺名称
 */
@property (nonatomic, weak) UILabel *shopNameLabel;
/**
 *  订单状态
 */
@property (nonatomic, weak) UILabel *orderStateLabel;
/**
 *  分割线1
 */
@property (nonatomic, weak) UIView *horizontalLine1;
/**
 *  店铺icon
 */
@property (nonatomic, weak) UIImageView *shopIcon;

/**
 *  菜品数量
 */
@property (nonatomic, weak) UILabel *dishAmtLabel;

/**
 *  实付款
 */
@property (nonatomic, weak) UILabel *paymentLabel;

/**
 *  时间
 */
@property (nonatomic, weak) UILabel *timeLabel;

/**
 *  分割线2
 */
@property (nonatomic, weak) UIView *horizontalLine2;
/**
 *  按钮
 */
@property (nonatomic, weak) UIButton *button;

@end

@implementation IOOrderViewCell

#pragma mark - privacy

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupAllChildView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat nameX = kIOOrderViewCellMargin;
    CGFloat nameY = kIOOrderViewCellMargin;
    CGFloat nameW = 300;
    CGFloat nameH = 15;
    _shopName.frame = CGRectMake(nameX, nameY, nameW, nameH);
    [_shopName sizeToFit];
    
    CGFloat stateX = IOScreenWidth-kIOOrderViewCellMargin-kIOOrderViewCellStateWidth;
    CGFloat stateY = nameY;
    CGFloat stateW = kIOOrderViewCellStateWidth;
    CGFloat stateH = kIOOrderViewCellStateHeight;
    _orderState.frame = CGRectMake(stateX, stateY, stateW, stateH);
    [_shopName sizeToFit];
    
    CGFloat line1X = 0;
    CGFloat line1Y = CGRectGetMaxY(_shopName.frame)+kIOOrderViewCellMargin;
    CGFloat line1W = IOScreenWidth;
    CGFloat line1H = 1;
    _horizontalLine1.frame = CGRectMake(line1X, line1Y, line1W, line1H);
    
    CGFloat iconX = kIOOrderViewCellMargin;
    CGFloat iconY = CGRectGetMaxY(_shopName.frame)+2*kIOOrderViewCellMargin;
    CGFloat iconW = kIOOrderViewCellIconWidth;
    CGFloat iconH = kIOOrderViewCellIconHeight;
    _shopIcon.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat paymentX = CGRectGetMaxX(_shopIcon.frame)+kIOOrderViewCellMargin;
    CGFloat paymentY = iconY;
    CGFloat paymentW = kIOOrderViewCellPaymentWidth;
    CGFloat paymentH = kIOOrderViewCellPaymentHeight;
    _payment.frame = CGRectMake(paymentX, paymentY, paymentW, paymentH);
    
    CGFloat timeX = CGRectGetMaxX(_shopIcon.frame)+kIOOrderViewCellMargin;
    CGFloat timeY = CGRectGetMaxY(_payment.frame)+kIOOrderViewCellMargin;
    CGFloat timeW = kIOOrderViewCellTimeWidth;
    CGFloat timeH = kIOOrderViewCellTimeHeight;
    _time.frame = CGRectMake(timeX, timeY, timeW, timeH);
    
    CGFloat line2X = 0;
    CGFloat line2Y = CGRectGetMaxY(_shopIcon.frame)+kIOOrderViewCellMargin;
    CGFloat line2W = IOScreenWidth;
    CGFloat line2H = 1;
    _horizontalLine2.frame = CGRectMake(line2X, line2Y, line2W, line2H);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - public

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuseId = @"OrderCell";
    id cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    return cell;
}

- (void)setOrder:(IOOrder *)order {
    _order = order;
    
    [self setupOrderInfo];
}

#pragma custom methods

- (void)setupOrderInfo {
    _shopName.text = _order.shopName;
    _shopName.font = [UIFont systemFontOfSize:15];
    [_shopName sizeToFit];
    
    _orderState.text = _order.status;
    _orderState.font = [UIFont systemFontOfSize:15];
    _orderState.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    [_orderState sizeToFit];
    
    _horizontalLine1.backgroundColor = [UIColor lightGrayColor];
    
    NSString *pictureStr = [NSString stringWithFormat:@"%@%@", kPictureServerPath, _order.shopIcon];
    NSURL *pictureURL = [NSURL URLWithString:pictureStr];
    [_shopIcon sd_setImageWithURL:pictureURL placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    _payment.text = [NSString stringWithFormat:@"¥%.2f", _order.price];
    _payment.font = [UIFont systemFontOfSize:15];
    [_payment sizeToFit];
    
    _time.text = _order.time;
    _time.font = [UIFont systemFontOfSize:15];
    [_time sizeToFit];
    
    _horizontalLine2.backgroundColor = [UIColor lightGrayColor];
}

- (void)setupAllChildView {
    //  店铺名称
    UILabel *shopName = [[UILabel alloc] init];
    [self addSubview:shopName];
    _shopName = shopName;
    
    //  订单状态
    UILabel *orderState = [[UILabel alloc] init];
    [self addSubview:orderState];
    _orderState = orderState;
    
    //  分割线1
    UIView *horizontalLine1 = [[UIView alloc] init];
    [self addSubview:horizontalLine1];
    _horizontalLine1 = horizontalLine1;
    
    //  店铺图片
    UIImageView *shopIcon = [[UIImageView alloc] init];
    [self addSubview:shopIcon];
    _shopIcon = shopIcon;

    //  实付款
    UILabel *payment = [[UILabel alloc] init];
    [self addSubview:payment];
    _payment = payment;
    
    //  时间
    UILabel *time = [[UILabel alloc] init];
    [self addSubview:time];
    _time = time;
    
    //  分割线2
    UIView *horizontalLine2 = [[UIView alloc] init];
    [self addSubview:horizontalLine2];
    _horizontalLine2 = horizontalLine2;
}


@end
