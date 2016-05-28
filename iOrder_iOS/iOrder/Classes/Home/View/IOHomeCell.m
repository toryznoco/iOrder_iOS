//
//  IOHomeCell.m
//  iOrder
//
//  Created by 易无解 on 4/17/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOHomeCell.h"

#import "IOShop.h"
#import "UIImageView+WebCache.h"


#pragma mark - implementation IOHomeCell
@interface IOHomeCell ()

@property (nonatomic, weak) UIImageView *shopIcon;
@property (nonatomic, weak) UILabel *shopName;
@property (nonatomic, weak) UILabel *shopIntro;
@property (nonatomic, weak) UILabel *shopDistance;
@property (nonatomic, weak) IOHomeShopStarView *shopStarView;
@property (nonatomic, weak) UILabel *shopPrice;
@property (nonatomic, weak) UILabel *shopSaleCount;

@end

@implementation IOHomeCell

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
    
    CGFloat iconW = 60;
    CGFloat iconH = iconW;
    CGFloat iconX = 10;
    CGFloat iconY = 5;
    _shopIcon.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat nameW = 0;
    CGFloat nameH = 0;
    CGFloat nameX = CGRectGetMaxX(_shopIcon.frame) + 10;
    CGFloat nameY = iconY;
    _shopName.frame = CGRectMake(nameX, nameY, nameW, nameH);
    [_shopName sizeToFit];
    
    CGFloat introW = 0;
    CGFloat introH = 0;
    CGFloat introX = nameX;
    CGFloat introY = CGRectGetMaxY(_shopName.frame) + 2;
    _shopIntro.frame = CGRectMake(introX, introY, introW, introH);
    [_shopIntro sizeToFit];
    
    [_shopDistance sizeToFit];
    CGFloat distanceW = _shopDistance.width;
    CGFloat distanceH = _shopDistance.height;
    CGFloat distanceX = self.width - distanceW - 10;
    CGFloat distanceY = iconY;
    _shopDistance.frame = CGRectMake(distanceX, distanceY, distanceW, distanceH);
    
    CGFloat starViewW = _shopStarView.width;
    CGFloat starViewH = _shopStarView.height;
    CGFloat starViewX = nameX;
    CGFloat starViewY = self.height - starViewH - 8;
    _shopStarView.frame = CGRectMake(starViewX, starViewY, starViewW, starViewH);
    
    [_shopPrice sizeToFit];
    CGFloat priceW = _shopPrice.width;
    CGFloat priceH = _shopPrice.height;
    CGFloat priceX = CGRectGetMaxX(_shopStarView.frame) + 10;
    CGFloat priceY = self.height - priceH - 5;
    _shopPrice.frame = CGRectMake(priceX, priceY, priceW, priceH);
    
    [_shopSaleCount sizeToFit];
    CGFloat saleCountW = _shopSaleCount.width;
    CGFloat saleCountH = _shopSaleCount.height;
    CGFloat saleCountX = self.width - saleCountW - 10;
    CGFloat saleCountY = self.height - saleCountH - 5;
    _shopSaleCount.frame = CGRectMake(saleCountX, saleCountY, saleCountW, saleCountH);
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
    static NSString *reuseId = @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    return cell;
}

- (void)setShop:(IOShop *)shop {
    _shop = shop;
    
    [self setupShopInfo];
}

#pragma custom methods

- (void)setupShopInfo {
    NSString *pictureStr = [NSString stringWithFormat:@"%@%@", kPictureServerPath, _shop.picture];
    NSURL *pictureURL = [NSURL URLWithString:pictureStr];
    [_shopIcon sd_setImageWithURL:pictureURL placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    _shopName.text = _shop.name;
    _shopName.font = [UIFont systemFontOfSize:15];
    [_shopIcon sizeToFit];
    
    _shopIntro.text = _shop.cheap;
    _shopIntro.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    _shopIntro.font = [UIFont systemFontOfSize:13];
    
    _shopDistance.text = [NSString stringWithFormat:@"%dkm", _shop.distance / 1000];
    _shopDistance.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    _shopDistance.font = [UIFont systemFontOfSize:13];
    
    _shopStarView.startCount = _shop.score;
    
    _shopPrice.text = [NSString stringWithFormat:@"¥%.2f/人", _shop.perPri];
    _shopPrice.font = [UIFont systemFontOfSize:13];
    _shopPrice.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    
    _shopSaleCount.text = [NSString stringWithFormat:@"已售%d", _shop.toSal];
    _shopSaleCount.font = [UIFont systemFontOfSize:13];
    _shopSaleCount.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
}

- (void)setupAllChildView {
//    店铺图片
    UIImageView *shopIcon = [[UIImageView alloc] init];
    [self addSubview:shopIcon];
    _shopIcon = shopIcon;
    
//    店铺名称
    UILabel *shopName = [[UILabel alloc] init];
    [self addSubview:shopName];
    _shopName = shopName;
    
//    店铺简介
    UILabel *shopIntro = [[UILabel alloc] init];
    [self addSubview:shopIntro];
    _shopIntro = shopIntro;
    
//    店铺距离
    UILabel *shopDistance = [[UILabel alloc] init];
    [self addSubview:shopDistance];
    self.shopDistance = shopDistance;
    
//    店铺评价
    IOHomeShopStarView *shopStarView = [[IOHomeShopStarView alloc] init];
    [self addSubview:shopStarView];
    _shopStarView = shopStarView;
    
//    店铺人均价格
    UILabel *shopPrice = [[UILabel alloc] init];
    [self addSubview:shopPrice];
    _shopPrice = shopPrice;
    
//    店铺销售量
    UILabel *shopSaleCount = [[UILabel alloc] init];
    [self addSubview:shopSaleCount];
    _shopSaleCount = shopSaleCount;
}

@end


#pragma mark - implementation IOHomeShopStarView
@interface IOHomeShopStarView ()

@property (nonatomic, strong) NSMutableArray *stars;

@end

@implementation IOHomeShopStarView

#pragma mark - privacy

- (NSMutableArray *)stars {
    if (!_stars) {
        _stars = [NSMutableArray array];
    }
    return _stars;
}

- (instancetype)init {
    if (self = [super init]) {
        _stars = [self stars];
        [self setupAllChildView];
    }
    return self;
}

#pragma mark - public

- (void)setStartCount:(float)startCount {
    _startCount = startCount;
    
    [self setupData];
}

#pragma mark - custom methods

- (void)setupAllChildView {
    CGFloat starX = 0;
    CGFloat starY = 0;
    CGFloat starW = 13;
    CGFloat starH = starW;
    for (NSInteger i = 0; i < 5; i++) {
        starX = i * starW;
        UIImageView *star = [[UIImageView alloc] init];
        [self addSubview:star];
        [_stars addObject:star];
        star.frame = CGRectMake(starX, starY, starW, starH);
    }
    
    self.width = 5 * starW;
    self.height = starH;
}

- (void)setupData {
    int count = ((int)(_startCount * 10)) % 10;
    int index = -1;
    if (count >= 5 && count <= 9) {
        index = ((int)_startCount) + 1;
    }
    
    for (NSInteger i = 0; i < _stars.count; i++) {
        UIImageView *star = _stars[i];
        if (i < ((int)_startCount)) {
            [star setImage:[UIImage imageNamed:@"star_highlight_icon"]];
        }else if(index != -1 && i == ((int)_startCount)){
            [star setImage:[UIImage imageNamed:@"half_of_the_star"]];
        }else{
            [star setImage:[UIImage imageNamed:@"star_common_icon"]];
        }
    }
}

@end
