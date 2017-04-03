//
//  IOOrderCell.h
//  iOrder
//
//  Created by Tory on 31/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "TRTableViewCell.h"
#import "YYKit.h"
#import "IOOrderLayout.h"
@protocol IOOrderCellDelegate;
@class IOOrder;
@class IOOrderCell;
#pragma mark - IOOrderTitleView
@interface IOOrderTitleView : UIView
/** 店铺名称 */
@property (nonatomic, strong) YYLabel *shopNameLabel;
/** 订单状态 */
@property (nonatomic, strong) YYLabel *statusLabel;
/** cell */
@property (nonatomic, weak) IOOrderCell *cell;
@end

#pragma mark - IOOrderInfoView
@interface IOOrderInfoView : UIView
/** 店铺Icon */
@property (nonatomic, strong) UIImageView *shopIconView;
/** 菜品数量Label */
@property (nonatomic, strong) YYLabel *goodsAmountLabel;
/** 菜品数量 */
@property (nonatomic, strong) YYLabel *goodsAmount;
/** 总价Label */
@property (nonatomic, strong) YYLabel *priceLabel;
/** 总价 */
@property (nonatomic, strong) YYLabel *price;
/** 下单时间Label */
@property (nonatomic, strong) YYLabel *orderTimeLabel;
/** 下单时间 */
@property (nonatomic, strong) YYLabel *orderTime;
/** cell */
@property (nonatomic, weak) IOOrderCell *cell;
@end

#pragma mark - IOOrderSubmitedBarView
@interface IOOrderSubmitedBarView : UIView
/** 去支付按钮 */
@property (nonatomic, strong) UIButton *payBtn;
/** 取消按钮 */
@property (nonatomic, strong) UIButton *cancelBtn;
/** cell */
@property (nonatomic, weak) IOOrderCell *cell;
/** 订单数据 */
@property (nonatomic, strong) IOOrder *order;
@end

#pragma mark - IOOrderPaidBarView
@interface IOOrderPaidBarView : UIView
/** 取消按钮 */
@property (nonatomic, strong) UIButton *cancelBtn;
/** cell */
@property (nonatomic, weak) IOOrderCell *cell;
/** 订单数据 */
@property (nonatomic, strong) IOOrder *order;
@end

#pragma mark - IOOrderCookingBarView
@interface IOOrderCookingBarView : UIView
/** 提醒商家发货 */
@property (nonatomic, strong) UIButton *alertBtn;
/** cell */
@property (nonatomic, weak) IOOrderCell *cell;
/** 订单数据 */
@property (nonatomic, strong) IOOrder *order;
@end

#pragma mark - IOOrderCookedBarView
@interface IOOrderCookedBarView : UIView
/** 去取餐 */
@property (nonatomic, strong) UIButton *getBtn;
/** cell */
@property (nonatomic, weak) IOOrderCell *cell;
/** 订单数据 */
@property (nonatomic, strong) IOOrder *order;
@end

#pragma mark - IOOrderReceiptBarView
@interface IOOrderReceiptBarView : UIView
/** 去评价 */
@property (nonatomic, strong) UIButton *commentBtn;
/** cell */
@property (nonatomic, weak) IOOrderCell *cell;
/** 订单数据 */
@property (nonatomic, strong) IOOrder *order;
@end

#pragma mark - IOOrderView
@interface IOOrderView : UIView
/** 容器 */
@property (nonatomic, strong) UIView *contentView;
/** 标题栏 */
@property (nonatomic, strong) IOOrderTitleView *titleView;
/** 订单信息 */
@property (nonatomic, strong) IOOrderInfoView *infoView;
/** 已下单状体底部条 */
@property (nonatomic, strong) IOOrderSubmitedBarView *submitedBarView;
/** 已支付状体底部条 */
@property (nonatomic, strong) IOOrderPaidBarView *paidBarView;
/** 已接单状体底部条 */
@property (nonatomic, strong) IOOrderCookingBarView *cookingBarView;
/** 烹饪完成状体底部条 */
@property (nonatomic, strong) IOOrderCookedBarView *cookedBarView;
/** 已收货状体底部条 */
@property (nonatomic, strong) IOOrderReceiptBarView *receiptBarView;
/** 数据布局 */
@property (nonatomic, strong) IOOrderLayout *layout;
/** cell */
@property (nonatomic, weak) IOOrderCell *cell;
@end

#pragma mark - IOOrderCell

@interface IOOrderCell : TRTableViewCell
/** 代理 */
@property (nonatomic, weak) id<IOOrderCellDelegate> delegate;
/** 订单cell */
@property (nonatomic, strong) IOOrderView *orderView;

/**
 设置ViewModel

 @param layout viewModel
 */
- (void)setLayout:(IOOrderLayout *)layout;

@end

@protocol IOOrderCellDelegate <NSObject>
@optional
- (void)payBtnDidClick:(UIButton *)btn order:(IOOrder *)order;
- (void)cancelBtnDidClick:(UIButton *)btn order:(IOOrder *)order;
- (void)alertBtnDidClick:(UIButton *)btn order:(IOOrder *)order;
- (void)getBtnDidClick:(UIButton *)btn order:(IOOrder *)order;
- (void)commentBtnDidClick:(UIButton *)btn order:(IOOrder *)order;
@end
