//
//  IOProfileCell.m
//  iOrder
//
//  Created by 易无解 on 5/25/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import "IOProfileCell.h"

#define kIOProfileTitleFont [UIFont systemFontOfSize:15] //我的界面字体大小
#define kIOProfileTitleColor [UIColor colorWithRed:172/255.0 green:172/255.0 blue:172/255.0 alpha:1] //我的界面字体颜色

@interface IOProfileCell ()

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIImageView *accessoryImageView;

@end

@implementation IOProfileCell

#pragma mark - privacy

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupAllChildView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - public

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuseId = @"ProfileCell";
    id cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    
    return cell;
}

- (void)setIconName:(NSString *)iconName {
    _iconName = iconName;
    
    _iconImageView.image = [UIImage imageNamed:iconName];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    _titleLabel.text = title;
}


#pragma mark - custom methods

- (void)setupAllChildView {
    UIImageView *iconImageView = [[UIImageView alloc] init];
    _iconImageView = iconImageView;
    [self addSubview:iconImageView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = kIOProfileTitleFont;
    titleLabel.textColor = kIOProfileTitleColor;
    _titleLabel = titleLabel;
    [self addSubview:titleLabel];
    
    UIImageView *accessoryImageView = [[UIImageView alloc] init];
    accessoryImageView.image = [UIImage imageNamed:@"profile_arrows"];
    _accessoryImageView = accessoryImageView;
    [self addSubview:accessoryImageView];
}

#pragma mark - masonry

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.centerY.equalTo(self);
        make.width.height.equalTo(@15);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(9);
        make.centerY.equalTo(self);
        make.width.equalTo(@200);
        make.height.equalTo(@15);
    }];
    
    [self.accessoryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.bottom.equalTo(self).offset(-15);
        make.right.equalTo(self).offset(-12);
        make.centerY.equalTo(self);
        make.width.equalTo(@9);
    }];
    
    [super updateConstraints];
}

@end
