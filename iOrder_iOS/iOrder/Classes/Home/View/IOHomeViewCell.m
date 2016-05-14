//
//  IOHomeViewCell.m
//  iOrder
//
//  Created by 易无解 on 4/17/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOHomeViewCell.h"

#import "IOShop.h"
#import "UIImageView+WebCache.h"


#pragma mark - implementation IOHomeViewCell
@interface IOHomeViewCell ()

@property (nonatomic, weak) UIImageView *shopIcon;
@property (nonatomic, weak) UILabel *shopName;
@property (nonatomic, weak) UILabel *shopIntro;
@property (nonatomic, weak) UILabel *shopDistance;
@property (nonatomic, weak) IOHomeShopStarView *shopStarView;
@property (nonatomic, weak) UILabel *shopPrice;
@property (nonatomic, weak) UILabel *shopSaleCount;

@end

@implementation IOHomeViewCell

#pragma mark - privacy

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupAllChildView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews{
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
    CGFloat starViewY = self.height - starViewH - 5;
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

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *reuseId = @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    return cell;
}

- (void)setShop:(IOShop *)shop{
    _shop = shop;
    
    [self setupShopInfo];
}

#pragma custom methods

- (void)setupShopInfo{
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

- (void)setupAllChildView{
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

- (NSMutableArray *)stars{
    if (!_stars) {
        _stars = [NSMutableArray array];
    }
    return _stars;
}

- (instancetype)init{
    if (self = [super init]) {
        _stars = [self stars];
        [self setupAllChildView];
    }
    return self;
}

#pragma mark - public

- (void)setStartCount:(float)startCount{
    _startCount = startCount;
    
    [self setupData];
}

#pragma mark - custom methods

- (void)setupAllChildView{
    CGFloat starX = 0;
    CGFloat starY = 0;
    CGFloat starW = 16;
    CGFloat starH = 16;
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

- (void)setupData{
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


#pragma mark - implementation IOHomeHeaderView
@interface IOHomeHeaderView ()

@property (nonatomic, weak) IOScrollView *scrollView;
@property (nonatomic, weak) IOSpecialView *specialView;
@property (nonatomic, weak) IOTitleView *titleView;

@end

@implementation IOHomeHeaderView

#pragma mark - privacy

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
        //        设置headerView的大小
        self.width = YWJKeyWindow.bounds.size.width;
        self.height = 305;
        
        [self setupAllChildView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat scrollViewW = self.width;
    CGFloat scrollViewH = 160;
    CGFloat scrollViewX = 0;
    CGFloat scrollViewY = 0;
    _scrollView.frame = CGRectMake(scrollViewX, scrollViewY, scrollViewW, scrollViewH);
    
    CGFloat specialViewW = scrollViewW;
    CGFloat specialViewH = 100;
    CGFloat specialViewX = 0;
    CGFloat specialViewY = CGRectGetMaxY(_scrollView.frame) + 10;
    _specialView.frame = CGRectMake(specialViewX, specialViewY, specialViewW, specialViewH);
    
    CGFloat titleViewW = scrollViewW;
    CGFloat titleViewH = 25;
    CGFloat titleViewX = 0;
    CGFloat titleViewY = CGRectGetMaxY(_specialView.frame) + 9;
    _titleView.frame = CGRectMake(titleViewX, titleViewY, titleViewW, titleViewH);
}

#pragma mark - custom methods

- (void)setupAllChildView{
    NSArray *images = @[@"roll_image_1.png",
                        @"roll_image_2.png",
                        @"roll_image_3.png"];
    IOScrollView *scrollView = [[IOScrollView alloc] init];
    [self addSubview:scrollView];
    _scrollView = scrollView;
    _scrollView.images = images;
    
    NSArray *datas = @[@"weekend_bargain_image.png",
                       @"bargain_price_image.png",
                       @"new_products_image.png"];
    IOSpecialView *specialView = [[IOSpecialView alloc] init];
    [self addSubview:specialView];
    _specialView = specialView;
    _specialView.datas = datas;
    
    IOTitleView *titleView = [[IOTitleView alloc] init];
    [self addSubview:titleView];
    _titleView = titleView;
}

@end


#pragma mark - implementation IOScrollView
@interface IOScrollView ()<SDCycleScrollViewDelegate>

@property (nonatomic, weak) SDCycleScrollView *cycleScrollView;

@end

@implementation IOScrollView

#pragma mark - privacy

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:0.99];
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"005.jpg"]];
        backgroundView.frame = CGRectMake(0, 0, YWJKeyWindow.width, 160);
        [self addSubview:backgroundView];
        
        SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, YWJKeyWindow.width, 160) shouldInfiniteLoop:YES imageNamesGroup:nil];
        [self addSubview:cycleScrollView];
        _cycleScrollView = cycleScrollView;
        
        cycleScrollView.delegate = self;
        cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        cycleScrollView.autoScrollTimeInterval = 4.0;
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - public

- (void)setImages:(NSArray *)images{
    _images = images;
    
    _cycleScrollView.localizationImageNamesGroup = images;
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    YWJLog(@"点击了某张图片");
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    YWJLog(@"滑动到第几张图片");
}

@end


#pragma mark - implementation IOSpecialView
@interface IOSpecialView ()

@property (nonatomic, weak) UIImageView *weekendView;
@property (nonatomic, weak) UIImageView *dayView;
@property (nonatomic, weak) UIImageView *specialView;

@end

@implementation IOSpecialView

#pragma mark - privacy

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupAllChildView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat weekendW = YWJKeyWindow.width * 0.5 - 0.5;
    CGFloat weekendH = 100;
    CGFloat weekendX = 0;
    CGFloat weekendY = 0;
    _weekendView.frame = CGRectMake(weekendX, weekendY, weekendW, weekendH);
    
    CGFloat dayW = weekendW;
    CGFloat dayH = 49.5;
    CGFloat dayX = CGRectGetMaxX(_weekendView.frame) + 1.0;
    CGFloat dayY = 0;
    _dayView.frame = CGRectMake(dayX, dayY, dayW, dayH);
    
    CGFloat specialW = dayW;
    CGFloat specialH = dayH;
    CGFloat specialX = dayX;
    CGFloat specialY = CGRectGetMaxY(_dayView.frame) + 1.0;
    _specialView.frame = CGRectMake(specialX, specialY, specialW, specialH);
}

#pragma mark - public

- (void)setDatas:(NSArray *)datas{
    _datas = datas;
    
    _weekendView.image = [UIImage imageNamed:datas[0]];
    _dayView.image = [UIImage imageNamed:datas[1]];
    _specialView.image = [UIImage imageNamed:datas[2]];
}

#pragma mark - custom methods

- (void)setupAllChildView{
    UIImageView *weekendView = [[UIImageView alloc] init];
    weekendView.contentMode = UIViewContentModeCenter;
    [self addSubview:weekendView];
    weekendView.backgroundColor = [UIColor whiteColor];
    _weekendView = weekendView;
    
    UIImageView *dayView = [[UIImageView alloc] init];
    dayView.contentMode = UIViewContentModeCenter;
    [self addSubview:dayView];
    dayView.backgroundColor = [UIColor whiteColor];
    _dayView = dayView;
    
    UIImageView *specialView = [[UIImageView alloc] init];
    specialView.contentMode = UIViewContentModeCenter;
    [self addSubview:specialView];
    specialView.backgroundColor = [UIColor whiteColor];
    _specialView = specialView;
}

@end

#pragma mark - implementation IOTitleView
@interface IOTitleView ()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *title;

@end

@implementation IOTitleView

#pragma mark - privacy

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupAllChildView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat iconW = 21;
    CGFloat iconH = 21;
    CGFloat iconX = 10;
    CGFloat iconY = 2;
    _iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat titleW = _title.width;
    CGFloat titleH = _title.height;
    CGFloat titleX = CGRectGetMaxX(_iconView.frame) + 10;
    CGFloat titleY = 3;
    _title.frame = CGRectMake(titleX, titleY, titleW, titleH);
}

#pragma mark - custom methods

- (void)setupAllChildView{
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;
    
    _iconView.image = [UIImage imageNamed:@"store_image"];
    
    UILabel *title = [[UILabel alloc] init];
    [self addSubview:title];
    title.text = @"附近商家";
    title.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    title.font = [UIFont systemFontOfSize:15];
    [title sizeToFit];
    _title = title;
}

@end


