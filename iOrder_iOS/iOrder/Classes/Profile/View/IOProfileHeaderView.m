//
//  IOProfileHeaderView.m
//  iOrder
//
//  Created by Tory on 16/5/13.
//  Copyright © 2016年 易无解. All rights reserved.
//

#import "IOProfileHeaderView.h"

#import "IOUserInfo.h"

#pragma mark - implementation IOProfileHeaderView
@interface IOProfileHeaderView ()

@property (nonatomic, weak) IOUserInfoView *userInfoView;
@property (nonatomic, weak) IOAssetsView *assetsView;

@end

@implementation IOProfileHeaderView

#pragma mark - privacy
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = YWJRGBColor(231, 231, 231, 1);
        
        [self setupAllChildView];
    }
    return self;
}

#pragma mark - public

- (void)setUserInfo:(IOUserInfo *)userInfo {
    _userInfo = userInfo;
    
    _userInfoView.userInfo = _userInfo;
    _assetsView.userInfo = _userInfo;
}


#pragma mark - custom methods

- (void)setupAllChildView {
    IOUserInfoView *userInfoView = [[IOUserInfoView alloc] initWithFrame:CGRectMake(0, 0, self.width, 180)];
    [self addSubview:userInfoView];
    _userInfoView = userInfoView;
    
    IOAssetsView *assetsView = [[IOAssetsView alloc] initWithFrame:CGRectMake(0, 180, self.width, 65)];
    [self addSubview:assetsView];
    _assetsView = assetsView;
}

@end


#pragma mark - implementation IOAssetsView

@interface IOAssetsView ()

@property (nonatomic, weak) IOAssetView *firstAsset;
@property (nonatomic, weak) IOAssetView *secondAsset;
@property (nonatomic, weak) IOAssetView *thirdAsset;

@end

@implementation IOAssetsView

#pragma mark - privacy
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = YWJRGBColor(231, 231, 231, 1);
        [self setupAllChildView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat firstAssetW = (self.width - 2) / 3.0;
    CGFloat firstAssetH = self.height;
    CGFloat firstAssetX = 0;
    CGFloat firstAssetY = 0;
    _firstAsset.frame = CGRectMake(firstAssetX, firstAssetY, firstAssetW, firstAssetH);
    
    CGFloat secondAssetW = firstAssetW;
    CGFloat secondAssetH = firstAssetH;
    CGFloat secondAssetX = CGRectGetMaxX(_firstAsset.frame) + 1;
    CGFloat secondAssetY = firstAssetY;
    _secondAsset.frame = CGRectMake(secondAssetX, secondAssetY, secondAssetW, secondAssetH);
    
    CGFloat thirdAssetW = firstAssetW;
    CGFloat thirdAssetH = firstAssetH;
    CGFloat thirdAssetX = CGRectGetMaxX(_secondAsset.frame) + 1;
    CGFloat thirdAssetY = firstAssetY;
    _thirdAsset.frame = CGRectMake(thirdAssetX, thirdAssetY, thirdAssetW, thirdAssetH);
}

- (void)setUserInfo:(IOUserInfo *)userInfo {
    _userInfo = userInfo;
    
    _firstAsset.count = userInfo.wallet;
    _secondAsset.count = userInfo.redPacket;
    _thirdAsset.count = userInfo.voucher;
}

#pragma mark - custom methods

- (void)setupAllChildView {
    IOAssetView *firstAsset = [[IOAssetView alloc] init];
    [self addSubview:firstAsset];
    _firstAsset = firstAsset;
    firstAsset.unit = @"元";
    firstAsset.iconName = @"my_wallet-0";
    firstAsset.assetName = @"我的钱包";
    
    IOAssetView *secondAsset = [[IOAssetView alloc] init];
    [self addSubview:secondAsset];
    _secondAsset = secondAsset;
    secondAsset.unit = @"张";
    secondAsset.iconName = @"red_packet";
    secondAsset.assetName = @"iOrder红包";
    
    IOAssetView *thirdAsset = [[IOAssetView alloc] init];
    [self addSubview:thirdAsset];
    _thirdAsset = thirdAsset;
    thirdAsset.unit = @"张";
    thirdAsset.iconName = @"voucher";
    thirdAsset.assetName = @"商家代金券";
}

@end


#pragma mark - implementation IOUserInfoView
@interface IOUserInfoView ()

@property (nonatomic, weak) UIImageView *userIcon;
@property (nonatomic, weak) UILabel *userName;

@end

@implementation IOUserInfoView

#pragma mark - privacy
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kIOThemeColors;
        [self setupAllChildView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat userIconW = 69;
    CGFloat userIconH = userIconW;
    CGFloat userIconX = self.width * 0.5;
    CGFloat userIconY = self.height * 0.4;
    _userIcon.frame = CGRectMake(0, 0, userIconW, userIconH);
    _userIcon.center = CGPointMake(userIconX, userIconY);
    
    CGFloat userNameW = self.width;
    CGFloat userNameH = 25;
    CGFloat userNameX = self.width * 0.5;
    CGFloat userNameY = CGRectGetMaxY(_userIcon.frame) + 15;
    _userName.frame = CGRectMake(0, 0, userNameW, userNameH);
    _userName.center = CGPointMake(userNameX, userNameY);
}

#pragma mark - public

- (void)setUserInfo:(IOUserInfo *)userInfo {
    _userInfo = userInfo;
    
    _userIcon.image = [UIImage imageNamed:_userInfo.userIcon];
    
    _userName.text = _userInfo.userName;
}

#pragma mark - custom methods

- (void)setupAllChildView {
    UIImageView *userIcon = [[UIImageView alloc] init];
    userIcon.layer.cornerRadius = 34.5;
    userIcon.layer.masksToBounds = YES;
    [self addSubview:userIcon];
    _userIcon = userIcon;
    
    UILabel *userName = [[UILabel alloc] init];
    userName.textAlignment = NSTextAlignmentCenter;
    [self addSubview:userName];
    _userName = userName;
}

@end


#pragma mark - implementation IOAssetView

@interface IOAssetView ()

@property (nonatomic, weak) UILabel *countLabel;
@property (nonatomic, weak) UILabel *unitLabel;
@property (nonatomic, weak) UIImageView *assetIcon;
@property (nonatomic, weak) UILabel *assetNameLabel;

@end

@implementation IOAssetView

#pragma mark - privacy
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupAllChildView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat countLabelW = self.width *0.5;
    CGFloat countLabelH = 20;
    CGFloat countLabelX = 0;
    CGFloat countLabelY = 12;
    _countLabel.frame = CGRectMake(countLabelX, countLabelY, countLabelW, countLabelH);
    
    CGFloat unitLabelW = 15;
    CGFloat unitLabelH = 15;
    CGFloat unitLabelX = CGRectGetMaxX(_countLabel.frame) + 5;
    CGFloat unitLabelY = countLabelY + 5;
    _unitLabel.frame = CGRectMake(unitLabelX, unitLabelY, unitLabelW, unitLabelH);
    
    CGFloat assetIconW = 20;
    CGFloat assetIconH = 17;
    CGFloat assetIconX = 25;
    CGFloat assetIconY = 40;
    _assetIcon.frame = CGRectMake(assetIconX, assetIconY, assetIconW, assetIconH);
    
    CGFloat assetNameLabelW = 85;
    CGFloat assetNameLabelH = 20;
    CGFloat assetNameLabelX = CGRectGetMaxX(_assetIcon.frame) + 5;
    CGFloat assetNameLabelY = 39;
    _assetNameLabel.frame = CGRectMake(assetNameLabelX, assetNameLabelY, assetNameLabelW, assetNameLabelH);
}

#pragma mark - public

- (void)setCount:(NSInteger)count {
    _count = count;
    
    _countLabel.text = [NSString stringWithFormat:@"%ld", count];
}

- (void)setUnit:(NSString *)unit {
    _unit = unit;
    
    _unitLabel.text = unit;
}

- (void)setIconName:(NSString *)iconName {
    _iconName = iconName;
    
    _assetIcon.image = [UIImage imageNamed:iconName];
}

- (void)setAssetName:(NSString *)assetName {
    _assetName = assetName;
    
    _assetNameLabel.text = assetName;
}

#pragma mark - custom methods

- (void)setupAllChildView {
    UILabel *countLabel = [[UILabel alloc] init];
    countLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:countLabel];
    _countLabel = countLabel;
    
    UILabel *unitLabel = [[UILabel alloc] init];
    unitLabel.font = [UIFont systemFontOfSize:13];
    unitLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:unitLabel];
    _unitLabel = unitLabel;
    
    UIImageView *assetIcon = [[UIImageView alloc] init];
    [self addSubview:assetIcon];
    _assetIcon = assetIcon;
    
    UILabel *assetNameLabel = [[UILabel alloc] init];
    assetNameLabel.font = [UIFont systemFontOfSize:13];
    assetNameLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:assetNameLabel];
    _assetNameLabel = assetNameLabel;
}

@end
