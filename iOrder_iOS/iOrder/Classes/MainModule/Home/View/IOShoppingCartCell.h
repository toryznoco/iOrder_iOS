//
//  IOShoppingCartCell.h
//  iOrder
//
//  Created by 易无解 on 17/04/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IOShoppingCartCell, IOShoppingCartItem;

@protocol IOShoppingCartCellDelegate <NSObject>

- (void)shoppingCartCell:(IOShoppingCartCell *)shoppingCartCell dishItem:(IOShoppingCartItem *)item clickedBtn:(UIButton *)btn;

@end

@interface IOShoppingCartCell : UITableViewCell

/** 菜名 */
@property (nonatomic, weak) UILabel *dishName;

/** 总价格 */
@property (nonatomic, weak) UILabel *dishTotalPrice;

/** 预定按钮 */
@property (nonatomic, weak) UIButton *orderBtn;

/** 当前菜品已点的份数 */
@property (nonatomic, weak) UILabel *dishCount;

/** 取消订购按钮 */
@property (nonatomic, weak) UIButton *unOrderBtn;

/**
 *  用于创建一个cell
 *
 *  @return 自定义的cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) IOShoppingCartItem *item;

@property (nonatomic, weak) id<IOShoppingCartCellDelegate> delegate;

@end
