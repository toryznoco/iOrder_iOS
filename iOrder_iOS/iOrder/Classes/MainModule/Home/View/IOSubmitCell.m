//
//  IOSubmitCell.m
//  iOrder
//
//  Created by 易无解 on 5/26/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOSubmitCell.h"

#pragma mark - implementation IOSubmitCell

@interface IOSubmitCell ()

@property (nonatomic, weak) UILabel *textName;
@property (nonatomic, weak) UILabel *detailLabel;

@end

@implementation IOSubmitCell

#pragma mark - privacy

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupAllChildView];
    }
    
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat textNameW = 150;
    CGFloat textNameH = 16;
    CGFloat textNameX = textNameW * 0.5 + 10;
    CGFloat textNameY = self.height * 0.5;
    _textName.frame = CGRectMake(0, 0, textNameW, textNameH);
    _textName.center = CGPointMake(textNameX, textNameY);
    
    CGFloat detailLabelW = 200;
    CGFloat detailLabelH = 16;
    CGFloat detailLabelX = self.width - 28 - 10 - detailLabelW * 0.5;
    CGFloat detailLabelY = textNameY;
    _detailLabel.frame = CGRectMake(0, 0, detailLabelW, detailLabelH);
    _detailLabel.center = CGPointMake(detailLabelX, detailLabelY);
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

- (void)setTitle:(NSString *)title {
    _title = title;
    
    _textName.text = title;
}

- (void)setDetail:(NSString *)detail {
    _detail = detail;
    
    _detailLabel.text = detail;
}

#pragma mark - custom methods

- (void)setupAllChildView {
    UILabel *textName = [[UILabel alloc] init];
    [self addSubview:textName];
    _textName = textName;
    
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.textAlignment = NSTextAlignmentRight;
    detailLabel.textColor = IORGBColor(180, 180, 180, 1);
    [self addSubview:detailLabel];
    _detailLabel = detailLabel;
}

@end


#pragma mark - implementation IOSubmitCell1

@interface IOSubmitCell1 ()

@property (nonatomic, weak) UILabel *textName;
@property (nonatomic, weak) UILabel *detailLabel;
@property (nonatomic, weak) UIImageView *accessoryImageView;
@end

@implementation IOSubmitCell1

#pragma mark - privacy

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupAllChildView];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat textNameW = 150;
    CGFloat textNameH = 16;
    CGFloat textNameX = textNameW * 0.5 + 10;
    CGFloat textNameY = self.height * 0.5;
    _textName.frame = CGRectMake(0, 0, textNameW, textNameH);
    _textName.center = CGPointMake(textNameX, textNameY);
    
    CGFloat accessoryW = 8;
    CGFloat accessoryH = 13;
    CGFloat accessoryX = self.width - 20 - accessoryW * 0.5;
    CGFloat accessoryY = self.height * 0.5;
    _accessoryImageView.frame = CGRectMake(0, 0, accessoryW, accessoryH);
    _accessoryImageView.center = CGPointMake(accessoryX, accessoryY);
    
    CGFloat detailLabelW = 200;
    CGFloat detailLabelH = 16;
    CGFloat detailLabelX = _accessoryImageView.x - 10 - detailLabelW * 0.5;
    CGFloat detailLabelY = self.height * 0.5;
    _detailLabel.frame = CGRectMake(0, 0, detailLabelW, detailLabelH);
    _detailLabel.center = CGPointMake(detailLabelX, detailLabelY);
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

- (void)setTitle:(NSString *)title {
    _title = title;
    
    _textName.text = title;
}

- (void)setDetail:(NSString *)detail {
    _detail = detail;
    
    _detailLabel.text = detail;
}

#pragma mark - custom methods

- (void)setupAllChildView {
    UILabel *textName = [[UILabel alloc] init];
    [self addSubview:textName];
    _textName = textName;
    
    UIImageView *accessoryImageView = [[UIImageView alloc] init];
    accessoryImageView.image = [UIImage imageNamed:@"profile_arrow"];
    [self addSubview:accessoryImageView];
    _accessoryImageView = accessoryImageView;
    
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.textAlignment = NSTextAlignmentRight;
    detailLabel.textColor = IORGBColor(180, 180, 180, 1);
    [self addSubview:detailLabel];
    _detailLabel = detailLabel;
}

@end


#pragma mark - implementation IOSubmitCell2

@interface IOSubmitCell2 ()

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *textName;
@property (nonatomic, weak) UILabel *detailLabel;

@end

@implementation IOSubmitCell2

#pragma mark - privacy

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupAllChildView];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat iconImageViewW = 22;
    CGFloat iconImageViewH = 18;
    CGFloat iconImageViewX = iconImageViewW * 0.5 + 10;
    CGFloat iconImageViewY = self.height * 0.5;
    _iconImageView.frame = CGRectMake(0, 0, iconImageViewW, iconImageViewH);
    _iconImageView.center = CGPointMake(iconImageViewX, iconImageViewY);
    
    CGFloat textNameW = 150;
    CGFloat textNameH = 16;
    CGFloat textNameX = CGRectGetMaxX(_iconImageView.frame) + textNameW * 0.5 + 10;
    CGFloat textNameY = self.height * 0.5;
    _textName.frame = CGRectMake(0, 0, textNameW, textNameH);
    _textName.center = CGPointMake(textNameX, textNameY);
    
    CGFloat detailLabelW = 100;
    CGFloat detailLabelH = 16;
    CGFloat detailLabelX = self.width - 20 - detailLabelW * 0.5;
    CGFloat detailLabelY = textNameY;
    _detailLabel.frame = CGRectMake(0, 0, detailLabelW, detailLabelH);
    _detailLabel.center = CGPointMake(detailLabelX, detailLabelY);
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

- (void)setIconName:(NSString *)iconName {
    _iconName = iconName;
    
    _iconImageView.image = [UIImage imageNamed:iconName];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    _textName.text = title;
}

- (void)setDetail:(NSString *)detail {
    _detail = detail;
    
    _detailLabel.text = detail;
}

#pragma mark - custom methods

- (void)setupAllChildView {
    UIImageView *iconImageView = [[UIImageView alloc] init];
    [self addSubview:iconImageView];
    _iconImageView = iconImageView;
    
    UILabel *textName = [[UILabel alloc] init];
    textName.textColor = IORGBColor(180, 180, 180, 1);
    [self addSubview:textName];
    _textName = textName;
    
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.textAlignment = NSTextAlignmentRight;
    detailLabel.textColor = IORGBColor(180, 180, 180, 1);
    [self addSubview:detailLabel];
    _detailLabel = detailLabel;
}

@end


#pragma mark - implementation IOSubmitCell3

@interface IOSubmitCell3 ()

@property (nonatomic, weak) UILabel *textName;
@property (nonatomic, weak) UILabel *detailLabel;

@end

@implementation IOSubmitCell3

#pragma mark - privacy

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
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

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat textNameW = 150;
    CGFloat textNameH = 16;
    CGFloat textNameX = textNameW * 0.5 + 10;
    CGFloat textNameY = self.height * 0.5;
    _textName.frame = CGRectMake(0, 0, textNameW, textNameH);
    _textName.center = CGPointMake(textNameX, textNameY);
    
    CGFloat detailLabelW = 150;
    CGFloat detailLabelH = 16;
    CGFloat detailLabelX = self.width - 20 - detailLabelW * 0.5;
    CGFloat detailLabelY = textNameY;
    _detailLabel.frame = CGRectMake(0, 0, detailLabelW, detailLabelH);
    _detailLabel.center = CGPointMake(detailLabelX, detailLabelY);
}

#pragma mark - public

- (void)setTitle:(NSString *)title {
    _title = title;
    
    _textName.text = title;
}

- (void)setDetail:(NSString *)detail {
    _detail = detail;
    
    _detailLabel.text = detail;
}


#pragma mark - custom methods

- (void)setupAllChildView {
    UILabel *textName = [[UILabel alloc] init];
    [self addSubview:textName];
    _textName = textName;
    
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:detailLabel];
    _detailLabel = detailLabel;
}

@end
