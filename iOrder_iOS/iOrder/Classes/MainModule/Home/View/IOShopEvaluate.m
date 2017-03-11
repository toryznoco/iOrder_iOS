//
//  IOShopEvaluate.m
//  iOrder
//
//  Created by 易无解 on 8/24/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import "IOShopEvaluate.h"

#pragma mark - implementation IOShopEvaluate

@interface IOShopEvaluate ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IOShopEvaluateHeaderView *evaluateHeaderView;
@property (nonatomic, weak) UITableView *evaluateFooterView;

@end

@implementation IOShopEvaluate

#pragma mark - privace

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kIOBackgroundColor;
        [self setupAllChildView];
    }
    
    return self;
}

#pragma mark - public

#pragma mark - custom

- (void)setupAllChildView {//添加所有子控件
//    1、评价头部的控件
    IOShopEvaluateHeaderView *evaluateHeaderView = [[IOShopEvaluateHeaderView alloc] init];
    [self addSubview:evaluateHeaderView];
    _evaluateHeaderView = evaluateHeaderView;
    
//    2、添加评论的tableView
    UITableView *evaluateFooterView = [[UITableView alloc] init];
    evaluateFooterView.tableFooterView = [[UIView alloc] init];
    evaluateFooterView.rowHeight = 92;
    evaluateFooterView.dataSource = self;
    evaluateFooterView.delegate = self;
    [self addSubview:evaluateFooterView];
    _evaluateFooterView = evaluateFooterView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IOShopEvaluateCell *cell = [IOShopEvaluateCell cellWithTableView:tableView];
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate



#pragma mark - masonry

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.evaluateHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(@102);
    }];
    
    [self.evaluateFooterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.evaluateHeaderView.mas_bottom).offset(14);
        make.left.equalTo(self).offset(8);
        make.bottom.equalTo(self);
        make.right.equalTo(self).offset(-8);
    }];
    
    [super updateConstraints];
}

@end

#pragma mark - implementation IOShopEvaluateHeaderView

@interface IOShopEvaluateHeaderView ()

@property (nonatomic, weak) UIView *headerView;
@property (nonatomic, weak) UIView *totalEvaluateView;
@property (nonatomic, weak) UILabel *evaluateValue;
@property (nonatomic, weak) UILabel *evaluateTitle;
@property (nonatomic, weak) UIView *paddingLine;
@property (nonatomic, weak) UILabel *serveTitle;
@property (nonatomic, weak) UILabel *qualityTitle;
@property (nonatomic, strong) NSMutableArray *serveStars;
@property (nonatomic, strong) NSMutableArray *qualityStars;
@property (nonatomic, weak) UILabel *serveValue;
@property (nonatomic, weak) UILabel *qualityValue;

@property (nonatomic, weak) UIView *footerView;
@property (nonatomic, strong) NSMutableArray *evaluateBtns;

@end

@implementation IOShopEvaluateHeaderView

#pragma mark - privace

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self setupAllChildView];
    }
    
    return self;
}

- (NSMutableArray *)serveStars {
    if (!_serveStars) {
        _serveStars = [NSMutableArray array];
    }
    
    return _serveStars;
}

- (NSMutableArray *)qualityStars {
    if (!_qualityStars) {
        _qualityStars = [NSMutableArray array];
    }
    
    return _qualityStars;
}

#pragma mark - public

#pragma mark - custom

- (void)setupAllChildView {
//    1、添加头部的view
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:headerView];
    _headerView = headerView;
//       a、添加头部view中的内容
    UIView *totalEvaluateView = [[UIView alloc] init];
    [headerView addSubview:totalEvaluateView];
    _totalEvaluateView = totalEvaluateView;
    UILabel *evaluateValue = [[UILabel alloc] init];
    evaluateValue.text  = @"4.8";
    evaluateValue.textColor = kIOThemeColors;
    evaluateValue.font = [UIFont systemFontOfSize:26];
    [totalEvaluateView addSubview:evaluateValue];
    _evaluateValue = evaluateValue;
    UILabel *evaluateTitle = [[UILabel alloc] init];
    evaluateTitle.text = @"整体评价";
    evaluateTitle.font = [UIFont systemFontOfSize:10];
    evaluateTitle.textColor = IORGBColor(139, 139, 139, 1);
    [totalEvaluateView addSubview:evaluateTitle];
    _evaluateTitle = evaluateTitle;
    
    UIView *paddingLine = [[UIView alloc] init];
    paddingLine.backgroundColor = kIOBackgroundColor;
    [headerView addSubview:paddingLine];
    _paddingLine = paddingLine;
    
    UILabel *serveTitle = [[UILabel alloc] init];
    serveTitle.text = @"配送服务";
    serveTitle.font = [UIFont systemFontOfSize:10];
    serveTitle.textColor = IORGBColor(139, 139, 139, 1);
    [headerView addSubview:serveTitle];
    _serveTitle = serveTitle;
    
    UILabel *qualityTitle = [[UILabel alloc] init];
    qualityTitle.text = @"商品质量";
    qualityTitle.font = [UIFont systemFontOfSize:10];
    qualityTitle.textColor = IORGBColor(139, 139, 139, 1);
    [headerView addSubview:qualityTitle];
    _qualityTitle = qualityTitle;
    
    for (NSInteger i = 0; i < 5; i++) {
        UIImageView *serveStar = [[UIImageView alloc] init];
        serveStar.image = [UIImage imageNamed:@"star_right"];
        [self.serveStars addObject:serveStar];
        [headerView addSubview:serveStar];
        
        UIImageView *qualityStar = [[UIImageView alloc] init];
        qualityStar.image = [UIImage imageNamed:@"star_right"];
        [self.qualityStars addObject:qualityStar];
        [headerView addSubview:qualityStar];
    }
    
    UILabel *serveValue = [[UILabel alloc] init];
    serveValue.text = @"8.0分";
    serveValue.font = [UIFont systemFontOfSize:10];
    serveValue.textColor = kIOThemeColors;
    [headerView addSubview:serveValue];
    _serveValue = serveValue;
    
    UILabel *qualityValue = [[UILabel alloc] init];
    qualityValue.text = @"8.0分";
    qualityValue.font = [UIFont systemFontOfSize:10];
    qualityValue.textColor = kIOThemeColors;
    [headerView addSubview:qualityValue];
    _qualityValue = qualityValue;
    
    
//    2、添加尾部的view
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:footerView];
    _footerView = footerView;
//       a、添加尾部view中的内容
    
    NSMutableArray *evaluateBtns = [NSMutableArray array];
    _evaluateBtns = evaluateBtns;
    for (NSInteger i = 0; i < 4; i++) {
        UIButton *evaluateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        evaluateBtn.titleLabel.font = [UIFont systemFontOfSize:8];
        [evaluateBtn setTitleColor:IORGBColor(139, 139, 139, 1) forState:UIControlStateNormal];
        [evaluateBtn setTitleColor:kIOThemeColors forState:UIControlStateSelected];
        [evaluateBtn setBackgroundImage:[UIImage imageNamed:@"ellipse_normal"] forState:UIControlStateNormal];
        [evaluateBtn setBackgroundImage:[UIImage imageNamed:@"ellipse_light"] forState:UIControlStateSelected];
        [footerView addSubview:evaluateBtn];
        [_evaluateBtns addObject:evaluateBtn];
    }
    
    ((UIButton *)_evaluateBtns[0]).selected = YES;
    for (NSInteger i = 0; i < self.evaluateBtns.count; i++) {
        switch (i) {
            case 0:
                [((UIButton *)_evaluateBtns[i]) setTitle:@"全部(78)" forState:UIControlStateNormal];
                break;
                
            case 1:
                [((UIButton *)_evaluateBtns[i]) setTitle:@"好评(74)" forState:UIControlStateNormal];
                break;
                
            case 2:
                [((UIButton *)_evaluateBtns[i]) setTitle:@"中评(2)" forState:UIControlStateNormal];
                break;
                
            case 3:
                [((UIButton *)_evaluateBtns[i]) setTitle:@"差评(2)" forState:UIControlStateNormal];
                break;
                
            default:
                break;
        }
    }
}

#pragma mark - masonry

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.and.right.equalTo(self);
        make.bottom.equalTo(self.footerView.mas_top).offset(-1);
        make.height.equalTo(@58);
    }];
    
    [self.totalEvaluateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerView).offset(33);
        make.centerY.equalTo(self.headerView);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
    }];
    
    [self.evaluateValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.totalEvaluateView);
        make.left.and.right.equalTo(self.totalEvaluateView);
        make.bottom.equalTo(self.evaluateTitle.mas_top);
    }];
    
    [self.evaluateTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.evaluateValue.mas_bottom);
        make.left.and.right.equalTo(self.totalEvaluateView);
        make.height.equalTo(@10);
        make.bottom.equalTo(self.totalEvaluateView);
    }];
    
    [self.paddingLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self.totalEvaluateView);
        make.left.equalTo(self.totalEvaluateView.mas_right).offset(29);
        make.width.equalTo(@1);
    }];
    
    [self.serveTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.paddingLine).offset(2);
        make.left.equalTo(self.paddingLine.mas_right).offset(15);
        make.width.equalTo(@40);
        make.height.equalTo(@10);
    }];
    
    [self.qualityTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.paddingLine).offset(-2);
        make.left.equalTo(self.paddingLine.mas_right).offset(15);
        make.width.equalTo(@40);
        make.height.equalTo(@10);
    }];
    
    [self.serveStars[0] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.serveTitle.mas_right).offset(10);
        make.top.and.bottom.equalTo(self.serveTitle);
        make.width.equalTo(@10);
    }];

    [self.qualityStars[0] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.qualityTitle.mas_right).offset(10);
        make.top.and.bottom.equalTo(self.qualityTitle);
        make.width.equalTo(@10);
    }];
    
    NSInteger elemCount = self.serveStars.count;
    NSInteger lastIndex = 0;
    
    for (NSInteger i = 1; i < elemCount; i++) {
        [self.serveStars[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(((UIImageView *)self.serveStars[lastIndex]).mas_right);
            make.top.and.bottom.equalTo(self.serveTitle);
            make.width.equalTo(@10);
        }];
        
        [self.qualityStars[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(((UIImageView *)self.qualityStars[lastIndex]).mas_right);
            make.top.and.bottom.equalTo(self.qualityTitle);
            make.width.equalTo(@10);
        }];
        
        lastIndex = i;
    }
    
    [self.serveValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(((UIImageView *)self.serveStars[lastIndex]).mas_right).offset(13);
        make.top.and.bottom.equalTo(self.serveTitle);
        make.width.equalTo(@30);
    }];
    
    [self.qualityValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(((UIImageView *)self.qualityStars[lastIndex]).mas_right).offset(13);
        make.top.and.bottom.equalTo(self.qualityTitle);
        make.width.equalTo(@30);
    }];
    
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom).offset(1);
        make.left.and.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    [self.evaluateBtns[0] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.footerView).offset(33);
        make.centerY.equalTo(self.footerView);
        make.width.equalTo(@35);
        make.height.equalTo(@20);
    }];
    
    lastIndex = 0;
    elemCount = self.evaluateBtns.count;
    for (NSInteger i = 1; i < elemCount; i++) {
        [self.evaluateBtns[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(((UIButton *)self.evaluateBtns[lastIndex]).mas_right).offset(4);
            make.centerY.equalTo(self.footerView);
            make.width.equalTo(@35);
            make.height.equalTo(@20);
        }];
        lastIndex = i;
    }
    
    [super updateConstraints];
}

@end

#pragma mark - IOShopEvaluateCell

@interface IOShopEvaluateCell ()

@property (nonatomic, weak) UIImageView *userIcon;
@property (nonatomic, weak) UILabel *telephone;
@property (nonatomic, strong) NSMutableArray *evaluateStars;
@property (nonatomic, weak) UILabel *evaluateDate;
@property (nonatomic, weak) UILabel *comments;

@end

@implementation IOShopEvaluateCell

#pragma mark - privace

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupAllChildView];
    }
    
    return self;
}

#pragma mark - public

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuseId = @"shopEvaluateCell";
    
    id cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    
    return cell;
}

#pragma mark - custom

- (void)setupAllChildView {//添加子控件
//    1、头像
    UIImageView *userIcon = [[UIImageView alloc] init];
    userIcon.image = [UIImage imageNamed:@"headportrait_4"];
    [self addSubview:userIcon];
    _userIcon = userIcon;
    
//    2、电话号码
    UILabel *telephone = [[UILabel alloc] init];
    telephone.text = @"123******89";
    telephone.font = [UIFont systemFontOfSize:10];
    [self addSubview:telephone];
    _telephone = telephone;
    
//    3、评价星星
    NSMutableArray *evaluateStars = [NSMutableArray array];
    _evaluateStars = evaluateStars;
    for (NSInteger i = 0; i < 5; i++) {
        UIImageView *evaluateStar = [[UIImageView alloc] init];
        evaluateStar.image = [UIImage imageNamed:@"star_right"];
        [self.evaluateStars addObject:evaluateStar];
        [self addSubview:evaluateStar];
    }
    
//    4、评价时间
    UILabel *evaluateDate = [[UILabel alloc] init];
    evaluateDate.font = [UIFont systemFontOfSize:10];
    evaluateDate.text = @"2016-03-24";
    [self addSubview:evaluateDate];
    _evaluateDate = evaluateDate;
    
//    5、评价内容
    UILabel *comments = [[UILabel alloc] init];
    comments.numberOfLines = 0;
    comments.font = [UIFont systemFontOfSize:13];
    comments.text = @"口感好，适合你的口味，咸淡适宜，你总想吃却怎么吃也吃不烦，就是百吃不厌，就证明这种食物好吃。";
    [self addSubview:comments];
    _comments = comments;
}

#pragma mark - masonry

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(4);
        make.left.equalTo(self).offset(8);
        make.width.and.height.equalTo(@33);
    }];
    
    [self.telephone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userIcon).offset(3);
        make.left.equalTo(self.userIcon.mas_right).offset(2);
        make.width.equalTo(@62);
        make.height.equalTo(@10);
    }];
    
    NSInteger lastIndex = 0;
    NSInteger elemCount = self.evaluateStars.count;
    [self.evaluateStars[lastIndex] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.userIcon).offset(-3);
        make.left.equalTo(self.userIcon.mas_right).offset(2);
        make.width.and.height.equalTo(@10);
    }];
    
    for (NSInteger i = 1; i < elemCount; i++) {
        [self.evaluateStars[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(((UIImageView *)self.evaluateStars[lastIndex]).mas_right);
            make.top.and.bottom.width.equalTo(self.evaluateStars[lastIndex]);
        }];
        lastIndex = i;
    }
    
    [self.evaluateDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(((UIImageView *)self.evaluateStars[lastIndex]).mas_right).offset(3);
        make.top.and.bottom.equalTo(self.evaluateStars[lastIndex]);
        make.width.equalTo(@60);
    }];
    
    [self.comments mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userIcon.mas_bottom).offset(3);
        make.left.equalTo(self).offset(8);
        make.right.equalTo(self).offset(-8);
        make.bottom.equalTo(self);
    }];
    
    [super updateConstraints];
}

@end
