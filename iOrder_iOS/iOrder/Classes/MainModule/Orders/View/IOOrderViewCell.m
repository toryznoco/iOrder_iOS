//
//  IOOrderViewCell.m
//  iOrder
//
//  Created by Tory on 16/5/11.
//  Copyright © 2016年 normcore. All rights reserved.
//

#import "IOOrderViewCell.h"
#import "IOOrder.h"
#import "UIImageView+WebCache.h"

#pragma mark - size

#define kIOShopNameLeftMargin 15
#define kIOShopNameTopMargin 6
#define kIOShopNameWidth 200
#define kIOShopNameHeight 15

#define kIOStatusWidth 50
#define kIOStatusHeight 15

#define kIOIconTopMargin 8
#define kIOIconWidth 60

#define kIODishesAmtLabelLeftMargin 10
#define kIODishesAmtLabelWidth 65
#define kIODishesAmtLabelHeight 15

#define kIODishesAmtWidth 150

#define kIOPriceLabelTopMargin ((kIOIconWidth-3*kIODishesAmtLabelHeight)*0.5)

#define kIOButtonTopMargin 10
#define kIOButtonRightMargin 10
#define kIOButtonWidth 60
#define kIOButtonHeight 15

#pragma mark - font

#define kIOCellFont [UIFont systemFontOfSize:13]

#pragma mark - color

#define kIOLineColor [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:0.6]
#define kIOTextColor [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1]

@interface IOOrderViewCell ()
/**
 *  店铺名称
 */
@property (nonatomic, weak) UILabel *shopName;
/**
 *  订单状态
 */
@property (nonatomic, weak) UILabel *status;
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
@property (nonatomic, weak) UILabel *dishesAmtLabel;

@property (nonatomic, weak) UILabel *dishesAmt;

/**
 *  实付款
 */
@property (nonatomic, weak) UILabel *priceLabel;

@property (nonatomic, weak) UILabel *price;

/**
 *  时间
 */
@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic, weak) UILabel *time;

/**
 *  分割线2
 */
@property (nonatomic, weak) UIView *horizontalLine2;
/**
 *  按钮
 */
@property (nonatomic, weak) UIButton *button;
/**
 *  cell间隔
 */
@property (nonatomic, weak) UIView *spacing;

@end

@implementation IOOrderViewCell

#pragma mark - privacy

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupAllChildView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat nameX = kIOShopNameLeftMargin;
    CGFloat nameY = kIOShopNameTopMargin;
    CGFloat nameW = kIOShopNameWidth;
    CGFloat nameH = kIOShopNameHeight;
    _shopName.frame = CGRectMake(nameX, nameY, nameW, nameH);
    [_shopName sizeToFit];
    
    CGFloat statusX = IOScreenWidth-kIOShopNameLeftMargin-kIOStatusWidth;
    CGFloat statusY = kIOShopNameTopMargin;
    CGFloat statusW = kIOStatusWidth;
    CGFloat statusH = kIOStatusHeight;
    _status.frame = CGRectMake(statusX, statusY, statusW, statusH);
    [_status sizeToFit];
    
    CGFloat line1X = 0;
    CGFloat line1Y = CGRectGetMaxY(_shopName.frame)+kIOShopNameTopMargin;
    CGFloat line1W = IOScreenWidth;
    CGFloat line1H = 0.4;
    _horizontalLine1.frame = CGRectMake(line1X, line1Y, line1W, line1H);
    
    CGFloat iconX = kIOShopNameLeftMargin;
    CGFloat iconY = CGRectGetMaxY(_horizontalLine1.frame)+kIOIconTopMargin;
    CGFloat iconW = kIOIconWidth;
    CGFloat iconH = kIOIconWidth;
    _shopIcon.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    //  菜品数量
    CGFloat dishesAmtLabelX = CGRectGetMaxX(_shopIcon.frame)+kIODishesAmtLabelLeftMargin;
    CGFloat dishesAmtLabelY = iconY;
    CGFloat dishesAmtLabelW = kIODishesAmtLabelWidth;
    CGFloat dishesAmtLabelH = kIODishesAmtLabelHeight;
    _dishesAmtLabel.frame = CGRectMake(dishesAmtLabelX, dishesAmtLabelY, dishesAmtLabelW, dishesAmtLabelH);
    
    CGFloat dishesAmtX = CGRectGetMaxX(_dishesAmtLabel.frame);
    CGFloat dishesAmtY = dishesAmtLabelY;
    CGFloat dishesAmtW = kIODishesAmtWidth;
    CGFloat dishesAmtH = kIODishesAmtLabelHeight;
    _dishesAmt.frame = CGRectMake(dishesAmtX, dishesAmtY, dishesAmtW, dishesAmtH);
    
    //  总价
    CGFloat priceLabelX = dishesAmtLabelX;
    CGFloat priceLabelY = CGRectGetMaxY(_dishesAmtLabel.frame)+kIOPriceLabelTopMargin;
    CGFloat priceLabelW = kIODishesAmtLabelWidth;
    CGFloat priceLabelH = kIODishesAmtLabelHeight;
    _priceLabel.frame = CGRectMake(priceLabelX, priceLabelY, priceLabelW, priceLabelH);
    
    CGFloat priceX = CGRectGetMaxX(_priceLabel.frame);
    CGFloat priceY = priceLabelY;
    CGFloat priceW = kIODishesAmtWidth;
    CGFloat priceH = kIODishesAmtLabelHeight;
    _price.frame = CGRectMake(priceX, priceY, priceW, priceH);
    
    //  下单时间
    CGFloat timeLabelX = dishesAmtLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_priceLabel.frame)+kIOPriceLabelTopMargin;
    CGFloat timeLabelW = kIODishesAmtLabelWidth;
    CGFloat timeLabelH = kIODishesAmtLabelHeight;
    _timeLabel.frame = CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH);
    
    CGFloat timeX = CGRectGetMaxX(_timeLabel.frame);
    CGFloat timeY = timeLabelY;
    CGFloat timeW = kIODishesAmtWidth;
    CGFloat timeH = kIODishesAmtLabelHeight;
    _time.frame = CGRectMake(timeX, timeY, timeW, timeH);
    
    //  分割线2
    CGFloat line2X = 0;
    CGFloat line2Y = CGRectGetMaxY(_shopIcon.frame)+kIOIconTopMargin;
    CGFloat line2W = IOScreenWidth;
    CGFloat line2H = 0.4;
    _horizontalLine2.frame = CGRectMake(line2X, line2Y, line2W, line2H);
    
    //  按钮
    CGFloat buttonX = IOScreenWidth-kIOButtonRightMargin-kIOButtonWidth;
    CGFloat buttonY = CGRectGetMaxY(_horizontalLine2.frame)+kIOButtonTopMargin;
    CGFloat buttonW = kIOButtonWidth;
    CGFloat buttonH = kIOButtonHeight;
    _button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    
    //  cell间隔
    CGFloat spacingX = 0;
    CGFloat spacingY = CGRectGetMaxY(_button.frame)+kIOButtonTopMargin;
    CGFloat spacingW = IOScreenWidth;
    CGFloat spacingH = 10;
    _spacing.frame = CGRectMake(spacingX, spacingY, spacingW, spacingH);
}

- (void)awakeFromNib {
    [super awakeFromNib];
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
    //  店铺名称
    _shopName.text = _order.shopName;
    _shopName.font = kIOCellFont;
    [_shopName sizeToFit];
    
    //  订单状态
    NSString *status = nil;
    switch (_order.status) {
        case IOOrderStateCancel:
            status = @"订单取消";
            break;
        case IOOrderStateSubmited:
            status = @"待支付";
            break;
        case IOOrderStatePaid:
            status = @"待接单";
            break;
        case IOOrderStateCooking:
            status = @"待配餐";
            break;
        case IOOrderStateCooked:
            status = @"待取餐";
            break;
        case IOOrderStateDone:
            status = @"待评价";
            break;
        case IOOrderStateCompleted:
            status = @"订单完成";
            break;
    }
    _status.text = status;
    _status.font = kIOCellFont;
    _status.textColor = kIOTextColor;
    [_status sizeToFit];
    
    //  分割线1
    _horizontalLine1.backgroundColor = kIOLineColor;
    
    //  店铺icon
    NSString *pictureStr = [NSString stringWithFormat:@"%@%@", kPictureServerPath, _order.shopPic];
    NSURL *pictureURL = [NSURL URLWithString:pictureStr];
    [_shopIcon sd_setImageWithURL:pictureURL
                 placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    //  菜品数量
    _dishesAmtLabel.text = @"菜品数量：";
    _dishesAmtLabel.font = kIOCellFont;
    _dishesAmtLabel.textColor = kIOTextColor;
    [_dishesAmtLabel sizeToFit];
    
    _dishesAmt.text = [NSString stringWithFormat:@"%d", _order.dishesAmt];
    _dishesAmt.font = kIOCellFont;
    _dishesAmt.textColor = [UIColor orangeColor];
    [_dishesAmt sizeToFit];
    
    //  总价
    _priceLabel.text = @"菜品总价：";
    _priceLabel.font = kIOCellFont;
    _priceLabel.textColor = kIOTextColor;
    [_priceLabel sizeToFit];
    
    _price.text = [NSString stringWithFormat:@"%.2f元", _order.price];
    _price.font = kIOCellFont;
    _price.textColor = [UIColor orangeColor];
    [_price sizeToFit];
    
    //  下单时间
    _timeLabel.text = @"下单时间：";
    _timeLabel.font = kIOCellFont;
    _timeLabel.textColor = kIOTextColor;
    [_timeLabel sizeToFit];
    
    _time.text = _order.time;
    _time.font = kIOCellFont;
    _time.textColor = kIOTextColor;
    [_time sizeToFit];
    
    //  分割线2
    _horizontalLine2.backgroundColor = kIOLineColor;
    
    //  按钮
    [_button setTitle:@"取消" forState:UIControlStateNormal];
    
    //  cell间隔
    _spacing.backgroundColor = kIOBackgroundColor;
}

- (void)setupAllChildView {
    //  店铺名称
    UILabel *shopName = [[UILabel alloc] init];
    [self.contentView addSubview:shopName];
    _shopName = shopName;
    
    //  订单状态
    UILabel *status = [[UILabel alloc] init];
    [self.contentView addSubview:status];
    _status = status;
    
    //  分割线1
    UIView *horizontalLine1 = [[UIView alloc] init];
    [self.contentView addSubview:horizontalLine1];
    _horizontalLine1 = horizontalLine1;
    
    //  店铺图片
    UIImageView *shopIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:shopIcon];
    _shopIcon = shopIcon;
    
    //  菜品数量
    UILabel *dishesAmtLabel = [[UILabel alloc] init];
    [self.contentView addSubview:dishesAmtLabel];
    _dishesAmtLabel = dishesAmtLabel;
    
    UILabel *dishesAmt = [[UILabel alloc] init];
    [self.contentView addSubview:dishesAmt];
    _dishesAmt = dishesAmt;
    
    //  总价
    UILabel *priceLabel = [[UILabel alloc] init];
    [self.contentView addSubview:priceLabel];
    _priceLabel = priceLabel;
    
    UILabel *price = [[UILabel alloc] init];
    [self.contentView addSubview:price];
    _price = price;
    
    //  下单时间
    UILabel *timeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:timeLabel];
    _timeLabel = timeLabel;
    
    UILabel *time = [[UILabel alloc] init];
    [self.contentView addSubview:time];
    _time = time;
    
    //  分割线2
    UIView *horizontalLine2 = [[UIView alloc] init];
    [self.contentView addSubview:horizontalLine2];
    _horizontalLine2 = horizontalLine2;
    
    //  按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.contentView addSubview:button];
    _button = button;
    
    //  间隔
    UIView *spacing = [[UIView alloc] init];
    [self.contentView addSubview:spacing];
    _spacing = spacing;
}

@end
