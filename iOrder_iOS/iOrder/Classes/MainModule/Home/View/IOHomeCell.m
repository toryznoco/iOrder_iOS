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

#pragma mark - 系统回调函数

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //        1.设置界面相关函数
        [self setupAllSubViews];
        //        2.设置约束
        [self setupConstraints];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - 设置界面相关函数

- (void)setupAllSubViews {
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

#pragma mark - 设置约束相关函数

- (void)setupConstraints {
    __weak typeof(self) weakSelf = self;
    [self.shopIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf).offset(5);
        make.left.mas_equalTo(weakSelf).offset(10);
        make.width.height.mas_equalTo(60);
    }];
    
    [self.shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.shopIcon);
        make.left.mas_equalTo(weakSelf.shopIcon.mas_right).offset(10);
        make.right.mas_equalTo(weakSelf.mas_centerX);
        make.height.mas_equalTo(15);
    }];
    
    [_shopIntro sizeToFit];
    [self.shopIntro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.shopName.mas_bottom).offset(2);
        make.left.mas_equalTo(weakSelf.shopName);
        make.right.mas_equalTo(weakSelf);
        make.height.mas_equalTo(13);
    }];
    
    [self.shopDistance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.shopIcon);
        make.left.mas_equalTo(weakSelf.mas_centerX);
        make.right.mas_equalTo(weakSelf).offset(-10);
        make.height.mas_equalTo(13);
    }];
    
    [self.shopStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.shopName);
        make.bottom.mas_equalTo(weakSelf).offset(-8);
        make.height.mas_equalTo(13);
        make.width.mas_equalTo(13 * 5);
    }];
    
    [self.shopPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf).offset(-5);
        make.height.mas_equalTo(13);
        make.left.mas_equalTo(weakSelf.shopStarView.mas_right).offset(10);
        make.width.mas_equalTo(100);
    }];
    
    [self.shopSaleCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf).offset(-5);
        make.right.mas_equalTo(weakSelf).offset(-10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(13);
    }];
}

#pragma mark - 外部接口

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuseId = @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    return cell;
}

#pragma mark - 属性赋值函数
- (void)setShop:(IOShop *)shop {
    _shop = shop;
    
    NSString *pictureStr = [NSString stringWithFormat:@"%@%@", kIOHTTPPictureServerUrl, _shop.picture];
    NSURL *pictureURL = [NSURL URLWithString:pictureStr];
    [_shopIcon sd_setImageWithURL:pictureURL placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    _shopName.text = _shop.name;
    _shopName.font = [UIFont systemFontOfSize:15];
    [_shopIcon sizeToFit];
    
    _shopIntro.text = _shop.cheapInfo;
    _shopIntro.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    _shopIntro.font = [UIFont systemFontOfSize:13];
    
    _shopDistance.text = [NSString stringWithFormat:@"%ldkm", _shop.distance / 1000];
    _shopDistance.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    _shopDistance.font = [UIFont systemFontOfSize:13];
    
    _shopStarView.startCount = _shop.score;
    
    _shopPrice.text = [NSString stringWithFormat:@"¥%.2f/人", _shop.personalPrice];
    _shopPrice.font = [UIFont systemFontOfSize:13];
    _shopPrice.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    
    _shopSaleCount.text = [NSString stringWithFormat:@"已售%ld", _shop.totalSale];
    _shopSaleCount.font = [UIFont systemFontOfSize:13];
    _shopSaleCount.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
}

@end

@interface IOHomeShopStarView ()

@property (nonatomic, strong) NSMutableArray *stars;

@end

@implementation IOHomeShopStarView

#pragma mark - 懒加载属性

- (NSMutableArray *)stars {
    if (!_stars) {
        _stars = [NSMutableArray array];
    }
    return _stars;
}

#pragma mark - 系统回调函数

- (instancetype)init {
    if (self = [super init]) {
        _stars = [self stars];
        //        1.设置界面相关函数
        [self setupAllSubViews];
        //        2.设置约束相关函数
        [self setupConstraints];
    }
    return self;
}

#pragma mark - 设置界面相关函数

- (void)setupAllSubViews {
    for (NSInteger i = 0; i < 5; i++) {
        UIImageView *star = [[UIImageView alloc] init];
        [self addSubview:star];
        [_stars addObject:star];
    }
}

#pragma mark - 设置约束相关函数

- (void)setupConstraints {
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
}

#pragma mark - 属性赋值函数

- (void)setStartCount:(float)startCount {
    _startCount = startCount;
    
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

@interface IOHomeCellHeaderView ()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *title;
@property (nonatomic, weak) UIView *underLineView;

@end

@implementation IOHomeCellHeaderView

#pragma mark - 系统回调函数

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
        make.width.equalTo(@100);
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
