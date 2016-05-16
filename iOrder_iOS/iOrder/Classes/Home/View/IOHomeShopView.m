//
//  IOHomeShopHeaderView.m
//  iOrder
//
//  Created by 易无解 on 5/13/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOHomeShopView.h"

#pragma mark - implementation IOHomeShopHeaderView
#import "IOShop.h"

@interface IOHomeShopHeaderView ()

@property (nonatomic, weak) IOHomeShopInfoView *shopInfoView;
@end

@implementation IOHomeShopHeaderView

#pragma mark - privacy
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"005"]];
        
        [self setupChildViewWithFrame:frame];
    }
    return self;
}

#pragma mark - public

- (void)setShopInfo:(IOShop *)shopInfo{
    _shopInfo = shopInfo;
    _shopInfoView.shopInfo = shopInfo;
}

#pragma mark - custom methods
- (void)setupChildViewWithFrame:(CGRect)frame{
    IOHomeShopInfoView *infoView = [[IOHomeShopInfoView alloc] initWithFrame:CGRectMake(0, 64, frame.size.width, 72)];
    _shopInfoView = infoView;
    [self addSubview:infoView];
    
    IOHomeShopOptionView *optionView = [[IOHomeShopOptionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(infoView.frame), frame.size.width, 40)];
    [self addSubview:optionView];
}

@end


#pragma mark - implementation IOHomeShopInfoView
#import "IOShop.h"
#import "UIImageView+WebCache.h"

@interface IOHomeShopInfoView ()

@property (nonatomic, weak) UIImageView *shopIcon;
@property (nonatomic, weak) UILabel *shopTitle;
@property (nonatomic, weak) UILabel *waitingTime;
@property (nonatomic, weak) UIImageView *hintImage;
@property (nonatomic, weak) UILabel *hintInfo;
@property (nonatomic, weak) UIImageView *rearArrow;

@end

@implementation IOHomeShopInfoView

#pragma mark - privacy
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupChildViewWithFrame:frame];
    }
    return self;
}

- (void)layoutSubviews{
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

- (void)setShopInfo:(IOShop *)shopInfo{
    
    YWJLog(@" haha %@", shopInfo.name);
    _shopInfo = shopInfo;
    [self setupShopInfo];
}

#pragma mark - custom methods

- (void)setupShopInfo{
    NSString *pictureStr = [NSString stringWithFormat:@"%@%@", kPictureServerPath, _shopInfo.picture];
    NSURL *pictureURL = [NSURL URLWithString:pictureStr];
    [_shopIcon sd_setImageWithURL:pictureURL placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    _shopTitle.text = _shopInfo.name;
    
    _hintInfo.text = _shopInfo.cheap;
}

- (void)setupChildViewWithFrame:(CGRect)frame{
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


#pragma mark - implementation IOHomeShopOptionView
@interface IOHomeShopOptionView ()

@property (nonatomic, strong) NSMutableArray *optionBtns;
@property (nonatomic, strong) NSMutableArray *seletedTags;

@end

@implementation IOHomeShopOptionView

#pragma mark - privacy
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self optionBtns];
        [self seletedTags];
        [self setupChildViewWithFrame:frame];
    }
    return self;
}

- (NSMutableArray *)optionBtns{
    if (!_optionBtns) {
        _optionBtns = [NSMutableArray array];
    }
    return _optionBtns;
}

- (NSMutableArray *)seletedTags{
    if (!_seletedTags) {
        _seletedTags = [NSMutableArray array];
    }
    return _seletedTags;
}

#pragma mark - custom methods

- (void)setupChildViewWithFrame:(CGRect)frame{
    CGFloat optionViewH = frame.size.width / 3.0;
    
    UIView *optionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, optionViewH, frame.size.height)];
    [self addSubview:optionView];
    [optionView addSubview:[self optionBtnWithRect:CGRectMake(0, 0, optionView.frame.size.width, optionView.frame.size.height) tag:1 title:@"点菜"]];
    UIView *selectedTag = [self selectedViewWithRect:CGRectMake(0, 36, optionView.frame.size.width, 4) tag:1];
    selectedTag.hidden = NO;
    [optionView addSubview:selectedTag];
    
    UIView *optionView1 = [[UIView alloc] initWithFrame:CGRectMake(optionViewH, 0, optionViewH, frame.size.height)];
    [self addSubview:optionView1];
    [optionView1 addSubview:[self optionBtnWithRect:CGRectMake(0, 0, optionView1.frame.size.width, optionView1.frame.size.height) tag:2 title:@"评价"]];
    [optionView1 addSubview:[self selectedViewWithRect:CGRectMake(0, 36, optionView1.frame.size.width, 4) tag:2]];
    
    UIView *optionView2 = [[UIView alloc] initWithFrame:CGRectMake(2 * optionViewH, 0, optionViewH, frame.size.height)];
    [self addSubview:optionView2];
    [optionView2 addSubview:[self optionBtnWithRect:CGRectMake(0, 0, optionView2.frame.size.width, optionView2.frame.size.height) tag:3 title:@"商家"]];
    [optionView2 addSubview:[self selectedViewWithRect:CGRectMake(0, 36, optionView2.frame.size.width, 4) tag:3]];
}

- (UIButton *)optionBtnWithRect:(CGRect)frame tag:(NSInteger)tag title:(NSString *)title{
    UIButton *optionBtn = [[UIButton alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
    [_optionBtns addObject:optionBtn];
    [optionBtn addTarget:self action:@selector(optionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    optionBtn.tag = tag;
    [optionBtn setTitle:title forState:UIControlStateNormal];
    [optionBtn setTitleColor:YWJRGBColor(92, 91, 92, 1) forState:UIControlStateNormal];
    [optionBtn setTitleColor:YWJRGBColor(35, 35, 35, 1) forState:UIControlStateHighlighted];
    return optionBtn;
}

- (UIView *)selectedViewWithRect:(CGRect)frame tag:(NSInteger)tag{
    UIView *selectedTag = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
    [_seletedTags addObject:selectedTag];
    selectedTag.tag = tag;
    selectedTag.hidden = YES;
    selectedTag.backgroundColor = [UIColor orangeColor];
    return selectedTag;
}

- (void)optionBtnClick:(UIButton *)btn{
    for (UIView *selected in _seletedTags) {
        if (btn.tag == selected.tag) {
            selected.hidden = NO;
        }else{
            selected.hidden = YES;
        }
    }
    YWJLog(@"click %ld", btn.tag);
}

@end