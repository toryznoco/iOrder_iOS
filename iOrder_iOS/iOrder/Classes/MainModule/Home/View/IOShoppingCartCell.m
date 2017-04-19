//
//  IOShoppingCartCell.m
//  iOrder
//
//  Created by 易无解 on 17/04/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOShoppingCartCell.h"

#import "IODishInfo.h"
#import "IOShoppingCartResult.h"

@interface IOShoppingCartCell ()


@end

@implementation IOShoppingCartCell

#pragma mark - 系统回调函数

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //        1.设置界面相关函数
        [self setupAllSubViews];
        //        2.设置约束
        [self setupConstraints];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - 设置界面相关函数

- (void)setupAllSubViews {
    //    菜名
    UILabel *dishName = [[UILabel alloc] init];
    dishName.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:dishName];
    self.dishName = dishName;
    
    //    总价格
    UILabel *dishTotalPrice = [[UILabel alloc] init];
    dishTotalPrice.font = [UIFont systemFontOfSize:15];
    dishTotalPrice.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:dishTotalPrice];
    self.dishTotalPrice = dishTotalPrice;
    
    //    预定按钮
    UIButton *orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    orderBtn.tag = 1;
    [orderBtn setBackgroundImage:[UIImage imageNamed:@"add_button"] forState:UIControlStateNormal];
    [orderBtn addTarget:self action:@selector(orderBtnClicked:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:orderBtn];
    _orderBtn = orderBtn;
    
    //    当前菜品已点的份数
    UILabel *dishCount = [[UILabel alloc] init];
    dishCount.textAlignment = NSTextAlignmentCenter;
    dishCount.font = [UIFont systemFontOfSize:13];
    dishCount.text = @"0";
    [self addSubview:dishCount];
    _dishCount = dishCount;
    
    //    取消订购按钮
    UIButton *unOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    unOrderBtn.tag = 2;
    [unOrderBtn setBackgroundImage:[UIImage imageNamed:@"reduce_button"] forState:UIControlStateNormal];
    [unOrderBtn addTarget:self action:@selector(orderBtnClicked:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:unOrderBtn];
    _unOrderBtn = unOrderBtn;

}

#pragma mark - 设置约束相关函数

- (void)setupConstraints {
    __weak typeof(self) weakSelf = self;
    
    //    菜名
    [self.dishName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(150);
    }];
    
    //    订购按钮
    [self.orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-8);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.height.width.mas_equalTo(25);
    }];
    
    //    当前菜品已点的份数
    [self.dishCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.orderBtn.mas_left).offset(-2);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(25);
    }];
    
    //    取消订购按钮
    [self.unOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.dishCount.mas_left).offset(-2);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.height.width.mas_equalTo(25);
    }];
    
    //    总价格
    [self.dishTotalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.unOrderBtn.mas_left).offset(-2);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
}

#pragma mark - 外部接口

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuseId = @"ShoppingCartCell";
    id cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    return cell;
}

- (void)setItem:(IOShoppingCartItem *)item {
    _item = item;
    
    _dishName.text = item.goods.name;
    _dishTotalPrice.text = [NSString stringWithFormat:@"¥%.2lf", item.amount * item.goods.nowPrice];
    _dishCount.text = [NSString stringWithFormat:@"%ld", item.amount];
}

#pragma mark - 事件监听函数

- (void)orderBtnClicked:(UIButton *)btn {
    if (btn.tag == 1) {
        NSInteger currentCount = [_dishCount.text longLongValue] + 1;
        _dishTotalPrice.text = [NSString stringWithFormat:@"¥%.2lf", currentCount * self.item.goods.nowPrice];
        _dishCount.text = [NSString stringWithFormat:@"%ld", currentCount];
        self.item.amount = currentCount;
    } else {
        NSInteger currentCount = [_dishCount.text longLongValue] - 1;
        self.item.amount = currentCount;
        _dishTotalPrice.text = [NSString stringWithFormat:@"¥%.2lf", currentCount * self.item.goods.nowPrice];
        _dishCount.text = [NSString stringWithFormat:@"%ld", currentCount];
    }
    
    if ([self.delegate respondsToSelector:@selector(shoppingCartCell:dishItem:clickedBtn:)]) {
        [self.delegate shoppingCartCell:self dishItem:self.item clickedBtn:btn];
    }
}

@end
