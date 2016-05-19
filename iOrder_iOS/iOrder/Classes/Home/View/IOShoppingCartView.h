//
//  IOShoppingCartView.h
//  iOrder
//
//  Created by 易无解 on 5/8/16.
//  Copyright © 2016 易无解. All rights reserved.
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
@interface IOShoppingCartView : UIView

@property (nonatomic, weak) UIButton *shoppingCarBtn;
@property (nonatomic, weak) UIView *checkOutView;
@property (nonatomic, weak) UILabel *totalPrice;
@property (nonatomic, weak) IOBadgeView *badge;
@property (nonatomic, weak) UIButton *checkOutBtn;

@end



