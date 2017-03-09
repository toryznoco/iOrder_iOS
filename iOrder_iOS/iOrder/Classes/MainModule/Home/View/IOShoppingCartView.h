//
//  IOShoppingCartView.h
//  iOrder
//
//  Created by 易无解 on 5/8/16.
//  Copyright © 2016 normcore. All rights reserved.
//  首页购物栏

#import <UIKit/UIKit.h>

#pragma mark - interface IOBadgeView
@interface IOBadgeView : UIButton

/**
 *  badge的值
 */
@property (nonatomic, copy) NSString *badgeValue;

@end


#pragma mark - interface IOShoppingView
@class IOShoppingCartView;
@protocol IOShoppingCartViewDelegate <NSObject>

- (void)shoppingCartView:(IOShoppingCartView *)shoppingCartView checkOutBtnClick:(UIButton *)btn;

@end

@interface IOShoppingCartView : UIView

@property (nonatomic, weak) UIButton *shoppingCarBtn;
@property (nonatomic, weak) UIView *checkOutView;
@property (nonatomic, weak) UILabel *totalPrice;
@property (nonatomic, weak) IOBadgeView *badge;
@property (nonatomic, weak) UIButton *checkOutBtn;
@property (nonatomic, weak) id<IOShoppingCartViewDelegate> delegate;

@property (nonatomic, assign) CGFloat totalPri;

@end
