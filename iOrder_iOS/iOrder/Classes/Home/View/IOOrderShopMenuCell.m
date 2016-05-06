//
//  IOOrderShopMenuCell.m
//  iOrder
//
//  Created by 易无解 on 5/3/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOOrderShopMenuCell.h"

#import "IODish.h"

@interface IOOrderShopMenuCell ()

@property (nonatomic, weak) UIImageView *dishIcon;
@property (nonatomic, weak) UILabel *dishName;
@property (nonatomic, weak) UILabel *dishSaleCount;
@property (nonatomic, weak) UIImageView *followImage;
@property (nonatomic, weak) UILabel *followCount;
@property (nonatomic, weak) UILabel *dishPrice;
@property (nonatomic, weak) UILabel *dishPriceSuffix;
@property (nonatomic, weak) UIButton *orderBtn;

@end

@implementation IOOrderShopMenuCell

#pragma mark - privacy

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupAllChildView];
    }
    
    return self;
}

- (void)layoutSubviews{
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
    CGFloat followY = saleCountY;
    _followImage.frame = CGRectMake(followX, followY, followW, followH);
    
    [_followCount sizeToFit];
    CGFloat followCountW = _followCount.width;
    CGFloat followCountH = _followCount.height;
    CGFloat followCountX = CGRectGetMaxX(_followImage.frame) + 5;
    CGFloat followCountY = followY;
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
    
    CGFloat orderBtnW = 25;
    CGFloat orderBtnH = orderBtnW;
    CGFloat orderBtnX = self.width - orderBtnW - 8;
    CGFloat orderBtnY = 40;
    _orderBtn.frame = CGRectMake(orderBtnX, orderBtnY, orderBtnW, orderBtnH);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - public

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *reuseId = @"menuCell";
    id cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    
    return cell;
}

- (void)setDish:(IODish *)dish{
    _dish = dish;
    
    [self setupDish];
}

#pragma mark - custom methods

- (void)setupAllChildView{
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
    dishSaleCount.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    [self addSubview:dishSaleCount];
    _dishSaleCount = dishSaleCount;
    
    //    点赞图片
    UIImageView *followImage = [[UIImageView alloc] init];
    [followImage setImage:[UIImage imageNamed:@"iOrder_home_follow"]];
    [self addSubview:followImage];
    _followImage = followImage;
    
    //    点赞数
    UILabel *followCount = [[UILabel alloc] init];
    followCount.font = [UIFont systemFontOfSize:11];
    followCount.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    [self addSubview:followCount];
    _followCount = followCount;
    
    //    菜品价格
    UILabel *dishPrice = [[UILabel alloc] init];
    dishPrice.textColor = [UIColor redColor];
    dishPrice.font = [UIFont systemFontOfSize:15];
    [self addSubview:dishPrice];
    _dishPrice = dishPrice;
    
    UILabel *dishPriceSuffix = [[UILabel alloc] init];
    dishPriceSuffix.font = [UIFont systemFontOfSize:12];
    dishPriceSuffix.text = @"/份";
    dishPriceSuffix.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    [self addSubview:dishPriceSuffix];
    _dishPriceSuffix = dishPriceSuffix;
    
    //    预定按钮
    UIButton *orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [orderBtn setImage:[UIImage imageNamed:@"iOrder_home_orderBtn"] forState:UIControlStateNormal];
    [orderBtn addTarget:self action:@selector(orderBtnClicked) forControlEvents:UIControlEventTouchDown];
    [self addSubview:orderBtn];
    _orderBtn = orderBtn;
}

- (void)setupDish{
    [_dishIcon setImage:[UIImage imageNamed:_dish.dishIcon]];
    
    _dishName.text = _dish.dishName;
    
    _dishSaleCount.text = [NSString stringWithFormat:@"月售%@", _dish.dishSalesCount];
    
    _followCount.text = _dish.dishFollow;
    
    _dishPrice.text = [NSString stringWithFormat:@"¥%@", _dish.dishPrice];
    _dishPrice.font = [UIFont systemFontOfSize:15];
}

- (void)orderBtnClicked{
    YWJLog(@"Click the orderBtn");
}

@end
