//
//  IOHomeCell.m
//  iOrder
//
//  Created by 易无解 on 4/17/16.
//  Copyright © 2016 normcore. All rights reserved.
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

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
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
    NSString *pictureStr = [NSString stringWithFormat:@"%@%@", kIOHTTPPictureServerUrl, _shop.picture];
    NSURL *pictureURL = [NSURL URLWithString:pictureStr];
    [_shopIcon sd_setImageWithURL:pictureURL placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    _shopName.text = _shop.name;
    _shopName.font = [UIFont systemFontOfSize:15];
    [_shopIcon sizeToFit];
    
    _shopIntro.text = _shop.cheapInfo;
    _shopIntro.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    _shopIntro.font = [UIFont systemFontOfSize:13];
    
    _shopDistance.text = [NSString stringWithFormat:@"%dkm", _shop.distance / 1000];
    _shopDistance.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    _shopDistance.font = [UIFont systemFontOfSize:13];
    
    _shopStarView.startCount = _shop.score;
    
    _shopPrice.text = [NSString stringWithFormat:@"¥%.2f/人", _shop.personalPrice];
    _shopPrice.font = [UIFont systemFontOfSize:13];
    _shopPrice.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    
    _shopSaleCount.text = [NSString stringWithFormat:@"已售%d", _shop.totalSale];
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
    shopDistance.textAlignment = NSTextAlignmentRight;
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
    shopSaleCount.textAlignment = NSTextAlignmentRight;
    [self addSubview:shopSaleCount];
    _shopSaleCount = shopSaleCount;
}

#pragma mark - masonry

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.shopIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.left.equalTo(self).offset(10);
        make.width.height.equalTo(@60);
    }];
    
    [self.shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shopIcon);
        make.left.equalTo(self.shopIcon.mas_right).offset(10);
        make.right.equalTo(self.mas_centerX);
        make.height.equalTo(@15);
    }];
    
    [_shopIntro sizeToFit];
    [self.shopIntro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shopName.mas_bottom).offset(2);
        make.left.equalTo(self.shopName);
        make.right.equalTo(self);
        make.height.equalTo(@13);
    }];
    
    [self.shopDistance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shopIcon);
        make.left.equalTo(self.mas_centerX);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@13);
    }];
    
    [self.shopStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopName);
        make.bottom.equalTo(self).offset(-8);
        make.height.equalTo(@13);
        make.width.equalTo(@(13 * 5));
    }];
    
    [self.shopPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-5);
        make.height.equalTo(@13);
        make.left.equalTo(self.shopStarView.mas_right).offset(10);
        make.width.equalTo(@100);
    }];
    
    [self.shopSaleCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-5);
        make.right.equalTo(self).offset(-10);
        make.width.equalTo(@100);
        make.height.equalTo(@13);
    }];
    
    [super updateConstraints];
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
    for (NSInteger i = 0; i < 5; i++) {
        UIImageView *star = [[UIImageView alloc] init];
        [self addSubview:star];
        [_stars addObject:star];
    }
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

#pragma mark - masonry

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    NSInteger lastObj = 0;
    [self.stars[lastObj] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self);
        make.width.equalTo(@13);
    }];
    
    for (NSInteger i = 1; i < 5; i++) {
        [self.stars[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(((UIImageView *)self.stars[lastObj]).mas_right);
            make.width.equalTo(@13);
        }];
        lastObj++;
    }
    
    [super updateConstraints];
}

@end

#pragma mark - IOHomeCellHeaderView

@interface IOHomeCellHeaderView ()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *title;
@property (nonatomic, weak) UIView *underLineView;

@end

@implementation IOHomeCellHeaderView

#pragma mark - privace

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupAllChildView];
    }
    
    return self;
}

#pragma mark - public

#pragma mark - custom

- (void)setupAllChildView {
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;
    _iconView.image = [UIImage imageNamed:@"store_image"];
    
    UILabel *title = [[UILabel alloc] init];
    [self addSubview:title];
    title.text = @"附近商家";
    title.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    title.font = [UIFont systemFontOfSize:15];
    _title = title;
    
    UIView *underLineView = [[UIView alloc] init];
    underLineView.backgroundColor = IORGBColor(234, 234, 234, 1);
    [self addSubview:underLineView];
    _underLineView = underLineView;
}

#pragma mark - masonry

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.width.height.equalTo(@21);
        make.centerY.equalTo(self);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).offset(10);
        make.width.equalTo(@60);
        make.height.equalTo(@15);
        make.centerY.equalTo(self);
    }];
    
    [self.underLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.equalTo(@1);
    }];
    
    [super updateConstraints];
}

@end
