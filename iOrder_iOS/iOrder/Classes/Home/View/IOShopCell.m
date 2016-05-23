//
//  IOShopCell.m
//  iOrder
//
//  Created by 易无解 on 5/3/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOShopCell.h"

#import "IODishInfo.h"
#import "UIImageView+WebCache.h"


#pragma mark - implementation IOShopRightCell
@interface IOShopRightCell ()

@property (nonatomic, weak) UIImageView *dishIcon;
@property (nonatomic, weak) UILabel *dishName;
@property (nonatomic, weak) UILabel *dishSaleCount;
@property (nonatomic, weak) UIImageView *followImage;
@property (nonatomic, weak) UILabel *followCount;
@property (nonatomic, weak) UILabel *dishPrice;
@property (nonatomic, weak) UILabel *dishPriceSuffix;
@property (nonatomic, weak) UIButton *unOrderBtn;
@property (nonatomic, weak) UILabel *dishCount;
@property (nonatomic, weak) UIButton *orderBtn;

@end

@implementation IOShopRightCell

#pragma mark - privacy

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupAllChildView];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat iconW = 46;
    CGFloat iconH = iconW;
    CGFloat iconX = 10;
    CGFloat iconY = 10;
    _dishIcon.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat nameW = 0;
    CGFloat nameH = 0;
    CGFloat nameX = CGRectGetMaxX(_dishIcon.frame) + 10;
    CGFloat nameY = iconY;
    _dishName.frame = CGRectMake(nameX, nameY, nameW, nameH);
    [_dishName sizeToFit];
    
    [_dishSaleCount sizeToFit];
    CGFloat saleCountW = _dishSaleCount.width;
    CGFloat saleCountH = _dishSaleCount.height;
    CGFloat saleCountX = CGRectGetMaxX(_dishIcon.frame) + 10;
    CGFloat saleCountY = CGRectGetMaxY(_dishName.frame) + 3;
    _dishSaleCount.frame = CGRectMake(saleCountX, saleCountY, saleCountW, saleCountH);
    
    [_followImage sizeToFit];
    CGFloat followW = _followImage.width;
    CGFloat followH = _followImage.height;
    CGFloat followX = CGRectGetMaxX(_dishSaleCount.frame) + 10;
    CGFloat followY = saleCountY + 3;
    _followImage.frame = CGRectMake(followX, followY, followW, followH);
    
    [_followCount sizeToFit];
    CGFloat followCountW = _followCount.width;
    CGFloat followCountH = _followCount.height;
    CGFloat followCountX = CGRectGetMaxX(_followImage.frame) + 5;
    CGFloat followCountY = saleCountY;
    _followCount.frame = CGRectMake(followCountX, followCountY, followCountW, followCountH);
    
    [_dishPrice sizeToFit];
    CGFloat priceW = _dishPrice.width;
    CGFloat priceH = _dishPrice.height;
    CGFloat priceX = CGRectGetMaxX(_dishIcon.frame) + 10;
    CGFloat priceY = CGRectGetMaxY(_dishSaleCount.frame) + 3;
    _dishPrice.frame = CGRectMake(priceX, priceY, priceW, priceH);
    
    [_dishPriceSuffix sizeToFit];
    CGFloat priceSuW = _dishPriceSuffix.width;
    CGFloat priceSuH = _dishPriceSuffix.height;
    CGFloat priceSuX = CGRectGetMaxX(_dishPrice.frame);
    CGFloat priceSuY = CGRectGetMaxY(_dishPrice.frame) - priceSuH;
    _dishPriceSuffix.frame = CGRectMake(priceSuX, priceSuY, priceSuW, priceSuH);
    
    CGFloat orderBtnW = 30;//25
    CGFloat orderBtnH = orderBtnW;
    CGFloat orderBtnX = self.width - orderBtnW - 8;
    CGFloat orderBtnY = 32;
    _orderBtn.frame = CGRectMake(orderBtnX, orderBtnY, orderBtnW, orderBtnH);
    
    CGFloat dishCountW = 25;
    CGFloat dishCountH = 15;
    CGFloat dishCountX = orderBtnX - dishCountW - 2;
    CGFloat dishCountY = orderBtnY + 7;
    _dishCount.frame  = CGRectMake(dishCountX, dishCountY, dishCountW, dishCountH);
    
    CGFloat unOrderBtnW = 30;
    CGFloat unOrderBtnH = orderBtnH;
    CGFloat unOrderBtnX = dishCountX - unOrderBtnW - 2;
    CGFloat unOrderBtnY = orderBtnY;
    _unOrderBtn.frame = CGRectMake(unOrderBtnX, unOrderBtnY, unOrderBtnW, unOrderBtnH);
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
    static NSString *reuseId = @"menuCell";
    id cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    
    return cell;
}

- (void)setDish:(IODish *)dish {
    _dish = dish;
    
    [self setupDish];
}

#pragma mark - custom methods

- (void)setupAllChildView {
    //    菜品图片
    UIImageView *dishIcon = [[UIImageView alloc] init];
    [self addSubview:dishIcon];
    _dishIcon = dishIcon;
    
    //    菜品名称
    UILabel *dishName = [[UILabel alloc] init];
    dishName.font = [UIFont systemFontOfSize:15];
    [self addSubview:dishName];
    _dishName = dishName;
    
    //    菜品销售量
    UILabel *dishSaleCount = [[UILabel alloc] init];
    dishSaleCount.font = [UIFont systemFontOfSize:11];
    dishSaleCount.textColor = YWJRGBColor(180, 180, 180, 1);
    [self addSubview:dishSaleCount];
    _dishSaleCount = dishSaleCount;
    
    //    点赞图片
    UIImageView *followImage = [[UIImageView alloc] init];
    [followImage setImage:[UIImage imageNamed:@"praise_small_icon"]];
    [self addSubview:followImage];
    _followImage = followImage;
    
    //    点赞数
    UILabel *followCount = [[UILabel alloc] init];
    followCount.font = [UIFont systemFontOfSize:12];
    followCount.textColor = YWJRGBColor(180, 180, 180, 1);
    [self addSubview:followCount];
    _followCount = followCount;
    
    //    菜品价格
    UILabel *dishPrice = [[UILabel alloc] init];
    dishPrice.textColor = kIOThemeColors;
    dishPrice.font = [UIFont systemFontOfSize:15];
    [self addSubview:dishPrice];
    _dishPrice = dishPrice;
    
    UILabel *dishPriceSuffix = [[UILabel alloc] init];
    dishPriceSuffix.font = [UIFont systemFontOfSize:12];
    dishPriceSuffix.text = @"/份";
    dishPriceSuffix.textColor = YWJRGBColor(180, 180, 180, 1);
    [self addSubview:dishPriceSuffix];
    _dishPriceSuffix = dishPriceSuffix;
    
    //    预定按钮
    UIButton *orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    orderBtn.tag = 1;
    [orderBtn setBackgroundImage:[UIImage imageNamed:@"add_button"] forState:UIControlStateNormal];
    [orderBtn addTarget:self action:@selector(orderBtnClicked:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:orderBtn];
    _orderBtn = orderBtn;
    
    //    当前菜品已点的份数
    UILabel *dishCount = [[UILabel alloc] init];
    dishCount.hidden = YES;
    dishCount.textAlignment = NSTextAlignmentCenter;
    dishCount.font = [UIFont systemFontOfSize:13];
    dishCount.text = @"0";
    [self addSubview:dishCount];
    _dishCount = dishCount;
    
    //    取消订购按钮
    UIButton *unOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    unOrderBtn.hidden = YES;
    unOrderBtn.enabled = NO;
    unOrderBtn.tag = 2;
    [unOrderBtn setBackgroundImage:[UIImage imageNamed:@"reduce_button"] forState:UIControlStateNormal];
    [unOrderBtn addTarget:self action:@selector(orderBtnClicked:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:unOrderBtn];
    _unOrderBtn = unOrderBtn;
}

- (void)setupDish {
    NSString *pictureStr = [NSString stringWithFormat:@"%@%@", kPictureServerPath, _dish.picture];
    NSURL *pictureURL = [NSURL URLWithString:pictureStr];
    [_dishIcon sd_setImageWithURL:pictureURL placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    _dishName.text = _dish.name;
    
    _dishSaleCount.text = [NSString stringWithFormat:@"月售%d", _dish.monSal];
    
    _followCount.text = [NSString stringWithFormat:@"%d", _dish.praAmt];
    
    _dishPrice.text = [NSString stringWithFormat:@"¥%.2f", _dish.price];
    _dishPrice.font = [UIFont systemFontOfSize:15];
}

- (void)orderBtnClicked:(UIButton *)btn {
    if (btn.tag == 1) {
        _dishCount.text = [NSString stringWithFormat:@"%lld", [_dishCount.text longLongValue] + 1];
        if ([_dishCount.text longLongValue] - 1 == 0) {
            _dishCount.hidden = NO;
            _unOrderBtn.hidden = NO;
            _unOrderBtn.enabled = YES;
        }
    } else {
        _dishCount.text = [NSString stringWithFormat:@"%lld", [_dishCount.text longLongValue] - 1];
        if ([_dishCount.text longLongValue] + 1 == 1) {
            _dishCount.hidden = YES;
            _unOrderBtn.hidden = YES;
            _unOrderBtn.enabled = NO;
        }
    }
    
    if ([_delegate respondsToSelector:@selector(shopRightCell:dishPrice:clickedBtn:)]) {
        [_delegate shopRightCell:self dishPrice:_dish.price clickedBtn:btn];
    }
}

@end


#pragma mark - implementation IOShopLeftCell
@implementation IOShopLeftCell

#pragma mark - privacy

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupAllChidView];
    }
    return self;
}

#pragma mark - public

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuseId = @"optionCell";
    id cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    
    return cell;
}

- (void)setCategory:(NSString *)category {
    _category = category;
    
    self.textLabel.text = category;
    self.textLabel.font = [UIFont systemFontOfSize:15];
    self.textLabel.textColor = YWJRGBColor(88, 88, 88, 1);
    self.textLabel.numberOfLines = 0;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - custom methods

- (void)setupAllChidView {
    UIView *selectedBgView = [[UIView alloc] initWithFrame:self.frame];
    selectedBgView.backgroundColor = YWJRGBColor(217, 217, 217, 0.5);
    self.selectedBackgroundView = selectedBgView;
    
    UIView *liner = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 5, 41)];
    liner.backgroundColor = [UIColor orangeColor];
    [selectedBgView addSubview:liner];
}

@end

