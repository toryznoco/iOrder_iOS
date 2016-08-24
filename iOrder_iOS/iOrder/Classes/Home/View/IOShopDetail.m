//
//  IOShopDetail.m
//  iOrder
//
//  Created by 易无解 on 8/24/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOShopDetail.h"

#import "IOShopDetailCellInfo.h"

#pragma mark - implementation IOShopDetail

@interface IOShopDetail ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *shopDetailTableView;

@end

@implementation IOShopDetail

#pragma mark - privacy

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        1、设置自己的属性
        
//        2、添加所有子控件
        [self setupAllChildView];
    }
    
    return self;
}

#pragma mark - custom

- (void)setupAllChildView {//添加所有子控件
//    1、添加TableView
    UITableView *shopDetailTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self addSubview:shopDetailTableView];
    shopDetailTableView.rowHeight = 49;
    shopDetailTableView.dataSource = self;
    shopDetailTableView.delegate = self;
    _shopDetailTableView = shopDetailTableView;
}


#pragma mark - masonry

+ (BOOL)requiresConstraintBasedLayout { //返回view是否是约束布局模式,返回值决定了是否是autoLayout布局模式
    return YES;
}

- (void)updateConstraints {//更新约束
    [self.shopDetailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.bottom.equalTo(self);
        make.right.equalTo(self);
    }];
    
    [super updateConstraints];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { // 返回组数
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
//    设置cell的数据
    if (indexPath.section == 0) {
        IOShopDetailCellInfo *info = [[IOShopDetailCellInfo alloc] init];
        switch (indexPath.row) {
            case 0:
                cell = [IOShopDetailCell1 cellWithTableView:tableView];
                info.iconName = @"time_icon";
                info.title = @"营业时间";
                info.detail = @"8:30-22:00";
                
                ((IOShopDetailCell1 *)cell).info = info;
                break;
                
            case 1:
                cell = [IOShopDetailCell cellWithTableView:tableView];
                info.iconName = @"address_icon1";
                info.detail = @"青城山东软大道365号";
                
                ((IOShopDetailCell *)cell).info = info;
                break;
                
            case 2:
                cell = [IOShopDetailCell cellWithTableView:tableView];
                info.iconName = @"phone_icon";
                info.detail = @"13308050850";
                
                ((IOShopDetailCell *)cell).info = info;
                break;
                
            case 3:
                cell = [IOShopDetailCell cellWithTableView:tableView];
                info.iconName = @"horn_icon";
                info.detail = @"本店欢迎你下单，用餐高峰期请提前下单，谢谢！";
                
                ((IOShopDetailCell *)cell).info = info;
                break;
                
            default:
                break;
        }
    } else {
        IOShopDetailCellInfo *info = [[IOShopDetailCellInfo alloc] init];
        switch (indexPath.row) {
            case 0:
                cell = [IOShopDetailCell cellWithTableView:tableView];
                info.iconName = @"pay_backgroud_rectangle";
                info.detail = @"支持在线支付";
                
                ((IOShopDetailCell *)cell).info = info;
                break;
                
            default:
                break;
        }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate


@end

#pragma mark - implementation IOShopDetailCell

@interface IOShopDetailCell ()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *detailLabel;

@end

@implementation IOShopDetailCell

#pragma mark - privace

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupAllChildView];
    }
    
    return self;
}

#pragma mark - public

+ (instancetype)cellWithTableView:(UITableView *)tableView {//通过tableview创建可重用的cell
    static NSString *reuseId = @"shopDetailReuseIdentifier";
    
    id cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    
    return cell;
}

- (void)setInfo:(IOShopDetailCellInfo *)info {
    _info = info;
    
    [_iconView setImage:[UIImage imageNamed:info.iconName]];
    _detailLabel.text = info.detail;
}

#pragma mark - custom

- (void)setupAllChildView {//添加所有子控件
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;
    
    UILabel *detailLabel = [[UILabel alloc] init];
    [self addSubview:detailLabel];
    _detailLabel = detailLabel;
}

#pragma mark - masonry

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {//更新所有子控件约束
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(19);
        make.left.equalTo(self).offset(8);
        make.right.equalTo(self.detailLabel.mas_left).offset(-8);
        make.width.and.height.equalTo(@20);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).offset(8);
        make.right.equalTo(self).offset(-8);
        make.centerY.equalTo(self.iconView.mas_centerY);
    }];
    
    [super updateConstraints];
}

@end


#pragma mark - implementation IOShopDetailCell1

@interface IOShopDetailCell1 ()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *detailLabel;

@end

@implementation IOShopDetailCell1

#pragma mark - privace

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupAllChildView];
    }
    
    return self;
}

#pragma mark - public

+ (instancetype)cellWithTableView:(UITableView *)tableView {//通过tableview创建可重用的cell
    static NSString *reuseId = @"shopDetailReuseIdentifier";
    
    id cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    
    return cell;
}

- (void)setInfo:(IOShopDetailCellInfo *)info {
    _info = info;
    
    [_iconView setImage:[UIImage imageNamed:info.iconName]];
    _titleLabel.text = info.title;
    _detailLabel.text = info.detail;
}

#pragma mark - custom

- (void)setupAllChildView {//添加所有子控件
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [self addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    UILabel *detailLabel = [[UILabel alloc] init];
    [self addSubview:detailLabel];
    _detailLabel = detailLabel;
}

#pragma mark - masonry

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {//更新所有子控件约束
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(19);
        make.left.equalTo(self).offset(8);
        make.right.equalTo(self.titleLabel.mas_left).offset(-8);
        make.width.and.height.equalTo(@20);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).offset(8);
        make.right.equalTo(self.detailLabel.mas_left).offset(-17);
        make.height.equalTo(@17);
        make.width.equalTo(@100);
        make.centerY.equalTo(self.iconView.mas_centerY);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(17);
        make.right.equalTo(self).offset(-8);
        make.height.equalTo(@17);
        make.centerY.equalTo(self.titleLabel.mas_centerY);
    }];
    
    [super updateConstraints];
}

@end
