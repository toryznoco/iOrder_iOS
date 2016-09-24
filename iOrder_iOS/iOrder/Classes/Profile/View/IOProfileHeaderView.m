//
//  IOProfileHeaderView.m
//  iOrder
//
//  Created by Tory on 16/5/13.
//  Copyright © 2016年 易无解. All rights reserved.
//

#import "IOProfileHeaderView.h"

#import "IOUserInfo.h"
#import "UIView+Masonry_YWJ.h"

#define kIOProfileBackgroundColor [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1]  //我的界面背景颜色
#define kIOProfileTitleColor [UIColor colorWithRed:172/255.0 green:172/255.0 blue:172/255.0 alpha:1]  //我的界面文字颜色
#define kIOProfileUserIconWidth 80  //用户头像高度和宽度

#pragma mark - implementation IOProfileHeaderView
@interface IOProfileHeaderView ()

@property (nonatomic, weak) UIView *background;
@property (nonatomic, weak) IOUserInfoView *userInfoView;
@property (nonatomic, weak) IOAssetsView *assetsView;

@end

@implementation IOProfileHeaderView

#pragma mark - privacy
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
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
    UIView *background = [[UIView alloc] init];
    background.backgroundColor = kIOProfileBackgroundColor;
    [self addSubview:background];
    _background = background;
    
    IOUserInfoView *userInfoView = [[IOUserInfoView alloc] initWithFrame:CGRectMake(0, 0, self.width, 180)];
    [self addSubview:userInfoView];
    _userInfoView = userInfoView;
    
    IOAssetsView *assetsView = [[IOAssetsView alloc] initWithFrame:CGRectMake(0, 180, self.width, 65)];
    [self addSubview:assetsView];
    _assetsView = assetsView;
}

#pragma mark - masonry

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    [super updateConstraints];
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
    firstAsset.iconName = @"profile_MyWallet";
    firstAsset.assetName = @"我的钱包";
    
    IOAssetView *secondAsset = [[IOAssetView alloc] init];
    [self addSubview:secondAsset];
    _secondAsset = secondAsset;
    secondAsset.unit = @"张";
    secondAsset.iconName = @"profile_RedPacket";
    secondAsset.assetName = @"iOrder红包";
    
    IOAssetView *thirdAsset = [[IOAssetView alloc] init];
    [self addSubview:thirdAsset];
    _thirdAsset = thirdAsset;
    thirdAsset.unit = @"张";
    thirdAsset.iconName = @"profile_Voucher";
    thirdAsset.assetName = @"商家代金券";
}

#pragma mark - Masonry

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    UIView *superView = self;
    NSInteger padding = 1;
    
    [self.firstAsset mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top);
        make.left.equalTo(superView.mas_left);
        make.bottom.equalTo(superView.mas_bottom);
        make.right.equalTo(_secondAsset.mas_left).offset(-padding);
        
        make.width.equalTo(@[_secondAsset, _thirdAsset]);
    }];
    
    [self.secondAsset mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top);
        make.left.equalTo(_firstAsset.mas_right).offset(padding);
        make.bottom.equalTo(superView.mas_bottom);
        make.right.equalTo(_thirdAsset.mas_left).offset(-padding);
        
        make.width.equalTo(@[_firstAsset, _thirdAsset]);
    }];
    
    [self.thirdAsset mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top);
        make.left.equalTo(_secondAsset.mas_right).offset(padding);
        make.bottom.equalTo(superView.mas_bottom);
        make.right.equalTo(superView.mas_right);
        
        make.width.equalTo(@[_firstAsset, _secondAsset]);
    }];
    
    [super updateConstraints];
}

@end


#pragma mark - implementation IOUserInfoView
@interface IOUserInfoView ()

@property (nonatomic, weak) UIImageView *backgroundIMG;
@property (nonatomic, weak) UIImageView *userIcon;
@property (nonatomic, weak) UILabel *userName;

@end

@implementation IOUserInfoView

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
    
}

#pragma mark - public

- (void)setUserInfo:(IOUserInfo *)userInfo {
    _userInfo = userInfo;
    
    _userIcon.image = [UIImage imageNamed:_userInfo.userIcon];
    
    _userName.text = _userInfo.userName;
}

#pragma mark - custom methods

- (void)setupAllChildView {
    UIImageView *backgroundIMG = [[UIImageView alloc] init];
    UIImage *bgIMG = [UIImage imageNamed:@"profile_backgroundImage"];
    [backgroundIMG setImage:bgIMG];
    [self addSubview:backgroundIMG];
    _backgroundIMG = backgroundIMG;
    
    UIImageView *userIcon = [[UIImageView alloc] init];
    userIcon.layer.cornerRadius = kIOProfileUserIconWidth / 2.0;
    userIcon.layer.masksToBounds = YES;
    [self addSubview:userIcon];
    _userIcon = userIcon;
    
    UILabel *userName = [[UILabel alloc] init];
    userName.font = [UIFont systemFontOfSize:15];
    userName.textAlignment = NSTextAlignmentCenter;
    userName.textColor = [UIColor whiteColor];
    [self addSubview:userName];
    _userName = userName;
}

#pragma mark - Masonry

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.backgroundIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(kIOProfileUserIconWidth));
        make.left.equalTo(self).offset(15);
        make.bottom.equalTo(self).offset(-50);
        make.right.equalTo(self.userName.mas_left).offset(-15);
    }];
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userIcon.mas_right).offset(15);
        make.centerY.equalTo(self.userIcon.mas_centerY);
        make.width.equalTo(@150);
        make.height.equalTo(@15);
    }];
    
    [super updateConstraints];
}

@end


#pragma mark - implementation IOAssetView

@interface IOAssetView ()

@property (nonatomic, weak) UILabel *countLabel;
@property (nonatomic, weak) UILabel *unitLabel;
@property (nonatomic, weak) UIImageView *assetIcon;
@property (nonatomic, weak) UILabel *assetNameLabel;

@property (nonatomic, strong) NSArray *upLabels;
@property (nonatomic, strong) NSArray *downLabels;

@end

@implementation IOAssetView

#pragma mark - privacy
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.backgroundColor = [UIColor whiteColor];
        [self setupAllChildView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
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
    countLabel.textColor = kIOProfileTitleColor;
    countLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:countLabel];
    _countLabel = countLabel;
    
    UILabel *unitLabel = [[UILabel alloc] init];
    unitLabel.textColor = kIOProfileTitleColor;
    unitLabel.font = [UIFont systemFontOfSize:13];
    unitLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:unitLabel];
    _unitLabel = unitLabel;
    
    self.upLabels = @[countLabel, unitLabel];
    
    UIImageView *assetIcon = [[UIImageView alloc] init];
    [self addSubview:assetIcon];
    _assetIcon = assetIcon;
    
    UILabel *assetNameLabel = [[UILabel alloc] init];
    assetNameLabel.textColor = kIOProfileTitleColor;
    assetNameLabel.font = [UIFont systemFontOfSize:13];
    assetNameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:assetNameLabel];
    _assetNameLabel = assetNameLabel;
    
    self.downLabels = @[assetIcon, assetNameLabel];
}

#pragma mark - Masonry
+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.unitLabel.mas_left).offset(-5);
        
        make.height.mas_equalTo(17);
        make.width.equalTo(self.unitLabel.mas_width);
    }];

    [self.unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.countLabel.mas_right).offset(5);
        make.right.equalTo(self.mas_right);
        
        make.height.mas_equalTo(13);
        make.width.equalTo(self.countLabel.mas_width);
    }];

    [self.upLabels mas_updateConstraints:^(MASConstraintMaker *make) {
        make.baseline.equalTo(self.mas_centerY).offset(-5);
    }];
    [self.assetIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 17));
    }];

    [self.assetNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    
    [self distributeSpacingHorizontallyWith:self.downLabels];
    
    [self.downLabels mas_updateConstraints:^(MASConstraintMaker *make) {
        make.baseline.equalTo(self.mas_centerY).offset(25);
    }];
    
    [super updateConstraints];
}

@end
