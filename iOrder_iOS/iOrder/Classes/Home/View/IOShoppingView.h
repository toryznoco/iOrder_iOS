//
//  IOShoppingView.h
//  iOrder
//
//  Created by 易无解 on 5/8/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IOBadgeView.h"

@interface IOShoppingView : UIView

@property (nonatomic, weak) UIButton *shoppingCarBtn;
@property (nonatomic, weak) UIView *checkOutView;
@property (nonatomic, weak) UILabel *totalPrice;
@property (nonatomic, weak) IOBadgeView *badge;
@property (nonatomic, weak) UIButton *checkOutBtn;

@end
