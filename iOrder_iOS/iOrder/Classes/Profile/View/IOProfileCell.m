//
//  IOProfileCell.m
//  iOrder
//
//  Created by 易无解 on 5/25/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOProfileCell.h"

@interface IOProfileCell ()

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIImageView *accessoryImageView;

@end

@implementation IOProfileCell

#pragma mark - privacy

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuseId = @"ProfileCell";
    id cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupAllChildView];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat iconImageViewW = 18;
    CGFloat iconImageViewH = 18;
    CGFloat iconImageViewX = iconImageViewW * 0.5 + 10;
    CGFloat iconImageViewY = self.height * 0.5;
    _iconImageView.frame = CGRectMake(0, 0, iconImageViewW, iconImageViewH);
    _iconImageView.center = CGPointMake(iconImageViewX, iconImageViewY);
    
    CGFloat titleW = 200;
    CGFloat titleH = 16;
    CGFloat titleX = CGRectGetMaxX(_iconImageView.frame) + 10;
    CGFloat titleY = _iconImageView.y;
    _titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat accessoryW = 8;
    CGFloat accessoryH = 13;
    CGFloat accessoryX = self.width - 20 - accessoryW * 0.5;
    CGFloat accessoryY = self.height * 0.5;
    _accessoryImageView.frame = CGRectMake(accessoryX, accessoryY, accessoryW, accessoryH);
}

#pragma mark - public

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
    _titleLabel = titleLabel;
    [self addSubview:titleLabel];
    
    UIImageView *accessoryImageView = [[UIImageView alloc] init];
    accessoryImageView.image = [UIImage imageNamed:@"profile_arrow"];
    _accessoryImageView = accessoryImageView;
    [self addSubview:accessoryImageView];
}

@end
