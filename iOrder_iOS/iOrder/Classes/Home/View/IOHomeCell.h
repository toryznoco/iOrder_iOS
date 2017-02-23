//
//  IOHomeCell.h
//  iOrder
//
//  Created by 易无解 on 4/17/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDCycleScrollView.h"

@class IOShop;

#pragma mark - interface IOHomeCell
@interface IOHomeCell : UITableViewCell

/**
 *  店家数据
 */
@property (nonatomic, strong) IOShop *shop;

/**
 *  用于创建一个cell
 *
 *  @return 自定义的cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end


#pragma mark - interface IOHomeShopStarView
@interface IOHomeShopStarView : UIView

/**
 *  店铺评价
 */
@property (nonatomic, assign) float startCount;

@end

#pragma mark - interface IOHomeCellHeaderView

@interface IOHomeCellHeaderView : UIView

@end
