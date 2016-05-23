//
//  IOShopHeaderView.m
//  iOrder
//
//  Created by 易无解 on 5/13/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOShopHeaderView.h"
#import "IOShopOptionView.h"

#pragma mark - implementation IOShopHeaderView
#import "IOShop.h"

@interface IOShopHeaderView ()

@property (nonatomic, weak) IOShopInfoView *shopInfoView;
@end

@implementation IOShopHeaderView

#pragma mark - privacy
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kIOThemeColors;
        
        [self setupChildViewWithFrame:frame];
    }
    return self;
}

#pragma mark - public

- (void)setShopInfo:(IOShop *)shopInfo {
    _shopInfo = shopInfo;
    _shopInfoView.shopInfo = shopInfo;
}

#pragma mark - custom methods
- (void)setupChildViewWithFrame:(CGRect)frame {
    IOShopInfoView *infoView = [[IOShopInfoView alloc] initWithFrame:CGRectMake(0, 64, frame.size.width, 72)];
    _shopInfoView = infoView;
    [self addSubview:infoView];
}

@end


#pragma mark - implementation IOShopInfoView
#import "IOShop.h"
#import "UIImageView+WebCache.h"

@interface IOShopInfoView ()

@property (nonatomic, weak) UIImageView *shopIcon;
@property (nonatomic, weak) UILabel *shopTitle;
@property (nonatomic, weak) UILabel *waitingTime;
@property (nonatomic, weak) UIImageView *hintImage;
@property (nonatomic, weak) UILabel *hintInfo;
@property (nonatomic, weak) UIImageView *rearArrow;

@end

@implementation IOShopInfoView

#pragma mark - privacy
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupChildViewWithFrame:frame];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat shopIconW = 62;
    CGFloat shopIconH = shopIconW;
    CGFloat shopIconX = 14;
    CGFloat shopIconY = 0;
    _shopIcon.frame = CGRectMake(shopIconX, shopIconY, shopIconW, shopIconH);
    
    CGFloat shopTitleW = 308;
    CGFloat shopTitleH = 20;
    CGFloat shopTitleX = CGRectGetMaxX(_shopIcon.frame) + 15;
    CGFloat shopTitleY = shopIconY;
    _shopTitle.frame = CGRectMake(shopTitleX, shopTitleY, shopTitleW, shopTitleH);
    
    CGFloat waitingTimeW = 100;
    CGFloat waitingTimeH = 15;
    CGFloat waitingTimeX = shopTitleX;
    CGFloat waitingTimeY = CGRectGetMaxY(_shopTitle.frame) + 2;
    _waitingTime.frame = CGRectMake(waitingTimeX, waitingTimeY, waitingTimeW, waitingTimeH);
    
    CGFloat hintImageW = 32;
    CGFloat hintImageH = 28;
    CGFloat hintImageX = waitingTimeX;
    CGFloat hintImageY = CGRectGetMaxY(_waitingTime.frame) + 2;
    _hintImage.frame = CGRectMake(hintImageX, hintImageY, hintImageW, hintImageH);
    
    CGFloat hintInfoW = 236;
    CGFloat hintInfoH = 20;
    CGFloat hintInfoX = CGRectGetMaxX(_hintImage.frame) + 7;
    CGFloat hintInfoY = hintImageY + 4;
    _hintInfo.frame = CGRectMake(hintInfoX, hintInfoY, hintInfoW, hintInfoH);
    
    CGFloat rearArrowW = 12;
    CGFloat rearArrowH = 17;
    CGFloat rearArrowX = self.width - rearArrowW - 15;
    CGFloat rearArrowY = hintInfoY;
    _rearArrow.frame = CGRectMake(rearArrowX, rearArrowY, rearArrowW, rearArrowH);
}

#pragma mark - public

- (void)setShopInfo:(IOShop *)shopInfo {
    
    YWJLog(@" haha %@", shopInfo.name);
    _shopInfo = shopInfo;
    [self setupShopInfo];
}

#pragma mark - custom methods

- (void)setupShopInfo {
    NSString *pictureStr = [NSString stringWithFormat:@"%@%@", kPictureServerPath, _shopInfo.picture];
    NSURL *pictureURL = [NSURL URLWithString:pictureStr];
    [_shopIcon sd_setImageWithURL:pictureURL placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    _shopTitle.text = _shopInfo.name;
    
    _hintInfo.text = _shopInfo.cheap;
}

- (void)setupChildViewWithFrame:(CGRect)frame {
    UIImageView *shopIcon = [[UIImageView alloc] init];
    shopIcon.layer.cornerRadius = 31;
    shopIcon.layer.masksToBounds = YES;
    _shopIcon = shopIcon;
    [self addSubview:shopIcon];
    
    UILabel *shopTitle = [[UILabel alloc] init];
    _shopTitle = shopTitle;
    [self addSubview:shopTitle];
    
    UILabel *waitingTime = [[UILabel alloc] init];
    waitingTime.text = @"15分钟";
    waitingTime.font = [UIFont systemFontOfSize:15];
    _waitingTime = waitingTime;
    [self addSubview:waitingTime];
    
    UIImageView *hintImage = [[UIImageView alloc] init];
    [hintImage setImage:[UIImage imageNamed:@"trumpet"]];
    _hintImage = hintImage;
    [self addSubview:hintImage];
    
    UILabel *hintInfo = [[UILabel alloc] init];
    _hintInfo = hintInfo;
    [self addSubview:hintInfo];
    
    UIImageView *rearArrow = [[UIImageView alloc] init];
    [rearArrow setImage:[UIImage imageNamed:@"home_shop_arrow"]];
    _rearArrow = rearArrow;
    [self addSubview:rearArrow];
}

@end